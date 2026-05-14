package com.pro.booking.service.impl;

import com.pro.booking.entity.DTO.BankAccountDTO;
import com.pro.booking.entity.model.BankAccount;
import com.pro.booking.repository.BankAccountRepository;
import com.pro.booking.service.BankAccountService;
import com.pro.booking.core.CRUDService;
import org.springframework.stereotype.Service;

@Service
public class BankAccountServiceImpl extends CRUDService<BankAccount, BankAccountDTO, Long, BankAccountRepository> implements BankAccountService {
    public BankAccountServiceImpl(BankAccountRepository repository) {
        super(repository, BankAccount.class, BankAccountDTO.class);
    }
}
