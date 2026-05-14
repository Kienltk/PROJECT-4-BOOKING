package com.pro.booking.entity.request;

import com.pro.booking.core.base.BaseDTO;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

import java.util.List;

@EqualsAndHashCode(callSuper = true)
@Data
@NoArgsConstructor
@AllArgsConstructor
public class ProvinceRequest extends BaseDTO {
    private Long id;
    private String code;
    private String name;
    private List<DistrictRequest> districts;
}
