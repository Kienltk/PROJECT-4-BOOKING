package com.pro.booking.service.impl;

import com.pro.booking.constants.Constants;
import com.pro.booking.constants.ErrorResponse;
import com.pro.booking.entity.DTO.UserDTO;
import com.pro.booking.entity.model.Document;
import com.pro.booking.entity.model.User;
import com.pro.booking.entity.model.address.District;
import com.pro.booking.entity.model.address.Province;
import com.pro.booking.entity.model.address.Ward;
import com.pro.booking.entity.request.UserRegisterRequest;
import com.pro.booking.exception.AppException;
import com.pro.booking.repository.*;
import com.pro.booking.core.CRUDService;
import com.pro.booking.service.UserService;
import org.springframework.stereotype.Service;

import java.util.Objects;

@Service
public class UserServiceImpl extends CRUDService<User, UserDTO, Long, UserRepository> implements UserService {

    public UserServiceImpl(UserRepository repository, ProvinceRepository provinceRepository, DistrictRepository districtRepository, WardRepository wardRepository, DocumentRepository documentRepository) {
        super(repository, User.class, UserDTO.class);
        this.provinceRepository = provinceRepository;
        this.districtRepository = districtRepository;
        this.wardRepository = wardRepository;
        this.documentRepository = documentRepository;
    }

    private final ProvinceRepository provinceRepository;
    private final DistrictRepository districtRepository;
    private final WardRepository wardRepository;
    private final DocumentRepository documentRepository;


    @Override
    public User checkExits(String username) throws AppException {
        return repository.findByUsername(username)
                .orElseThrow(() -> new AppException(ErrorResponse.USER_NOT_FOUND));
    }

    @Override
    public UserDTO create(UserRegisterRequest request) throws AppException {
        if (!Objects.equals(request.getPassword(), request.getConfirmPassword())) {
            throw new AppException(ErrorResponse.ERROR_PASSWORD);
        }
        Province province = request.getProvinceId() != null
                ? provinceRepository.findById(request.getProvinceId())
                .orElseThrow(() -> new AppException(ErrorResponse.PROVINCE_NOT_FOUND))
                : null;

        Document document = request.getDocumentId() != null
                ? documentRepository.findById(request.getDocumentId())
                .orElseThrow(() -> new AppException(ErrorResponse.DOCUMENT_NOT_FOUND))
                : null;

        District district = request.getDistrictId() != null
                ? districtRepository.findById(request.getDistrictId())
                .orElseThrow(() -> new AppException(ErrorResponse.DISTRICT_NOT_FOUND))
                : null;

        Ward ward = request.getWardId() != null
                ? wardRepository.findById(request.getWardId())
                .orElseThrow(() -> new AppException(ErrorResponse.WARD_NOT_FOUND))
                : null;
        long count = super.cound();
        if (count == 0) {
            request.setType(Constants.ROLE.ADMIN);
        } else {
            request.setType(Constants.ROLE.USER);
        }
        request.setPassword(hashPassword(request.getPassword()));
        request.setStatus(Constants.ACCOUNT_STATUS.ACTIVE);
        User user = User.builder()
                .username(request.getUsername())
                .fullName(request.getFullName())
                .email(request.getEmail())
                .password(request.getPassword())
                .type(request.getType())
                .phone(request.getPhone())
                .avatar(document)
                .addressDetail(request.getAddressDetail())
                .province(province)
                .district(district)
                .ward(ward)
                .build();
        user = super.create(user);
        return mapper.toDto(user);
    }


}
