package com.pro.booking.service.impl;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.SerializationFeature;
import com.fasterxml.jackson.datatype.jsr310.JavaTimeModule;
import com.pro.booking.entity.DTO.AuditLogDTO;
import com.pro.booking.entity.model.AuditLog;
import com.pro.booking.repository.AuditLogRepository;
import com.pro.booking.service.AuditLogService;
import com.pro.booking.core.CRUDService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.lang.reflect.Field;
import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.Map;

@Service
public class AuditLogServiceImpl extends CRUDService<AuditLog, AuditLogDTO, Long, AuditLogRepository> implements AuditLogService {
    public AuditLogServiceImpl(AuditLogRepository repository) {
        super(repository, AuditLog.class, AuditLogDTO.class);
    }


    @Override
    @Transactional(propagation = Propagation.REQUIRES_NEW)
    public void create(Object entity, int action) {
        String details = extractFieldDetailsAsJson(entity);
        repository.save(
                AuditLog.builder()
                        .user(getLoginUser())
                        .createdAt(LocalDateTime.now())
                        .action(getAction(action))
                        .details(details)
                        .build()
        );
    }

    private String extractFieldDetailsAsJson(Object entity) {
        Map<String, Object> map = new HashMap<>();
        for (Field field : entity.getClass().getDeclaredFields()) {
            field.setAccessible(true);
            try {
                map.put(field.getName(), field.get(entity));
            } catch (IllegalAccessException ignored) {
            }
        }
        try {
            return new ObjectMapper()
                    .registerModule(new JavaTimeModule())
                    .disable(SerializationFeature.WRITE_DATES_AS_TIMESTAMPS)
                    .writeValueAsString(map);
        } catch (JsonProcessingException e) {
            return "{}";
        }
    }


    private String getAction(int action) {
        return switch (action) {
            case 1 -> "INSERT";
            case 2 -> "UPDATE";
            case 3 -> "DELETE";
            default -> "CREATE";
        };
    }

}
