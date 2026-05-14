package com.pro.booking.entity.model.address;

import com.pro.booking.core.base.BaseEntity;
import jakarta.persistence.*;
import lombok.*;

@EqualsAndHashCode(callSuper = true)
@Entity
@Table(name = "province")
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Getter
@Setter
public class Province extends BaseEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String code;        // Mã tỉnh (VD: 01, 79)
    private String name;
}
