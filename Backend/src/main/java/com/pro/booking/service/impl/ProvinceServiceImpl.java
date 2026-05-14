package com.pro.booking.service.impl;

import com.pro.booking.core.CRUDService;
import com.pro.booking.entity.DTO.ProvinceDTO;
import com.pro.booking.entity.model.address.Province;
import com.pro.booking.repository.ProvinceRepository;
import com.pro.booking.service.ProvinceService;
import org.springframework.stereotype.Service;

@Service
public class ProvinceServiceImpl extends CRUDService<Province, ProvinceDTO, Long, ProvinceRepository> implements ProvinceService {
    public ProvinceServiceImpl(ProvinceRepository repository) {
        super(repository, Province.class, ProvinceDTO.class);
    }

}
