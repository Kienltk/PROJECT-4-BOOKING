package com.pro.booking.controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.pro.booking.constants.SuccessResponse;
import com.pro.booking.core.CRUDInterface;
import com.pro.booking.core.base.BaseDTO;
import com.pro.booking.entity.DTO.BaseRequestDTO;
import com.pro.booking.entity.DTO.UserDTO;
import com.pro.booking.entity.model.User;
import com.pro.booking.entity.request.UserRequest;
import com.pro.booking.exception.AppException;
import com.pro.booking.repository.UserRepository;
import com.pro.booking.service.impl.UserServiceImpl;
import com.pro.booking.utils.AppUtils;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping(value = "/api/user")
public class UserController extends CRUDInterface<User, Long, UserDTO, UserRepository, UserServiceImpl> {

    protected UserController(UserServiceImpl service) {
        super(service, User.class, UserDTO.class);
    }

    @PutMapping
    public Object update(@RequestBody BaseRequestDTO<UserRequest> baseRequestDTO) throws JsonProcessingException {
        UserRequest userRequest = baseRequestDTO.getPayload();
        User user = service.get(getLoginUser().getId());

        if (userRequest.getEmail() != null) user.setEmail(userRequest.getEmail());
        if (userRequest.getPhone() != null) user.setPhone(userRequest.getPhone());
        if (userRequest.getFullName() != null) user.setFullName(userRequest.getFullName());

        service.update(user);
        setLoginUser(user);
        user.setPassword(null);
        return sendSuccess(user);

    }

    @GetMapping("/all")
    public Object getAll(@RequestBody BaseRequestDTO<BaseDTO> baseRequestDTO) {
        try {
            List<User> users = service.findAll();
            return sendSuccess(users);
        } catch (Exception ex) {
            return sendError();
        }
    }

    @DeleteMapping
    public Object delete(@RequestBody BaseRequestDTO<UserDTO> baseRequestDTO) {
        try {
            service.delete(baseRequestDTO.getPayload().getId());
            return sendSuccess();
        } catch (Exception ignored) {
            return sendError();
        }
    }

    @GetMapping
    public Object getUserLoginInformation() throws AppException {
        User user = getLoginUser();
        UserDTO userDTO = modelMapper.map(user, UserDTO.class);
        userDTO.setAddress(getFullAddress(user));
        userDTO.setPassword(null);
        return sendSuccess(userDTO);
    }

    @PostMapping("/logout")
    public Object logout() throws AppException {
        User user = getLoginUser();
        deleteCacheUser(user);
        return sendSuccess(SuccessResponse.LOGOUT_SUCCESS);
    }
}
