package com.pro.booking.repository;

import com.pro.booking.entity.model.AuditLog;
import com.pro.booking.entity.model.address.Province;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ProvinceRepository extends JpaRepository<Province, Long> {
}
