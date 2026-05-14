package com.pro.booking.entity.request;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.pro.booking.core.base.BaseDTO;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import lombok.experimental.SuperBuilder;

import java.io.Serializable;
import java.util.List;


@Data
@SuperBuilder
@NoArgsConstructor
@AllArgsConstructor
@EqualsAndHashCode(callSuper = true)
@JsonInclude(JsonInclude.Include.NON_NULL)
public class UserRegisterRequest extends BaseDTO implements Serializable {
    private Long id;
    private String addressDetail;
    private Long provinceId;
    private Long districtId;
    private Long wardId;
    private Long documentId;
    private String username;
    private String fullName;
    private String email;
    private String phone;
    private Long type;
    private List<String> documents;
    private String password;
    private String confirmPassword;
}