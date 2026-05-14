package com.pro.booking.service;

import com.pro.booking.entity.DTO.CategoryDTO;
import com.pro.booking.entity.DTO.DocumentDTO;
import com.pro.booking.entity.DTO.RoomDTO;
import com.pro.booking.entity.model.Category;
import com.pro.booking.entity.model.Document;
import com.pro.booking.entity.request.RoomCreateRequest;
import com.pro.booking.entity.request.RoomFilterRequest;
import com.pro.booking.exception.AppException;
import org.springframework.data.domain.Page;

import java.util.Set;

public interface RoomService {
    RoomDTO create(RoomCreateRequest request) throws AppException;

    RoomDTO update(Long id, RoomCreateRequest request) throws AppException;
    RoomDTO updateStatus(RoomDTO roomDTO) throws AppException;

    Set<CategoryDTO> getCategories(Set<Category> categories, RoomDTO roomDTO) throws AppException;

    Set<DocumentDTO> getDocuments(Set<Document> categories, RoomDTO roomDTO) throws AppException;

    public Page<RoomDTO> getRoomsByCategory(RoomFilterRequest request) throws AppException;

    public Page<RoomDTO> getRoomsByCategoryAndKeyword(RoomFilterRequest request) throws AppException;

    public Page<RoomDTO> getRoomsByCategoryNameOrType(RoomFilterRequest request) throws AppException;

    public Page<RoomDTO> searchRooms(RoomFilterRequest request) throws AppException;

}
