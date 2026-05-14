package com.pro.booking.entity.model;

import com.pro.booking.core.base.BaseEntity;
import jakarta.persistence.*;
import lombok.*;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Entity
@Table(name = "payments")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Payment extends BaseEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "booking_id", nullable = false)
    private Booking booking;

    @Column(nullable = false)
    private BigDecimal amount;

    @Column(name = "transaction_fee", nullable = false)
    private BigDecimal transactionFee = BigDecimal.ZERO;

    @Column(name = "payment_method")
    private String paymentMethod;

    @Column(nullable = false)
    private Long status = 1L;

    @Column(name = "confirmed_by_host_at")
    private LocalDateTime confirmedByHostAt;

    @Column(name = "transaction_id")
    private String transactionId;
}