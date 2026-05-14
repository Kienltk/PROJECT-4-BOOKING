package com.pro.booking.entity.DTO;
import com.pro.booking.core.base.BaseDTO;
import lombok.*;
import lombok.experimental.SuperBuilder;

import java.io.Serializable;

@EqualsAndHashCode(callSuper = true)
@Data
@SuperBuilder
@NoArgsConstructor
@AllArgsConstructor
public class DocumentDTO extends BaseDTO implements Serializable {
    private Long id;
    private String imageUrl;
    private String type;
    private String info;
    private Boolean isPrimary;
}