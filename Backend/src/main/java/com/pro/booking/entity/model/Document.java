package com.pro.booking.entity.model;

import com.pro.booking.core.base.BaseEntity;
import lombok.*;
import jakarta.persistence.*;

@EqualsAndHashCode(callSuper = true)
@Entity
@Table(name = "ducuments")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Document extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "image_url", nullable = false)
    private String imageUrl;

    @Column(name = "type", nullable = false)
    private String type;

    @Column(name = "info", nullable = true)
    private String info;

    @Column(name = "is_primary")
    @Builder.Default
    private Boolean isPrimary = false;
}
