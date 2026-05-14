package com.pro.booking.repository;

import com.pro.booking.entity.model.Booking;
import io.lettuce.core.dynamic.annotation.Param;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

@Repository
public interface BookingRepository extends JpaRepository<Booking, Long> {

    @Query("""
        SELECT b FROM Booking b
        JOIN FETCH b.room r
        WHERE b.renter.id = :renterId
    """)
    Page<Booking> findByRenterId(@Param("renterId") Long renterId, Pageable pageable);
}
