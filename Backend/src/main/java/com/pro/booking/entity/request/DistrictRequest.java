package com.pro.booking.entity.request;

import com.pro.booking.core.base.BaseDTO;
import lombok.*;

import java.util.List;

@EqualsAndHashCode(callSuper = true)
@Data
@NoArgsConstructor
@AllArgsConstructor
public class DistrictRequest extends BaseDTO {
    private Long id;
    private String code;
    private String name;
    private List<WardRequest> wards;
}
