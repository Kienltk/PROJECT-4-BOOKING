package com.pro.booking.entity.model.address;

import com.pro.booking.core.base.BaseEntity;
import jakarta.persistence.*;
import lombok.*;

@EqualsAndHashCode(callSuper = true)
@Entity
@Table(name = "district")
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Getter
@Setter
public class District extends BaseEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String code;        // Mã huyện (VD: 001, 760)
    private String name;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "province_id")
    private Province province;
}

