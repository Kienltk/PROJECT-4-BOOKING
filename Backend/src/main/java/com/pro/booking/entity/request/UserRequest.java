package com.pro.booking.entity.request;

import com.pro.booking.core.base.BaseDTO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@EqualsAndHashCode(callSuper = true)
@Data
public class UserRequest extends BaseDTO {
    private Long id;
    private String fullName;
    private String email;
    private String password;
    private Long type;
    private String phone;
    private String documents;
    private Long wardId;
    private String houseNumber;
    private String postalCode;
    private String latitude;
    private String longitude;
}