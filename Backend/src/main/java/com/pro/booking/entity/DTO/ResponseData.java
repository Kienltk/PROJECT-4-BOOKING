package com.pro.booking.entity.DTO;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.pro.booking.constants.Constants;
import com.pro.booking.constants.ErrorResponse;
import com.pro.booking.exception.AppException;
import com.pro.booking.utils.AppUtils;
import lombok.Data;

@Data
@JsonInclude(JsonInclude.Include.ALWAYS)
public class ResponseData {
    private String message;
    private String code;
    private Object payload;

    public ResponseData() {
    }

    public static ResponseData success() {
        ResponseData responseData = new ResponseData();
        responseData.setMessage(Constants.RESPONSE_MESSAGE.SUCCESS);
        responseData.setPayload(null);
        return responseData;
    }

    public static ResponseData success(Object data) {
        ResponseData responseData = success();
        responseData.setMessage(Constants.RESPONSE_MESSAGE.SUCCESS);
        responseData.setPayload(data);
        return responseData;
    }

    public static ResponseData success(String code, String message) {
        return fail(code, message);
    }

    public static ResponseData fail(String code) {
        ResponseData responseData = new ResponseData();
        responseData.setCode(code);
        responseData.setMessage(ErrorResponse.DEFAULT.getMessage());
        return responseData;
    }

    public static ResponseData fail(AppException code) {
        ResponseData responseData = new ResponseData();
        responseData.setCode(code.getErrorCode());
        if (ErrorResponse.DEFAULT.getCode().equals(code.getErrorCode())) {
            responseData.setMessage(AppUtils.safeToString(code.getDescription(),
                    code.getErrorCode()));
        } else {
            responseData.setMessage(code.getErrorCode());
        }
        return responseData;
    }

    public static ResponseData fail(String setCode, String message) {
        ResponseData responseData = new ResponseData();
        responseData.setCode(setCode);
        responseData.setMessage(message);
        return responseData;
    }
}
