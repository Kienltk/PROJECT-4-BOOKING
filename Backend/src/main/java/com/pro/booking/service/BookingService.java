package com.pro.booking.service;

import com.pro.booking.entity.DTO.BookingDTO;
import com.pro.booking.entity.request.BookingRequest;
import com.pro.booking.entity.request.CallbackBalanceRequest;
import com.pro.booking.exception.AppException;
import org.springframework.data.domain.Page;

public interface BookingService {
    public BookingDTO createBooking(BookingRequest request) throws AppException;

    public Page<BookingDTO> getBookingsByRenter(BookingRequest request) throws AppException;

    public BookingDTO setBookingStatus(BookingRequest request) throws AppException;

    public void changeStatus(BookingDTO bookingDTO, Long status) throws AppException;

    public void changeBalance(CallbackBalanceRequest request) throws AppException;

    public Page<BookingDTO> getBookings(BookingRequest request);

    public BookingDTO getBookingDetail(BookingRequest request) throws AppException;
}
