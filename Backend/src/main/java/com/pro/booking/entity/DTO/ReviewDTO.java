package com.pro.booking.entity.DTO;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.pro.booking.core.base.BaseDTO;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import lombok.experimental.SuperBuilder;

import java.io.Serializable;

@Data
@SuperBuilder
@NoArgsConstructor
@AllArgsConstructor
@EqualsAndHashCode(callSuper = true)
@JsonInclude(JsonInclude.Include.NON_NULL)
public class ReviewDTO extends BaseDTO implements  Serializable{
    private Long id;
    private Long bookingId;
    private Long renterId;
    private Integer rating;
    private String comment;
}