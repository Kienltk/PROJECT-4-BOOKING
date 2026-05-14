package com.pro.booking.entity.request;

import com.pro.booking.core.base.BaseDTO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@EqualsAndHashCode(callSuper = true)
@Data
public class RoomFilterRequest extends BaseDTO {
    private Long categoryId;
    private Long commonId;
    private Long tagId;
    private String name;
    private String type;
    private String keyword;
}
