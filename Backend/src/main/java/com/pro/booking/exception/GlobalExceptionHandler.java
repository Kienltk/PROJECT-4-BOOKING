package com.pro.booking.exception;

import com.pro.booking.constants.ErrorResponse;
import com.pro.booking.entity.DTO.ResponseData;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

import java.lang.reflect.UndeclaredThrowableException;

@ControllerAdvice
public class GlobalExceptionHandler {

    @ExceptionHandler(AppException.class)
    public ResponseEntity<ResponseData> handleAppException(AppException e) {
        e.printStackTrace();
        return new ResponseEntity<>(
                ResponseData.fail(e.getErrorCode(), e.getDescription()),
                HttpStatus.OK
        );
    }

    @ExceptionHandler(Exception.class)
    public ResponseEntity<ResponseData> handleException(Exception e) {
        e.printStackTrace();
        return new ResponseEntity<>(
                ResponseData.fail(ErrorResponse.DEFAULT.getCode(), e.getMessage()),
                HttpStatus.OK
        );
    }

    @ExceptionHandler(UndeclaredThrowableException.class)
    public ResponseEntity<ResponseData> handleUndeclaredThrowableException(UndeclaredThrowableException e) {
        e.printStackTrace();
        return new ResponseEntity<>(
                ResponseData.fail(ErrorResponse.DEFAULT.getCode(), e.getMessage()),
                HttpStatus.OK
        );
    }
}
