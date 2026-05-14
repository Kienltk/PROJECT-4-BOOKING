package com.pro.booking.core.base;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.pro.booking.config.LocalDateTimeAdapter;
import com.pro.booking.config.security.CustomUserDetails;
import com.pro.booking.constants.Constants;
import com.pro.booking.constants.ErrorResponse;
import com.pro.booking.core.AppResponse;
import com.pro.booking.entity.DTO.ResponseData;
import com.pro.booking.entity.model.User;
import com.pro.booking.exception.AppException;
import com.pro.booking.service.common.CacheService;
import com.pro.booking.utils.AppUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.crypto.password.Pbkdf2PasswordEncoder;

import java.time.LocalDateTime;

public class BaseSupport {
    @Autowired
    private CacheService cacheService;

    @Autowired
    private ObjectMapper objectMapper;

    @Value("${jwt.expiration}")
    private long JWT_EXPIRATION_MINUTES;

    public Gson gson = new GsonBuilder()
            .registerTypeAdapter(LocalDateTime.class, new LocalDateTimeAdapter())
            .create();

    private final PasswordEncoder passwordEncoder;

    public BaseSupport() {
        this.passwordEncoder = Pbkdf2PasswordEncoder.defaultsForSpringSecurity_v5_8();
    }

    public String hashPassword(String rawPassword) {
        return passwordEncoder.encode(rawPassword);
    }

    public void setLoginUser(User user) throws JsonProcessingException {
        String json = objectMapper.writeValueAsString(user);
        cacheService.set(Constants.REDIS.DATA_USER + user.getUsername(), json, JWT_EXPIRATION_MINUTES);
    }

    public User getLoginUser() throws AppException {
        var authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication == null || !authentication.isAuthenticated()) {
            throw new AppException(ErrorResponse.UNAUTHORIZED);
        }
        Object principal = authentication.getPrincipal();
        if (principal instanceof CustomUserDetails(User user)) {
            String userJson = (String) cacheService.get(Constants.REDIS.DATA_USER + user.getUsername());
            return gson.fromJson(userJson, User.class);
        }
        throw new AppException(ErrorResponse.UNAUTHORIZED);
    }

    public String getFullAddress(User user) {
        StringBuilder address = new StringBuilder();

        if (user.getAddressDetail() != null && !user.getAddressDetail().isEmpty()) {
            address.append(user.getAddressDetail());
        }
        if (user.getWard() != null && user.getWard().getName() != null && !user.getWard().getName().isEmpty()) {
            if (!address.isEmpty()) address.append(", ");
            address.append(user.getWard().getName());
        }

        if (user.getDistrict() != null && user.getDistrict().getName() != null && !user.getDistrict().getName().isEmpty()) {
            if (!address.isEmpty()) address.append(", ");
            address.append(user.getDistrict().getName());
        }

        if (user.getProvince() != null && user.getProvince().getName() != null && !user.getProvince().getName().isEmpty()) {
            if (!address.isEmpty()) address.append(", ");
            address.append(user.getProvince().getName());
        }

        return address.toString();
    }

    public void deleteCacheUser(User user) {
        cacheService.delete(Constants.REDIS.DATA_USER + user.getUsername());
    }

    public boolean verifyPassword(String rawPassword, String hashedPassword) {
        return passwordEncoder.matches(rawPassword, hashedPassword);
    }

    public static int generateOTP() {
        int min = 10000;
        int max = 99999;
        return min + (int) (Math.random() * ((max - min) + 1));
    }

    public static int getPage(Integer page) {
        return (page == null || page <= 0)
                ? Constants.UTILS.DEFAULT_PAGE
                : page;
    }

    public static int getLimit(Integer limit) {
        return (limit == null || limit <= 0)
                ? Constants.UTILS.DEFAULT_LIMIT
                : limit;
    }

    protected String generateCode(String prefix) {
        return prefix + System.currentTimeMillis();
    }


    public ResponseEntity<ResponseData> sendSuccess() {
        return new ResponseEntity<>(ResponseData.success(), HttpStatus.OK);
    }

    public ResponseEntity<ResponseData> sendSuccess(String message) {
        return new ResponseEntity<>(ResponseData.success(message), HttpStatus.OK);
    }

    public ResponseEntity<ResponseData> sendSuccess(AppResponse response) {
        return new ResponseEntity<>(ResponseData.success(response.getCode(), response.getMessage()), HttpStatus.OK);
    }

    public ResponseEntity<ResponseData> sendSuccess(Object data) {
        if (AppUtils.notNull(data)) return new ResponseEntity<>(ResponseData.success(data), HttpStatus.OK);
        return new ResponseEntity<>(ResponseData.success(), HttpStatus.OK);
    }

    public ResponseEntity<ResponseData> sendError(AppResponse ex) {
        return new ResponseEntity<>(ResponseData.fail(ex.getCode(), ex.getMessage()), HttpStatus.OK);
    }

    public ResponseEntity<ResponseData> sendError(Object ex) {
        if (ex instanceof AppException e) {
            return new ResponseEntity<>(ResponseData.fail(e), HttpStatus.OK);
        }
        if (ex instanceof ErrorResponse e) {
            return new ResponseEntity<>(ResponseData.fail(ErrorResponse.DEFAULT.getCode(), ErrorResponse.DEFAULT.getMessage()), HttpStatus.OK);
        } else if (ex instanceof Exception e) {
            return new ResponseEntity<>(ResponseData.fail(ErrorResponse.DEFAULT.getCode(), e.getMessage()), HttpStatus.OK);
        } else {
            return new ResponseEntity<>(ResponseData.fail(ErrorResponse.DEFAULT.getCode(), ErrorResponse.DEFAULT.getMessage()), HttpStatus.OK);
        }
    }

    public ResponseEntity<ResponseData> sendError(String code, String message) {
        return new ResponseEntity<>(ResponseData.fail(code, message), HttpStatus.OK);
    }

    public ResponseEntity<ResponseData> sendError() {
        return new ResponseEntity<>(ResponseData.fail(ErrorResponse.DEFAULT.getCode()), HttpStatus.OK);
    }

    public ResponseEntity<ResponseData> sendError(String message) {
        return new ResponseEntity<>(ResponseData.fail(ErrorResponse.DEFAULT.getCode(), message), HttpStatus.OK);
    }


}
