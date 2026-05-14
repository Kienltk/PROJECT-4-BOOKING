package com.pro.booking.entity.request;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.pro.booking.core.base.BaseDTO;
import lombok.*;
import lombok.experimental.SuperBuilder;

import java.time.LocalDateTime;

@EqualsAndHashCode(callSuper = true)
@Data
@NoArgsConstructor
@AllArgsConstructor
@SuperBuilder
public class BookingRequest extends BaseDTO {

    private Long renterId;
    private Long bookingId;
    private Long roomId;
    private Long paymentMethod;
    private String description;
    private String transCode;

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime checkInDate;

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime checkOutDate;

    @Builder.Default
    private Integer guests = 1;

}
