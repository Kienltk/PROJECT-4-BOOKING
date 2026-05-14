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
public class PaymentDTO extends BaseDTO implements Serializable{
    private Long id;
    private Long bookingId;
    private BigDecimal amount;
    private BigDecimal transactionFee;
    private String paymentMethod;
    private LocalDateTime confirmedByHostAt;
    private String transactionId;
}