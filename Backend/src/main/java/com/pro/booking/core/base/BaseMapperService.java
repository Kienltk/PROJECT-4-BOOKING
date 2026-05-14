package com.pro.booking.core.base;

import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class BaseMapperService<Model, DTO> {

    private final ModelMapper mapper = new ModelMapper();
    private Class<Model> model;
    private Class<DTO> dto;

    public void init(Class<Model> model, Class<DTO> dto) {
        this.model = model;
        this.dto = dto;
    }

    public DTO toDto(Model entity) {
        if (entity == null || dto == null) return null;
        return mapper.map(entity, dto);
    }

    public Model toEntity(DTO dto) {
        if (dto == null || model == null) return null;
        return mapper.map(dto, model);
    }

    public List<DTO> toDtoList(List<Model> entities) {
        List<DTO> listDTO = new ArrayList<>();
        if (entities == null) return listDTO;
        for (Model entity : entities) {
            listDTO.add(toDto(entity));
        }
        return listDTO;
    }

    public List<Model> toEntityList(List<DTO> listDTO) {
        List<Model> entities = new ArrayList<>();
        if (listDTO == null) return entities;
        for (DTO dto : listDTO) {
            entities.add(toEntity(dto));
        }
        return entities;
    }
}

