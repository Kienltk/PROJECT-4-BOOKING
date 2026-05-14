package com.pro.booking.service;

import com.pro.booking.entity.DTO.WardDTO;

import java.util.List;

public interface WardService {
    List<WardDTO> findByDistrictId(Long districtId);
}
