package com.pro.booking.constants;

import com.pro.booking.core.AppResponse;

public class SuccessResponse {
    public static final AppResponse LOGOUT_SUCCESS = AppResponse.builder().code("LOGOUT001").message("Logout successful")
            .build();
    public static final AppResponse DELETE_FILE_SUCCESS = AppResponse.builder().code("DELETE001").message("Delete file successful")
            .build();
}
