package com.pro.booking.controller;

import com.pro.booking.core.CRUDInterface;
import com.pro.booking.entity.DTO.BaseRequestDTO;
import com.pro.booking.entity.DTO.BookingDTO;
import com.pro.booking.entity.model.Booking;
import com.pro.booking.entity.request.BookingRequest;
import com.pro.booking.exception.AppException;
import com.pro.booking.middleware.permission.Permissions;
import com.pro.booking.repository.BookingRepository;
import com.pro.booking.service.impl.BookingServiceImpl;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping(value = "/api/booking")
public class BookingController extends CRUDInterface<Booking, Long, BookingDTO, BookingRepository, BookingServiceImpl> {
    protected BookingController(BookingServiceImpl service) {
        super(service, Booking.class, BookingDTO.class);
    }

    @PostMapping
    public Object createBooking(@RequestBody BaseRequestDTO<BookingRequest> requestDTO) {
        try {
            BookingDTO dto = service.createBooking(requestDTO.getPayload());
            return sendSuccess(dto);
        } catch (AppException e) {
            return sendError(e.getErrorCode(), e.getMessage());
        }
    }

    @PutMapping("/changeStatus")
    public Object changeStatus(@RequestBody BaseRequestDTO<BookingRequest> requestDTO) {
        try {
            BookingDTO dto = service.setBookingStatus(requestDTO.getPayload());
            return sendSuccess(dto);
        } catch (AppException e) {
            return sendError(e.getErrorCode(), e.getMessage());
        }
    }

    @GetMapping
    public Object getByRenter(@RequestBody BaseRequestDTO<BookingRequest> requestDTO) {
        try {
            requestDTO.getPayload().setRenterId(getLoginUser().getId());
            return service.getBookingsByRenter(requestDTO.getPayload());
        } catch (AppException e) {
            return sendError(e.getErrorCode(), e.getMessage());
        }
    }

    @GetMapping("/getBookings")
    public Object getBookings(@RequestBody BaseRequestDTO<BookingRequest> requestDTO) {
        try {
            return service.getBookings(requestDTO.getPayload());
        } catch (AppException e) {
            return sendError(e.getErrorCode(), e.getMessage());
        }
    }

    @GetMapping("/getBookingDetail")
    public Object getBookingDetail(@RequestBody BaseRequestDTO<BookingRequest> requestDTO) {
        try {
            BookingDTO data = service.getBookingDetail(requestDTO.getPayload());
            return sendSuccess(data);
        } catch (AppException e) {
            return sendError(e.getErrorCode(), e.getMessage());
        }
    }

    @GetMapping("/getBookingsByRenter")
    @Permissions(role = 1L)
    public Object getBookingsByRenter(@RequestBody BaseRequestDTO<BookingRequest> requestDTO) {
        try {
            return sendSuccess(service.getBookingsByRenter(requestDTO.getPayload()));
        } catch (AppException e) {
            return sendError(e.getErrorCode(), e.getMessage());
        }
    }


}
