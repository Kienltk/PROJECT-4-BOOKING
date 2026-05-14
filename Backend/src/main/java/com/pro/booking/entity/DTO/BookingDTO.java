package com.pro.booking.entity.DTO;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.pro.booking.core.base.BaseDTO;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import lombok.experimental.SuperBuilder;

import java.io.Serializable;
import java.math.BigDecimal;
import java.time.LocalDateTime;

@Data
@SuperBuilder
@NoArgsConstructor
@AllArgsConstructor
@EqualsAndHashCode(callSuper = true)
@JsonInclude(JsonInclude.Include.NON_NULL)
public class BookingDTO extends BaseDTO implements Serializable{
    private Long id;
    private Long renterId;
    private Long propertyId;
    private Long bookingStatus;
    private LocalDateTime checkInDate;
    private LocalDateTime checkOutDate;
    private BigDecimal pricePerNight;
    private String additionalFees;
    private String transCode;
    private BigDecimal totalPrice;
    private Integer guests;
    private RoomDTO roomDTO;
    private UserDTO renterDTO;
}