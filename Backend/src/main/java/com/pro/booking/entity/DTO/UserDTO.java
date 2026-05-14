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
public class UserDTO extends BaseDTO implements Serializable {
    private Long id;
    private String username;
    private String fullName;
    private String email;
    private String phone;
    private Long addressId;
    private String type;
    private String password;
    private String addressDetail;
    private String provinceName;
    private String districtName;
    private String wardName;
    private String address;
    private DocumentDTO avatar;
}