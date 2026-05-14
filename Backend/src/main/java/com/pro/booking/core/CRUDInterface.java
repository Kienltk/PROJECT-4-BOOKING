package com.pro.booking.core;


import com.pro.booking.constants.Constants;
import com.pro.booking.constants.ErrorResponse;
import com.pro.booking.core.base.BaseSupport;
import com.pro.booking.core.base.BaseEntity;
import com.pro.booking.core.base.BaseDTO;
import com.pro.booking.entity.DTO.ResponseData;
import com.pro.booking.exception.AppException;
import com.pro.booking.service.common.CacheService;
import com.pro.booking.service.common.JwtService;
import com.pro.booking.utils.AppUtils;
import jakarta.transaction.Transactional;
import lombok.extern.slf4j.Slf4j;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import java.io.Serializable;
import java.util.*;

@Slf4j
@SuppressWarnings("all")
@Service
public abstract class CRUDInterface<T extends BaseEntity, ID extends Serializable, DTO extends BaseDTO, R extends JpaRepository<T, ID>,
        S extends CRUDService<T, DTO, ID, R>> extends BaseSupport {
    public final S service;
    private final Class<T> entityType;
    private final Class<DTO> valueType;

    @Autowired
    public ModelMapper modelMapper;
    @Autowired
    public CacheService cacheService;
    @Autowired
    public JwtService jwtService;

    protected CRUDInterface(S service, Class<T> entityType, Class<DTO> valueType) {
        this.service = service;
        this.entityType = entityType;
        this.valueType = valueType;
    }

    public ResponseEntity<ResponseData> prepareLoadingInterface() {
        try {
            ResponseData res = new ResponseData();
            prepareLoadingPage(res);
            if (res != null) {
                return sendSuccess(res.getPayload());
            } else {
                return sendError(ErrorResponse.DEFAULT.getMessage());
            }
        } catch (Exception e) {
            e.printStackTrace();
            return sendError(ErrorResponse.DEFAULT.getMessage());
        }
    }


    public Page<DTO> searchPage(DTO searchDTO) throws AppException {
        AppUtils.DEBUG(searchDTO);
        try {
            if (AppUtils.isNullOrZero(searchDTO.getLimit())) searchDTO.setLimit(Constants.UTILS.DEFAULT_LIMIT);
            if (AppUtils.isNullOrZero(searchDTO.getPage())) searchDTO.setPage(Constants.UTILS.DEFAULT_PAGE);
            convertBeforeSearch(searchDTO);
            Page<DTO> res = service.search(searchDTO, entityType);
            convertDataAfterSearch(res.getContent());
            return res;
        } catch (Exception e) {
            e.printStackTrace();
            log.debug(e.getMessage());
            return null;
        }
    }

    @Transactional(rollbackOn = {AppException.class, Exception.class})
    public ResponseEntity<ResponseData> create(DTO dto) {
        try {
            validateBeforCreate(dto);
            dto = service.create(dto);
            afterCreate(dto);
            return sendSuccess(dto);
        } catch (AppException e) {
            return sendError(e);
        } catch (Exception e) {
            return sendError(e);
        }
    }
    @Transactional(rollbackOn = {AppException.class, Exception.class})
    public ResponseEntity<ResponseData> update(DTO dto) {
        try {
            validateBeforUpdate(dto);
            dto = service.update(dto);
            afterUpdate(dto);
            return sendSuccess(dto);
        } catch (AppException e) {
            return sendError(e);
        } catch (Exception e) {
            return sendError(e);
        }
    }

    public ResponseEntity<ResponseData> getDetail(DTO entity) {
        try {
            DTO dto = service.getDetail(entity);
            convertDataAfterGetDetail(dto);
            return new ResponseEntity<>(ResponseData.success(dto), HttpStatus.OK);
        } catch (AppException e) {
            return new ResponseEntity<>(ResponseData.fail(e.getErrorCode()), HttpStatus.OK);
        } catch (Exception e) {
            return sendError(ErrorResponse.DEFAULT);
        }
    }

    public void prepareLoadingPage(ResponseData data) throws AppException {
    }

    public void convertDataAfterSearch(List<DTO> data) {
    }

    public void convertDataAfterGetDetail(DTO dto) {
    }

    public void convertDataAfterSearch(DTO data) {
    }

    public void convertBeforeSearch(DTO data) {
    }

    public void convertDataCreate(DTO entity) throws AppException {

    }

    public void convertDataUpdate(DTO entity) throws AppException {

    }

    public Boolean validateBeforCreate(DTO data) throws AppException {
        return true;
    }

    public void afterCreate(DTO data) throws AppException {
    }

    public void afterUpdate(DTO data) throws AppException {
    }

    public Boolean validateBeforUpdate(DTO data) throws AppException {
        return true;
    }
}
