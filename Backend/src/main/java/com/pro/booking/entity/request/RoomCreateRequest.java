package com.pro.booking.entity.request;

import com.pro.booking.core.base.BaseDTO;
import lombok.*;
import lombok.experimental.SuperBuilder;

import java.math.BigDecimal;
import java.util.List;

@EqualsAndHashCode(callSuper = true)
@Data
@NoArgsConstructor
@AllArgsConstructor
@SuperBuilder
public class RoomCreateRequest extends BaseDTO {
    private List<Long> categoryIds;
    private List<Long> documentIds;
    private List<Long> commonIds;
    private List<Long> tagIds;
    private Long roomId;
    private String title;
    private String subTitle;
    private String description;
    private BigDecimal pricePerNight;
    private BigDecimal cleaningFee;
    private BigDecimal serviceFee;
    private Long maxGuests;
    private Long roomCount;
    private Long bathroomCount;
}