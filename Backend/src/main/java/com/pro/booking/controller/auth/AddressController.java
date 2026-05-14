package com.pro.booking.controller.auth;

import com.pro.booking.core.CRUDInterface;
import com.pro.booking.entity.DTO.BaseRequestDTO;
import com.pro.booking.entity.DTO.ProvinceDTO;
import com.pro.booking.entity.model.address.Province;
import com.pro.booking.entity.request.DistrictRequest;
import com.pro.booking.entity.request.ProvinceRequest;
import com.pro.booking.repository.ProvinceRepository;
import com.pro.booking.service.impl.DistrictServiceImpl;
import com.pro.booking.service.impl.ProvinceServiceImpl;
import com.pro.booking.service.impl.WardServiceImpl;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;


@RestController
@Slf4j
@RequestMapping(value = "/api/auth/address")
public class AddressController extends CRUDInterface<Province, Long, ProvinceDTO, ProvinceRepository, ProvinceServiceImpl> {
    protected AddressController(ProvinceServiceImpl service, WardServiceImpl wardService, DistrictServiceImpl districtService) {
        super(service, Province.class, ProvinceDTO.class);
        this.wardService = wardService;
        this.districtService = districtService;
    }

    private final WardServiceImpl wardService;
    private final DistrictServiceImpl districtService;

    @GetMapping("/provinces")
    public Object getAllProvinces() {
        return sendSuccess(super.service.getAll());
    }

    @GetMapping("/districts")
    public Object getAllDistricts(@RequestBody BaseRequestDTO<ProvinceRequest> requestDTO) {
        return sendSuccess(districtService.findByProvinceId(requestDTO.getPayload().getId()));
    }

    @GetMapping("/wards")
    public Object getAlWard(@RequestBody BaseRequestDTO<DistrictRequest> requestDTO) {
        return sendSuccess(wardService.findByDistrictId(requestDTO.getPayload().getId()));
    }

}
