package com.pro.booking.entity.DTO;


import com.pro.booking.core.base.BaseDTO;
import lombok.*;
import lombok.experimental.SuperBuilder;

import java.io.Serializable;

@EqualsAndHashCode(callSuper = true)
@Data
@NoArgsConstructor
@AllArgsConstructor
@SuperBuilder
@Getter
@Setter
public class WardDTO extends BaseDTO implements Serializable {
    private Long id;
    private String code;
    private String name;

    private Long districtId;
    private String districtName;
}
