package com.pro.booking.service.impl;

import com.pro.booking.constants.ErrorResponse;
import com.pro.booking.entity.DTO.CategoryDTO;
import com.pro.booking.entity.DTO.DocumentDTO;
import com.pro.booking.entity.DTO.RoomDTO;
import com.pro.booking.entity.model.Category;
import com.pro.booking.entity.model.Document;
import com.pro.booking.entity.model.Room;
import com.pro.booking.entity.model.User;
import com.pro.booking.entity.request.RoomCreateRequest;
import com.pro.booking.entity.request.RoomFilterRequest;
import com.pro.booking.exception.AppException;
import com.pro.booking.repository.CategoryRepository;
import com.pro.booking.repository.DocumentRepository;
import com.pro.booking.repository.RoomRepository;
import com.pro.booking.core.CRUDService;
import com.pro.booking.repository.UserRepository;
import com.pro.booking.service.RoomService;
import com.pro.booking.utils.AppUtils;
import org.springframework.stereotype.Service;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;

import java.math.BigDecimal;
import java.util.Collections;
import java.util.HashSet;
import java.util.Set;
import java.util.stream.Collectors;

@Service
public class RoomServiceImpl extends CRUDService<Room, RoomDTO, Long, RoomRepository> implements RoomService {
    public RoomServiceImpl(RoomRepository repository, UserRepository userRepository, CategoryRepository categoryRepository, DocumentRepository documentRepository) {
        super(repository, Room.class, RoomDTO.class);
        this.userRepository = userRepository;
        this.categoryRepository = categoryRepository;
        this.documentRepository = documentRepository;
    }

    private final UserRepository userRepository;
    private final CategoryRepository categoryRepository;
    private final DocumentRepository documentRepository;

    @Override
    public Page<RoomDTO> getRoomsByCategory(RoomFilterRequest request) throws AppException {
        Pageable pageable = PageRequest.of(getPage(request.getPage()), getLimit(request.getLimit()), Sort.by("id").descending());
        Page<Room> rooms = repository.findByCategory(request.getCategoryId(), pageable);
        return getRoomDTOS(rooms);
    }

    private Page<RoomDTO> getRoomDTOS(Page<Room> rooms) {
        return rooms.map(room -> {
            RoomDTO dto = mapper.toDto(room);
            dto.setCategories(getCategories(room.getCategories(), dto));
            dto.setCommons(getCategories(room.getCommons(), dto));
            dto.setTags(getCategories(room.getTags(), dto));
            dto.setDocuments(getDocuments(room.getDocuments(), dto));
            return dto;
        });
    }

    @Override
    public Page<RoomDTO> getRoomsByCategoryAndKeyword(RoomFilterRequest request) throws AppException {
        Pageable pageable = PageRequest.of(getPage(request.getPage()), getLimit(request.getLimit()), Sort.by("id").descending());
        Page<Room> rooms = repository.findByCategoryAndKeyword(request.getCategoryId(), request.getKeyword(), pageable);
        return getRoomDTOS(rooms);
    }

    @Override
    public Page<RoomDTO> getRoomsByCategoryNameOrType(RoomFilterRequest request) throws AppException {
        Pageable pageable = PageRequest.of(getPage(request.getPage()), getLimit(request.getLimit()), Sort.by("id").descending());
        Page<Room> rooms = repository.findByCategoryNameOrType(request.getName(), request.getType(), pageable);
        return getRoomDTOS(rooms);
    }


    @Override
    public Page<RoomDTO> searchRooms(RoomFilterRequest request) throws AppException {
        Pageable pageable = PageRequest.of(getPage(request.getPage()), getLimit(request.getLimit()), Sort.by("createdDate").descending());
        Page<Room> rooms = repository.searchRooms(request.getCategoryId(), request.getName(), request.getType(), request.getKeyword(), pageable);
        return getRoomDTOS(rooms);
    }

    @Override
    public RoomDTO create(RoomCreateRequest request) throws AppException {
        User host = userRepository.findById(getLoginUser().getId())
                .orElseThrow(() -> new AppException(ErrorResponse.HOST_NOT_FOUND));
        if (AppUtils.isNullOrEmpty(request.getCategoryIds())) {
            throw new AppException(ErrorResponse.CATEGORY_REQUIRED);
        }
        if (AppUtils.isNullOrEmpty(request.getCommonIds())) {
            throw new AppException(ErrorResponse.COMMON_REQUIRED);
        }

        if (AppUtils.isNullOrEmpty(request.getDocumentIds())) {
            throw new AppException(ErrorResponse.DOCUMENT_REQUIRED);
        }
        if (AppUtils.isNullOrEmpty(request.getTitle())) {
            throw new AppException(ErrorResponse.TITLE_REQUIRED);
        }
        if (AppUtils.isNullOrEmpty(request.getDescription())) {
            throw new AppException(ErrorResponse.DESCRIPTION_REQUIRED);
        }
        if (AppUtils.isNullOrEmpty(request.getSubTitle())) {
            throw new AppException(ErrorResponse.SUBTITLE_REQUIRED);
        }
        if (AppUtils.isNullOrEmpty(request.getPricePerNight())) {
            throw new AppException(ErrorResponse.PRICE_REQUIRED);
        }
        if (AppUtils.isNullOrEmpty(request.getCleaningFee())) request.setCleaningFee(BigDecimal.ZERO);
        if (AppUtils.isNullOrEmpty(request.getServiceFee())) request.setServiceFee(BigDecimal.ZERO);
        if (AppUtils.isNullOrEmpty(request.getMaxGuests())) request.setMaxGuests(1L);
        if (AppUtils.isNullOrEmpty(request.getRoomCount())) request.setRoomCount(1L);
        if (AppUtils.isNullOrEmpty(request.getBathroomCount())) request.setBathroomCount(1L);
        Set<Category> categories = new HashSet<>();
        if (!AppUtils.isNullOrEmpty(request.getCategoryIds())) {
            categories = new HashSet<>(categoryRepository.findAllById(request.getCategoryIds()));
        } else {
            throw new AppException(ErrorResponse.CATEGORY_REQUIRED);
        }
        Set<Category> commons = new HashSet<>();
        if (!AppUtils.isNullOrEmpty(request.getCommonIds())) {
            commons = new HashSet<>(categoryRepository.findAllById(request.getCommonIds()));
        } else {
            throw new AppException(ErrorResponse.COMMON_REQUIRED);
        }
        Set<Category> tags = new HashSet<>();
        if (!AppUtils.isNullOrEmpty(request.getTagIds())) {
            tags = new HashSet<>(categoryRepository.findAllById(request.getTagIds()));
        }
        Set<Document> documents = new HashSet<>(documentRepository.findAllById(request.getDocumentIds()));
        Room room = Room.builder()
                .host(host)
                .categories(categories)
                .commons(commons)
                .tags(tags)
                .title(request.getTitle())
                .documents(documents)
                .subTitle(request.getSubTitle())
                .description(request.getDescription())
                .pricePerNight(request.getPricePerNight())
                .cleaningFee(request.getCleaningFee())
                .serviceFee(request.getServiceFee())
                .maxGuests(request.getMaxGuests())
                .roomCount(request.getRoomCount())
                .bathroomCount(request.getBathroomCount())
                .build();
        room = super.create(room);
        RoomDTO roomDTO = mapper.toDto(room);
        roomDTO.setCategories(getCategories(room.getCategories(), roomDTO));
        roomDTO.setDocuments(getDocuments(documents, roomDTO));
        return roomDTO;
    }

    @Override
    public RoomDTO update(Long id, RoomCreateRequest request) throws AppException {
        Room room = repository.findById(id)
                .orElseThrow(() -> new AppException(ErrorResponse.ROOM_NOT_FOUND));

        if (getLoginUser().getId() != null && !getLoginUser().getId().equals(room.getHost().getId())) {
            User host = userRepository.findById(getLoginUser().getId())
                    .orElseThrow(() -> new AppException(ErrorResponse.HOST_NOT_FOUND));
            room.setHost(host);
        }
        if (AppUtils.isNullOrEmpty(request.getCategoryIds())) {
            Set<Category> categories = new HashSet<>(categoryRepository.findAllById(request.getCategoryIds()));
            room.setCategories(categories);
        } else {
            throw new AppException(ErrorResponse.CATEGORY_REQUIRED);
        }

        if (AppUtils.isNullOrEmpty(request.getCommonIds())) {
            Set<Category> commons = new HashSet<>(categoryRepository.findAllById(request.getCommonIds()));
            room.setCommons(commons);
        } else {
            throw new AppException(ErrorResponse.COMMON_REQUIRED);
        }

        if (AppUtils.isNullOrEmpty(request.getTagIds())) {
            Set<Category> tags = new HashSet<>(categoryRepository.findAllById(request.getTagIds()));
            room.setTags(tags);
        } else {
            throw new AppException(ErrorResponse.CATEGORY_REQUIRED);
        }

        if (AppUtils.isNullOrEmpty(request.getTitle())) {
            throw new AppException(ErrorResponse.TITLE_REQUIRED);
        }
        room.setTitle(request.getTitle());

        if (AppUtils.isNullOrEmpty(request.getSubTitle())) {
            throw new AppException(ErrorResponse.SUBTITLE_REQUIRED);
        }
        room.setSubTitle(request.getSubTitle());

        if (AppUtils.isNullOrEmpty(request.getDescription())) {
            throw new AppException(ErrorResponse.DESCRIPTION_REQUIRED);
        }
        room.setDescription(request.getDescription());
        if (AppUtils.isNullOrEmpty(request.getPricePerNight())) {
            throw new AppException(ErrorResponse.PRICE_REQUIRED);
        }
        room.setPricePerNight(request.getPricePerNight());

        room.setCleaningFee(!AppUtils.isNullOrEmpty(request.getCleaningFee()) ? request.getCleaningFee() : BigDecimal.ZERO);
        room.setServiceFee(!AppUtils.isNullOrEmpty(request.getServiceFee()) ? request.getServiceFee() : BigDecimal.ZERO);
        room.setMaxGuests(!AppUtils.isNullOrEmpty(request.getMaxGuests()) ? request.getMaxGuests() : 1L);
        room.setRoomCount(!AppUtils.isNullOrEmpty(request.getRoomCount()) ? request.getRoomCount() : 1L);
        room.setBathroomCount(!AppUtils.isNullOrEmpty(request.getBathroomCount()) ? request.getBathroomCount() : 1L);

        room = super.update(room);
        return mapper.toDto(room);
    }

    @Override
    public RoomDTO updateStatus(RoomDTO roomDTO) throws AppException {
        return null;
    }

    @Override
    public Set<CategoryDTO> getCategories(Set<Category> categories, RoomDTO roomDTO) throws AppException {
        if (categories == null || categories.isEmpty()) {
            return Collections.emptySet();
        }
        Set<CategoryDTO> categoryDTOs = categories.stream()
                .map(c -> CategoryDTO.builder()
                        .id(c.getId())
                        .name(c.getName())
                        .description(c.getDescription())
                        .type(c.getType())
                        .icon(c.getIcon())
                        .build())
                .collect(Collectors.toSet());
        roomDTO.setCategories(categoryDTOs);
        return categoryDTOs;
    }

    @Override
    public Set<DocumentDTO> getDocuments(Set<Document> documents, RoomDTO roomDTO) throws AppException {
        if (documents == null || documents.isEmpty()) {
            return Collections.emptySet();
        }
        Set<DocumentDTO> documentDTOs = documents.stream()
                .map(c -> DocumentDTO.builder()
                        .id(c.getId())
                        .info(c.getInfo())
                        .imageUrl(c.getImageUrl())
                        .isPrimary(c.getIsPrimary())
                        .type(c.getType())
                        .build())
                .collect(Collectors.toSet());

        roomDTO.setDocuments(documentDTOs);
        return documentDTOs;
    }


}
