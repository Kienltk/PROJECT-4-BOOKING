package com.pro.booking.controller;

import com.pro.booking.core.CRUDInterface;
import com.pro.booking.entity.DTO.BaseRequestDTO;
import com.pro.booking.entity.DTO.DocumentDTO;
import com.pro.booking.entity.DTO.RoomDTO;
import com.pro.booking.entity.model.Room;
import com.pro.booking.entity.request.RoomCreateRequest;
import com.pro.booking.entity.request.RoomFilterRequest;
import com.pro.booking.exception.AppException;
import com.pro.booking.middleware.permission.Permissions;
import com.pro.booking.repository.RoomRepository;
import com.pro.booking.service.impl.RoomServiceImpl;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

@Slf4j
@RestController
@RequestMapping(value = "/api/room")
public class RoomController extends CRUDInterface<Room, Long, RoomDTO, RoomRepository, RoomServiceImpl> {
    protected RoomController(RoomServiceImpl service) {
        super(service, Room.class, RoomDTO.class);
    }

    @PostMapping
    @Permissions(role = 1L)
    public Object create(@RequestBody BaseRequestDTO<RoomCreateRequest> requestDTO) {
        service.create(requestDTO.getPayload());
        return sendSuccess();
    }

    @Override
    public Boolean validateBeforCreate(RoomDTO data) throws AppException {
        return super.validateBeforCreate(data);
    }


    @PutMapping
    @Permissions(role = 1L)
    public Object update(@RequestBody BaseRequestDTO<RoomCreateRequest> requestDTO) {
        RoomCreateRequest dto = requestDTO.getPayload();
        RoomDTO data = service.update(dto.getRoomId(), dto);
        return sendSuccess(data);
    }

    @DeleteMapping
    @Permissions(role = 1L)
    public Object delete(@RequestBody BaseRequestDTO<RoomCreateRequest> requestDTO) {
        service.delete(requestDTO.getPayload().getRoomId());
        return sendSuccess();
    }

    @GetMapping
    public Object getAll(@RequestBody BaseRequestDTO<RoomFilterRequest> requestDTO) {
        try {
            return service.searchRooms(requestDTO.getPayload());
        } catch (AppException e) {
            return sendError(e.getErrorCode(), e.getMessage());
        }
    }

    @GetMapping("/getByCategory")
    public Object getByCategory(@RequestBody BaseRequestDTO<RoomFilterRequest> requestDTO) {
        try {
            return service.getRoomsByCategory(requestDTO.getPayload());
        } catch (AppException e) {
            return sendError(e.getErrorCode(), e.getMessage());
        }
    }

    @GetMapping("/getByCategoryKeyword")
    public Object getByCategoryKeyword(@RequestBody BaseRequestDTO<RoomFilterRequest> requestDTO) {
        try {
            return service.getRoomsByCategoryAndKeyword(requestDTO.getPayload());
        } catch (AppException e) {
            return sendError(e.getErrorCode(), e.getMessage());
        }
    }

    @GetMapping("/getByCategoryNameType")
    public Object getByCategoryNameType(@RequestBody BaseRequestDTO<RoomFilterRequest> requestDTO) {
        try {
            return service.getRoomsByCategoryNameOrType(requestDTO.getPayload());
        } catch (AppException e) {
            return sendError(e.getErrorCode(), e.getMessage());
        }
    }

    @GetMapping("/getDetail")
    public Object getDetail(@RequestBody BaseRequestDTO<DocumentDTO> requestDTO) {
        try {
            Room room = service.get(requestDTO.getPayload().getId());
            RoomDTO dto = modelMapper.map(room, RoomDTO.class);
            dto.setCategories(service.getCategories(room.getCategories(), dto));
            dto.setDocuments(service.getDocuments(room.getDocuments(), dto));
            return sendSuccess(dto);
        } catch (AppException e) {
            return sendError(e.getErrorCode(), e.getMessage());
        }
    }


}
