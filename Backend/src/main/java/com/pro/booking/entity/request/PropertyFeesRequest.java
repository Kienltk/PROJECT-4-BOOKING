package com.pro.booking.entity.request;

import com.pro.booking.core.base.BaseDTO;
import lombok.Data;
import lombok.EqualsAndHashCode;

import java.math.BigDecimal;
import java.util.Map;

@EqualsAndHashCode(callSuper = true)
@Data
public class PropertyFeesRequest extends BaseDTO {
    private BigDecimal cleaningFee;
    private BigDecimal serviceFee;
    private Map<String, BigDecimal> otherFees;
}