package com.pro.booking.service.impl;

import com.pro.booking.core.CRUDService;
import com.pro.booking.entity.DTO.AuditLogDTO;
import com.pro.booking.entity.model.AuditLog;
import com.pro.booking.repository.AuditLogRepository;
import com.pro.booking.service.MailService;
import com.pro.booking.service.common.rabbit.producer.BookingProducer;
import org.springframework.stereotype.Service;


@Service
public class MailServiceImpl extends CRUDService<AuditLog, AuditLogDTO, Long, AuditLogRepository> implements MailService {
    public MailServiceImpl(AuditLogRepository repository, BookingProducer bookingProducer) {
        super(repository, AuditLog.class, AuditLogDTO.class);
        this.bookingProducer = bookingProducer;
    }

    private final BookingProducer bookingProducer;

    public void sendMail(Object entity, int action) {
        bookingProducer.send(entity);
    }
}
