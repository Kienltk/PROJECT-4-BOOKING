package com.pro.booking.entity.request;

import com.pro.booking.core.base.BaseDTO;
import lombok.Data;
import lombok.EqualsAndHashCode;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

@EqualsAndHashCode(callSuper = true)
@Data

public class DocumentRequest extends BaseDTO {
    private MultipartFile file;
    private List<MultipartFile> files;
    private Long id;
    private String info;
    private Boolean isPrimary;
}