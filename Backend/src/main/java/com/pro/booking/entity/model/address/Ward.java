package com.pro.booking.entity.model.address;

import com.pro.booking.core.base.BaseEntity;
import jakarta.persistence.*;
import lombok.*;

@EqualsAndHashCode(callSuper = true)
@Entity
@Table(name = "ward")
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Getter
@Setter
public class Ward extends BaseEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String code;        // Mã xã (VD: 00001)
    private String name;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "district_id")
    private District district;
}
