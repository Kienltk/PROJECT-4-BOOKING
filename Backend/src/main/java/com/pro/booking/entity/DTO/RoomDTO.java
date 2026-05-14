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
import java.util.Set;

@Data
@SuperBuilder
@NoArgsConstructor
@AllArgsConstructor
@EqualsAndHashCode(callSuper = true)
@JsonInclude(JsonInclude.Include.NON_NULL)
public class RoomDTO extends BaseDTO implements  Serializable {
    private Long id;
    private Long hostId;
    private Set<Long> categoryIds;
    private Set<CategoryDTO> categories;
    private Set<Long> commonIds;
    private Set<CategoryDTO> commons;
    private Set<Long> tagIds;
    private Set<CategoryDTO> tags;
    private Set<Long> documentIds;
    private Set<DocumentDTO> documents;
    private String title;
    private String subTitle;
    private String description;
    private BigDecimal pricePerNight;
    private BigDecimal cleaningFee;
    private BigDecimal serviceFee;
    private Integer maxGuests;
    private Integer roomCount;
    private Integer bathroomCount;
    private String amenities;
}