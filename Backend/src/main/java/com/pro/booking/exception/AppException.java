package com.pro.booking.exception;

import com.pro.booking.constants.ErrorResponse;
import com.pro.booking.core.AppResponse;
import lombok.*;

@EqualsAndHashCode(callSuper = true)
@Data
@NoArgsConstructor
@ToString
public class AppException extends RuntimeException {
    private String errorCode;
    private String description;

    public AppException(AppResponse appResponse) {
        super(appResponse.getMessage());
        this.errorCode = appResponse.getCode();
        this.description = appResponse.getMessage();
    }

    public AppException(String errorCode) {
        super(errorCode);
        if (errorCode == null || errorCode.isEmpty()) {
            errorCode = ErrorResponse.DEFAULT.getCode();
        }
        this.errorCode = errorCode;
        this.description = errorCode;
    }

    public AppException(String message, Throwable cause) {
        super(message, cause);
        this.errorCode = ErrorResponse.DEFAULT.getCode();
        this.description = message;
    }

    public AppException(Exception e) {
        super(e.getMessage(), e);
        if (e instanceof AppException) {
            this.errorCode = ((AppException) e).getErrorCode();
            this.description = ((AppException) e).getDescription();
        } else {
            this.errorCode = ErrorResponse.DEFAULT.getCode();
            this.description = e.getMessage() != null ? e.getMessage() : e.toString();
        }
    }

    public AppException(String errorCode, String message) {
        super(message);
        this.errorCode = errorCode;
        this.description = message;
    }

    public AppException(String errorCode, Exception e) {
        super(e.getMessage(), e);
        this.errorCode = errorCode;
        this.description = e.getMessage();
    }

    public AppException(AppResponse appResponse, Exception e) {
        super(e.getMessage(), e);
        this.errorCode = appResponse.getCode();
        this.description = e.getMessage();
    }
}
