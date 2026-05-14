package com.pro.booking.service.impl;

import com.pro.booking.core.CRUDService;
import com.pro.booking.entity.DTO.WardDTO;
import com.pro.booking.entity.model.address.Ward;
import com.pro.booking.repository.WardRepository;
import com.pro.booking.service.WardService;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class WardServiceImpl extends CRUDService<Ward, WardDTO, Long, WardRepository> implements WardService {
    public WardServiceImpl(WardRepository repository) {
        super(repository, Ward.class, WardDTO.class);
    }

    @Override
    public List<WardDTO> findByDistrictId(Long districtId) {
        return mapper.toDtoList(repository.findByDistrictId(districtId));
    }
}
