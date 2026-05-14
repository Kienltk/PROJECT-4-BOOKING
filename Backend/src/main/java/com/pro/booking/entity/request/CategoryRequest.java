package com.pro.booking.entity.request;

import com.pro.booking.core.base.BaseDTO;
import com.pro.booking.entity.DTO.CategoryDTO;
import lombok.Data;
import lombok.EqualsAndHashCode;

import java.util.List;

@EqualsAndHashCode(callSuper = true)
@Data
public class CategoryRequest extends BaseDTO {
    private Long id;
    private String name;
    private String type;
    private String info;
    private String description;
    private String icon;
    private List<CategoryDTO> categoryDTOS;
}
