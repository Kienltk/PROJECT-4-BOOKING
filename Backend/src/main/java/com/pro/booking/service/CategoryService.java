package com.pro.booking.service;

import com.pro.booking.entity.DTO.CategoryDTO;
import com.pro.booking.entity.model.Category;
import com.pro.booking.entity.request.CategoryRequest;
import com.pro.booking.exception.AppException;
import java.util.List;
import java.util.Set;

public interface CategoryService {
    CategoryDTO create(CategoryRequest request) throws AppException;
    CategoryDTO update(Long id, CategoryRequest request) throws AppException;
    List<CategoryDTO> getByType(String type) throws AppException;
}
