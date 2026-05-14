package com.pro.booking.controller.auth;

import com.pro.booking.core.CRUDInterface;
import com.pro.booking.entity.DTO.BaseRequestDTO;
import com.pro.booking.entity.DTO.UserDTO;
import com.pro.booking.entity.model.User;
import com.pro.booking.entity.request.UserRegisterRequest;
import com.pro.booking.exception.AppException;
import com.pro.booking.repository.UserRepository;
import com.pro.booking.service.impl.AuditLogServiceImpl;
import com.pro.booking.service.impl.UserServiceImpl;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;


@RestController
@Slf4j
@RequestMapping(value = "/api/test")
public class TestController extends CRUDInterface<User, Long, UserDTO, UserRepository, UserServiceImpl> {
    protected TestController(UserServiceImpl service) {
        super(service, User.class, UserDTO.class);
    }

    @Autowired
    private AuditLogServiceImpl auditLogService;

    @PostMapping
    public Object test1(@RequestBody BaseRequestDTO<UserRegisterRequest> baseRequestDTO) {
        UserRegisterRequest request = baseRequestDTO.getPayload();
        try {
            return sendSuccess();
        } catch (AppException e) {
            return sendError(e.getErrorCode(), e.getMessage());
        }
    }


}
