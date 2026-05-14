package com.pro.booking.service;


public interface AuditLogService {
    public void create(Object entity, int action);
}
