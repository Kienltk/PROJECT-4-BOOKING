package com.pro.booking.service.impl;

import com.pro.booking.entity.DTO.PaymentDTO;
import com.pro.booking.entity.model.Payment;
import com.pro.booking.repository.PaymentRepository;
import com.pro.booking.core.CRUDService;
import com.pro.booking.service.PaymentService;
import org.springframework.stereotype.Service;

@Service
public class PaymentServiceImpl extends CRUDService<Payment, PaymentDTO, Long, PaymentRepository> implements PaymentService {
    public PaymentServiceImpl(PaymentRepository repository) {
        super(repository, Payment.class, PaymentDTO.class);
    }
}
