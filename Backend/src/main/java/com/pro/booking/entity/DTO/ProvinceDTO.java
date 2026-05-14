package com.pro.booking.entity.DTO;

import com.pro.booking.core.base.BaseDTO;
import lombok.*;
import lombok.experimental.SuperBuilder;

import java.io.Serializable;
import java.util.List;

@EqualsAndHashCode(callSuper = true)
@Data
@NoArgsConstructor
@AllArgsConstructor
@SuperBuilder
@Getter
@Setter
public class ProvinceDTO extends BaseDTO implements Serializable {
    private Long id;
    private String code;
    private String name;

    private List<DistrictDTO> districts;
}
