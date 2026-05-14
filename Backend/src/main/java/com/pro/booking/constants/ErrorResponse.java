package com.pro.booking.constants;

import com.pro.booking.core.AppResponse;
import org.springframework.stereotype.Component;

@Component
public class ErrorResponse {
    public static final AppResponse DEFAULT = AppResponse.builder().code("PRD000").message("System Error")
            .build();
    public static final AppResponse USERNAME_EXITS = AppResponse.builder().code("PRD001").message("Username already exists")
            .build();
    public static final AppResponse PHONE_EXITS = AppResponse.builder().code("PRD002").message("phone number already exists")
            .build();
    public static final AppResponse INVALID_TOKEN = AppResponse.builder().code("PRD003").message("Invalid token")
            .build();
    public static final AppResponse DUPLICATE_DATA = AppResponse.builder().code("PRD005").message("Duplicate data")
            .build();
    public static final AppResponse ERROR = AppResponse.builder().code("ERROR").message("Error")
            .build();
    public static final AppResponse USER_NOT_FOUND = AppResponse.builder().code("PRD006").message("User not found")
            .build();
    public static final AppResponse INVALID_PASSWORD = AppResponse.builder().code("PRD007").message("Invalid password")
            .build();
    public static final AppResponse INCORRECT_USERNAME_OR_PASSWORD = AppResponse.builder().code("PRD008").message("Incorrect username or password")
            .build();
    public static final AppResponse UNAUTHORIZED = AppResponse.builder().code("PRD009").message("Unauthorized")
            .build();
    public static final AppResponse INVALID_REFRESH_TOKEN = AppResponse.builder().code("PRD010").message("Invalid refresh token")
            .build();
    public static final AppResponse INVALID_OR_EXPIRED_TOKEN = AppResponse.builder().code("PRD011").message("Invalid or expired token")
            .build();
    public static final AppResponse DELETE_FILE_ERROR = AppResponse.builder().code("PRD0112").message("Delete file error")
            .build();
    public static final AppResponse ROOM_NOT_FOUND = AppResponse.builder().code("PRD0113").message("Room not found")
            .build();
    public static final AppResponse HOST_NOT_FOUND = AppResponse.builder().code("PRD0114").message("Host not found")
            .build();
    public static final AppResponse CATEGORY_NOT_FOUND = AppResponse.builder().code("PRD0115").message("Category not found")
            .build();
    public static final AppResponse CATEGORY_TYPE_NOT_FOUND = AppResponse.builder().code("PRD0116").message("Category type not found")
            .build();
    public static final AppResponse PROVINCE_NOT_FOUND = AppResponse.builder().code("PRD0117").message("Province not found")
            .build();
    public static final AppResponse DISTRICT_NOT_FOUND = AppResponse.builder().code("PRD0118").message("District not found")
            .build();
    public static final AppResponse WARD_NOT_FOUND = AppResponse.builder().code("PRD0119").message("Ward not found")
            .build();
    public static final AppResponse ERROR_PERMISSION = AppResponse.builder().code("PRD0120").message("You do not have permission to perform this function.")
            .build();
    public static final AppResponse ERROR_PASSWORD = AppResponse.builder().code("PRD0121").message("Error Password")
            .build();
    public static final AppResponse BOOKING_NOT_FOUND = AppResponse.builder().code("PRD0122").message("Booking not found")
            .build();
    public static final AppResponse CATEGORY_REQUIRED = AppResponse.builder().code("PRD0123").message("Category required")
            .build();
    public static final AppResponse DOCUMENT_REQUIRED = AppResponse.builder().code("PRD0124").message("Room Image required")
            .build();
    public static final AppResponse TITLE_REQUIRED = AppResponse.builder().code("PRD0125").message("Title required")
            .build();
    public static final AppResponse DESCRIPTION_REQUIRED = AppResponse.builder().code("PRD0126").message("Description required")
            .build();
    public static final AppResponse PRICE_REQUIRED = AppResponse.builder().code("PRD0127").message("Price required")
            .build();
    public static final AppResponse SUBTITLE_REQUIRED = AppResponse.builder().code("PRD0128").message("SubTitle required")
            .build();
    public static final AppResponse NAME_REQUIRED = AppResponse.builder()
            .code("CAT001")
            .message("Name is required")
            .build();

    public static final AppResponse TYPE_REQUIRED = AppResponse.builder()
            .code("CAT002")
            .message("Type is required")
            .build();

    public static final AppResponse ICON_REQUIRED = AppResponse.builder()
            .code("CAT003")
            .message("Icon is required")
            .build();
    public static final AppResponse COMMON_REQUIRED = AppResponse.builder().code("PRD012").message("Common required")
            .build();

    public static final AppResponse TAG_REQUIRED = AppResponse.builder().code("PRD030").message("Tag required")
            .build();

    public static final AppResponse INVALID_DATE_RANGE = AppResponse.builder().code("PRD031").message("Invalid date range")
            .build();
    public static final AppResponse ROOM_OUT_OF_STOCK = AppResponse.builder().code("PRD033").message("Room out of stock")
            .build();
    public static final AppResponse PAYMENT_METHOD_REQUIRED = AppResponse.builder()
            .code("PRD034")
            .message("Payment method is required")
            .build();
    public static final AppResponse DOCUMENT_NOT_FOUND = AppResponse.builder().code("PRD034").message("Document not found")
            .build();


}
