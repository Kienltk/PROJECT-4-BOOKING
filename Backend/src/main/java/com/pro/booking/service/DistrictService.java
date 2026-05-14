package com.pro.booking.service;

import com.pro.booking.entity.DTO.DistrictDTO;

import java.util.List;

public interface DistrictService {
    List<DistrictDTO> findByProvinceId(Long provinceId);
}
