package com.pro.booking.service.impl;

import com.pro.booking.constants.ErrorResponse;
import com.pro.booking.entity.DTO.CategoryDTO;
import com.pro.booking.entity.model.Category;
import com.pro.booking.entity.request.CategoryRequest;
import com.pro.booking.exception.AppException;
import com.pro.booking.repository.CategoryRepository;
import com.pro.booking.core.CRUDService;
import com.pro.booking.service.CategoryService;
import com.pro.booking.utils.AppUtils;
import org.springframework.stereotype.Service;

import java.util.List;


@Service
public class CategoryServiceImpl extends CRUDService<Category, CategoryDTO, Long, CategoryRepository> implements CategoryService {
    public CategoryServiceImpl(CategoryRepository repository) {
        super(repository, Category.class, CategoryDTO.class);
    }


    @Override
    public CategoryDTO create(CategoryRequest request) throws AppException {
        if (AppUtils.isNullOrEmpty(request.getName())) {
            throw new AppException(ErrorResponse.NAME_REQUIRED);
        }
        if (AppUtils.isNullOrEmpty(request.getType())) {
            throw new AppException(ErrorResponse.TYPE_REQUIRED);
        }
        if (AppUtils.isNullOrEmpty(request.getDescription())) {
            throw new AppException(ErrorResponse.DESCRIPTION_REQUIRED);
        }
        if (AppUtils.isNullOrEmpty(request.getStatus())) {
            request.setStatus(1L);
        }

        Category category = Category.builder()
                .description(request.getDescription())
                .name(request.getName())
                .type(request.getType())
                .icon(request.getIcon())
                .build();
        return mapper.toDto(super.create(category));
    }

    @Override
    public CategoryDTO update(Long id, CategoryRequest request) throws AppException {
        Category category = repository.findById(id)
                .orElseThrow(() -> new AppException(ErrorResponse.CATEGORY_NOT_FOUND));

        if (AppUtils.isNullOrEmpty(request.getName())) {
            throw new AppException(ErrorResponse.NAME_REQUIRED);
        }
        if (AppUtils.isNullOrEmpty(request.getName())) {
            throw new AppException(ErrorResponse.CATEGORY_REQUIRED);
        }
        if (AppUtils.isNullOrEmpty(request.getIcon())) {
            request.setIcon("icon");
        }
        if (AppUtils.isNullOrEmpty(request.getDescription())) {
            throw new AppException(ErrorResponse.DESCRIPTION_REQUIRED);
        }

        category.setName(request.getName());
        category.setType(request.getType());
        category.setIcon(request.getIcon());
        category.setDescription(request.getDescription());

        return mapper.toDto(super.update(category));
    }


    @Override
    public List<CategoryDTO> getByType(String type) throws AppException {
        List<Category> categories = repository.findByType(type);
        if (categories.isEmpty()) {
            throw new AppException(ErrorResponse.CATEGORY_TYPE_NOT_FOUND);
        }
        return mapper.toDtoList(categories);
    }

    @Override
    public void delete(Long id) throws AppException {
        if (!repository.existsById(id)) {
            throw new AppException(ErrorResponse.CATEGORY_NOT_FOUND);
        }
        
        try {
            super.delete(id);
        } catch (Exception e) {
            if (e.getMessage().contains("foreign key constraint")) {
                throw new AppException("ERR_CATEGORY_IN_USE", 
                    "Cannot delete this category because it is being used by one or more rooms. Please remove it from all rooms first.");
            }
            throw e;
        }
    }

}
