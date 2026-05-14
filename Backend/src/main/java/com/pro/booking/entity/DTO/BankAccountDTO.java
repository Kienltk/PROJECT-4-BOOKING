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
public class BankAccountDTO extends BaseDTO implements  Serializable {
    private Long id;
    private Long userId;
    private String bankName;
    private String accountNumber;
    private String accountHolder;
    private String swiftCode;
}