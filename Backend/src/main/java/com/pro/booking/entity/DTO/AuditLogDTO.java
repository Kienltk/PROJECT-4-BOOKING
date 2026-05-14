package com.pro.booking.entity.DTO;
import com.pro.booking.core.base.BaseDTO;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.SuperBuilder;

import java.io.Serializable;
import java.time.LocalDateTime;

@EqualsAndHashCode(callSuper = true)
@Data
@SuperBuilder
public class AuditLogDTO extends BaseDTO implements Serializable {
    private Long id;
    private Long userId;
    private String action;
    private String details;
    private LocalDateTime createdAt;
}
