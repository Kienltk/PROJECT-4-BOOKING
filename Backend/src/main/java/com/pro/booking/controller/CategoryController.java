package com.pro.booking.controller;

import com.pro.booking.core.CRUDInterface;
import com.pro.booking.entity.DTO.BaseRequestDTO;
import com.pro.booking.entity.DTO.CategoryDTO;
import com.pro.booking.entity.model.Category;
import com.pro.booking.entity.request.CategoryRequest;
import com.pro.booking.exception.AppException;
import com.pro.booking.middleware.permission.Permissions;
import com.pro.booking.repository.CategoryRepository;
import com.pro.booking.service.impl.CategoryServiceImpl;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Slf4j
@RestController
@RequestMapping(value = "/api/category")
public class CategoryController extends CRUDInterface<Category, Long, CategoryDTO, CategoryRepository, CategoryServiceImpl> {
    protected CategoryController(CategoryServiceImpl service) {
        super(service, Category.class, CategoryDTO.class);
    }

    @GetMapping
    public Object getAll(@RequestBody BaseRequestDTO<CategoryDTO> baseRequestDTO) {
        CategoryDTO dto = baseRequestDTO.getPayload();
        try {
            List<CategoryDTO> data = service.getAll();
            return sendSuccess(data);
        } catch (AppException e) {
            return sendError(e.getErrorCode(), e.getDescription());
        } catch (Exception e) {
            return sendError(e.getMessage());
        }
    }

    @GetMapping("/getByType")
    public Object getByType(@RequestBody BaseRequestDTO<CategoryRequest> baseRequestDTO) {
        try {
            List<CategoryDTO> data = service.getByType(baseRequestDTO.getPayload().getType());
            return sendSuccess(data);
        } catch (AppException e) {
            return sendError(e.getErrorCode(), e.getDescription());
        }
    }

    @PostMapping
    @Permissions(role = 1L)
    public Object create(@RequestBody BaseRequestDTO<CategoryRequest> baseRequestDTO) {
        CategoryRequest dto = baseRequestDTO.getPayload();
        try {
            if (dto.getCategoryDTOS() != null && !dto.getCategoryDTOS().isEmpty()) {
                return sendSuccess(service.create(dto.getCategoryDTOS()));
            }
            return sendSuccess(service.create(dto));
        } catch (AppException e) {
            return sendError(e.getErrorCode(), e.getDescription());
        }
    }

    @PutMapping
    @Permissions(role = 1L)
    public Object update(@RequestBody BaseRequestDTO<CategoryRequest> baseRequestDTO) {
        try {
            CategoryRequest dto = baseRequestDTO.getPayload();
            CategoryDTO savedDto = service.update(dto.getId(), dto);
            return sendSuccess(savedDto);
        } catch (AppException e) {
            return sendError(e.getErrorCode(), e.getDescription());
        } catch (Exception e) {
            return sendError(e.getMessage());
        }
    }

    @DeleteMapping
    @Permissions(role = 1L)
    public Object delete(@RequestBody BaseRequestDTO<CategoryRequest> baseRequestDTO) {
        try {
            service.delete(baseRequestDTO.getPayload().getId());
            return sendSuccess();
        } catch (AppException e) {
            return sendError(e.getErrorCode(), e.getDescription());
        }
    }


}
