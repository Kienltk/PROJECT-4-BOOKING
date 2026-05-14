package com.pro.booking.service.impl;

import com.pro.booking.core.CRUDService;
import com.pro.booking.entity.DTO.DistrictDTO;
import com.pro.booking.entity.DTO.ProvinceDTO;
import com.pro.booking.entity.model.address.District;
import com.pro.booking.entity.model.address.Province;
import com.pro.booking.repository.DistrictRepository;
import com.pro.booking.repository.ProvinceRepository;
import com.pro.booking.service.DistrictService;
import com.pro.booking.service.ProvinceService;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class DistrictServiceImpl extends CRUDService<District, DistrictDTO, Long, DistrictRepository> implements DistrictService {
    public DistrictServiceImpl(DistrictRepository repository) {
        super(repository, District.class, DistrictDTO.class);
    }

    @Override
    public List<DistrictDTO> findByProvinceId(Long provinceId) {
        return mapper.toDtoList(repository.findByProvinceId(provinceId));
    }
}
