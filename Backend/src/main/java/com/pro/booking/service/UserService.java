package com.pro.booking.service;

import com.pro.booking.entity.DTO.UserDTO;
import com.pro.booking.entity.model.User;
import com.pro.booking.entity.request.UserRegisterRequest;
import com.pro.booking.exception.AppException;

import java.util.List;

public interface UserService {
    public User checkExits(String username) throws AppException;
    public UserDTO create(UserRegisterRequest request) throws AppException;

}
