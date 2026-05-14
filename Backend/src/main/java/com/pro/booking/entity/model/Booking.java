package com.pro.booking.entity.model;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.pro.booking.core.base.BaseEntity;
import jakarta.persistence.*;
import lombok.*;
import java.math.BigDecimal;
import java.time.LocalDateTime;
@EqualsAndHashCode(callSuper = true)
@Entity
@Table(name = "bookings")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Booking extends BaseEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "renter_id", nullable = false)
    private User renter;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "room_id", nullable = false)
    private Room room;

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @Column(name = "check_in_date", nullable = false)
    private LocalDateTime checkInDate;

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @Column(name = "check_out_date", nullable = false)
    private LocalDateTime checkOutDate;

    @Builder.Default
    private Integer guests = 1;

    @Column(name = "price_per_night", nullable = false, precision = 15, scale = 2)
    private BigDecimal pricePerNight;

    @Column(name = "booking_status", nullable = false)
    private Long bookingStatus;

    @Column(name = "payment_method", nullable = false)
    private Long paymentMethod;

    @Column(name = "description", nullable = true)
    private String description;

    @Column(name = "trans_code", nullable = false)
    private String transCode;

    @Column(name = "cleaning_fee", precision = 10, scale = 2)
    @Builder.Default
    private BigDecimal cleaningFee = BigDecimal.ZERO;

    @Column(name = "service_fee", precision = 10, scale = 2)
    @Builder.Default
    private BigDecimal serviceFee = BigDecimal.ZERO;

    @Column(name = "total_nights", nullable = false)
    private Integer totalNights;

    @Column(name = "total_price", nullable = false, precision = 15, scale = 2)
    private BigDecimal totalPrice;

}