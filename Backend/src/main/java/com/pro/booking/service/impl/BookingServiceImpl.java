package com.pro.booking.service.impl;

import com.pro.booking.constants.Constants;
import com.pro.booking.constants.ErrorResponse;
import com.pro.booking.entity.DTO.BookingDTO;
import com.pro.booking.entity.DTO.DocumentDTO;
import com.pro.booking.entity.DTO.RoomDTO;
import com.pro.booking.entity.DTO.UserDTO;
import com.pro.booking.entity.model.Booking;
import com.pro.booking.entity.model.Room;
import com.pro.booking.entity.model.User;
import com.pro.booking.entity.request.BookingRequest;
import com.pro.booking.entity.request.CallbackBalanceRequest;
import com.pro.booking.exception.AppException;
import com.pro.booking.repository.BookingRepository;
import com.pro.booking.service.BookingService;
import com.pro.booking.core.CRUDService;
import com.pro.booking.service.common.rabbit.producer.BookingProducer;
import com.pro.booking.utils.AppUtils;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.time.temporal.ChronoUnit;
import java.util.Objects;

@Service
public class BookingServiceImpl extends CRUDService<Booking, BookingDTO, Long, BookingRepository> implements BookingService {
    public BookingServiceImpl(BookingRepository repository, RoomServiceImpl roomService, BookingProducer bookingProducer) {
        super(repository, Booking.class, BookingDTO.class);
        this.roomService = roomService;
        this.bookingProducer = bookingProducer;
    }

    final RoomServiceImpl roomService;
    final BookingProducer bookingProducer;

    @Override
    public BookingDTO createBooking(BookingRequest request) throws AppException {
        Room room = roomService.get(request.getRoomId());
        if (room == null) {
            throw new AppException(ErrorResponse.ROOM_NOT_FOUND);
        }
        if (request.getPaymentMethod() == null) {
            throw new AppException(ErrorResponse.PAYMENT_METHOD_REQUIRED);
        }

        long nights = ChronoUnit.DAYS.between(request.getCheckInDate(), request.getCheckOutDate());
        if (nights <= 0) {
            throw new AppException(ErrorResponse.INVALID_DATE_RANGE);
        }

        BigDecimal basePrice = room.getPricePerNight() != null ? room.getPricePerNight() : BigDecimal.ZERO;
        BigDecimal cleaningFee = room.getCleaningFee() != null ? room.getCleaningFee() : BigDecimal.ZERO;
        BigDecimal serviceFee = room.getServiceFee() != null ? room.getServiceFee() : BigDecimal.ZERO;

        BigDecimal totalPrice = basePrice
                .multiply(BigDecimal.valueOf(nights))
                .add(cleaningFee)
                .add(serviceFee);

        if (room.getRoomCount() == null || room.getRoomCount() <= 0) {
            throw new AppException(ErrorResponse.ROOM_OUT_OF_STOCK);
        }

        Booking booking = Booking.builder()
                .room(Room.builder().id(request.getRoomId()).build())
                .renter(User.builder().id(getLoginUser().getId()).build())
                .checkInDate(request.getCheckInDate())
                .checkOutDate(request.getCheckOutDate())
                .guests(request.getGuests() == null ? 1 : request.getGuests())
                .pricePerNight(basePrice)
                .cleaningFee(cleaningFee)
                .serviceFee(serviceFee)
                .transCode(generateCode("BK"))
                .totalNights((int) nights)
                .bookingStatus(Objects.equals(request.getPaymentMethod(), Constants.PAYMENT_METHOD.BANK) ? Constants.BOOKING_STATUS.WAITING_PAYMENT : Constants.BOOKING_STATUS.SUCCESS)
                .totalPrice(totalPrice)
                .paymentMethod(request.getPaymentMethod())
                .build();
        room.setRoomCount(room.getRoomCount() - 1);
        roomService.update(room);
        booking = super.create(booking);
        return mapper.toDto(booking);
    }


    @Override
    public Page<BookingDTO> getBookingsByRenter(BookingRequest request) {
        Pageable pageable = PageRequest.of(getPage(request.getPage()), getLimit(request.getLimit()), Sort.by("checkInDate").descending());
        Page<Booking> page = repository.findByRenterId(request.getRenterId(), pageable);
        return page.map(entity -> {
            BookingDTO dto = mapper.toDto(entity);
            dto.setRoomDTO(modelMapper.map(entity.getRoom(), RoomDTO.class));
            return dto;
        });
    }

    @Override
    public BookingDTO getBookingDetail(BookingRequest request) throws AppException {
        Booking booking = repository.findById(request.getBookingId())
                .orElseThrow(() -> new AppException(ErrorResponse.BOOKING_NOT_FOUND));
        BookingDTO dto = mapper.toDto(booking);
        dto.setRoomDTO(modelMapper.map(booking.getRoom(), RoomDTO.class));
        dto.setRenterDTO(modelMapper.map(booking.getRenter(), UserDTO.class));
        dto.getRenterDTO().setPassword(null);
        dto.getRenterDTO().setAddress(getFullAddress(booking.getRenter()));
        return dto;
    }


    @Override
    public Page<BookingDTO> getBookings(BookingRequest request) {
        Pageable pageable = PageRequest.of(
                getPage(request.getPage()),
                getLimit(request.getLimit()),
                Sort.by("checkInDate").descending()
        );
        return repository.findAll(pageable).map(entity -> {
            BookingDTO dto = mapper.toDto(entity);
            dto.setRoomDTO(modelMapper.map(entity.getRoom(), RoomDTO.class));
            dto.setRenterDTO(modelMapper.map(entity.getRoom(), UserDTO.class));
            dto.getRenterDTO().setPassword(null);
            if (!AppUtils.isNullOrEmpty(dto.getRenterDTO().getAvatar())) {
                dto.getRenterDTO().setAvatar(modelMapper.map(dto.getRenterDTO().getAvatar(), DocumentDTO.class));
            }
            dto.getRenterDTO().setAddress(getFullAddress(entity.getRenter()));
            return dto;
        });
    }

    @Override
    public BookingDTO setBookingStatus(BookingRequest request) throws AppException {
        Booking booking = repository.findById(request.getBookingId())
                .orElseThrow(() -> new AppException(ErrorResponse.BOOKING_NOT_FOUND));
        Room room = booking.getRoom();
        booking.setStatus(request.getStatus());
        booking.setDescription(request.getDescription());
        if (Objects.equals(request.getStatus(), Constants.BOOKING_STATUS.USER_CANCEL)) {
            room.setRoomCount(room.getRoomCount() + 1L);
        } else if (Objects.equals(request.getStatus(), Constants.BOOKING_STATUS.SUCCESS)) {
            room.setRoomCount(room.getRoomCount() - 1L);
        }
        roomService.update(room);
        return mapper.toDto(super.update(booking));
    }

    @Override
    public void changeStatus(BookingDTO bookingDTO, Long status) throws AppException {
        bookingDTO.setBookingStatus(status);
        super.update(bookingDTO);
    }

    @Override
    public void changeBalance(CallbackBalanceRequest request) throws AppException {
        AppUtils.DEBUG("****************** changeBalance ******************");
        AppUtils.DEBUG(request);
    }
}
