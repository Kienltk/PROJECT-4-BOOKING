package com.pro.booking.entity.request;

import com.pro.booking.core.base.BaseDTO;
import lombok.*;

@EqualsAndHashCode(callSuper = true)
@Data
@NoArgsConstructor
@AllArgsConstructor
public class WardRequest extends BaseDTO {
    private Long id;
    private String code;
    private String name;
}