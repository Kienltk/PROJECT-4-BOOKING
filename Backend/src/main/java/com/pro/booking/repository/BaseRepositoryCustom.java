package com.pro.booking.repository;

import com.pro.booking.exception.AppException;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Repository;

@Repository
public interface BaseRepositoryCustom<T, DTO> {
    Page<DTO> search(T searchDTO, Class<T> tClass) throws AppException;
}
