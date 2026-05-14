package com.pro.booking.service.impl;

import com.pro.booking.entity.model.address.District;
import com.pro.booking.entity.model.address.Province;
import com.pro.booking.entity.model.address.Ward;
import com.pro.booking.entity.request.DistrictRequest;
import com.pro.booking.entity.request.ProvinceRequest;
import com.pro.booking.entity.request.WardRequest;
import com.pro.booking.repository.DistrictRepository;
import com.pro.booking.repository.ProvinceRepository;
import com.pro.booking.repository.WardRepository;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

@Service
@RequiredArgsConstructor
public class LocationSyncServiceImpl {

    private final ProvinceRepository provinceRepository;
    private final DistrictRepository districtRepository;
    private final WardRepository wardRepository;
    private final RestTemplate restTemplate = new RestTemplate();

    @Transactional
    public void sync() {
        String url = "https://provinces.open-api.vn/api/?depth=3";
        ResponseEntity<ProvinceRequest[]> response =
                restTemplate.getForEntity(url, ProvinceRequest[].class);

        if (response.getBody() == null) return;

        for (ProvinceRequest p : response.getBody()) {
            Province province = provinceRepository.save(
                    Province.builder()
                            .code(p.getCode())
                            .name(p.getName())
                            .build()
            );

            for (DistrictRequest d : p.getDistricts()) {
                District district = districtRepository.save(
                        District.builder()
                                .code(d.getCode())
                                .name(d.getName())
                                .province(province)
                                .build()
                );

                for (WardRequest w : d.getWards()) {
                    wardRepository.save(
                            Ward.builder()
                                    .code(w.getCode())
                                    .name(w.getName())
                                    .district(district)
                                    .build()
                    );
                }
            }
        }
    }
}
