package com.pro.booking.constants;

public class Constants {
    public static final String OWNER = "Ngo Minh Quang";
    public static final String OWNER_MAIL = "ngominhquang724@gmail.com";
    public static final String OWNER_PHONE = "0966 593 702";
    public static final String APP_NAME = "StayNia";

    public static final class ACCOUNT_STATUS {
        public static final Long ACTIVE = 1L;
        public static final Long INACTIVE = 0L;
    }

    public static final class ROLE {
        public static final Long ADMIN = 1L;
        public static final Long USER = 2L;
    }

    public static final class RESPONSE_MESSAGE {
        public static final String SUCCESS = "SUCCESS";
    }

    public static final class CATEGORY_TYPE {
        public static final String COMMON = "COMMON";
        public static final String CATEGORY = "CATEGORY";
    }

    public static final class PAYMENT_METHOD {
        public static final Long BANK = 1L;
        public static final Long MONEY = 2L;
    }

    public static final class BOOKING_STATUS {
        public static final Long WAITING_PAYMENT = 1L;
        public static final Long ROOM_CANCEL = 2L;
        public static final Long WAITING_CONFIRM = 3L;
        public static final Long REJECT = 4L;
        public static final Long USER_CANCEL = 5L;
        public static final Long REFUND_PAYMENT = 6L;
        public static final Long SUCCESS = 7L;
        public static final Long DONE = 8L;
    }

    public static class REDIS {
        public static final String DATA_USER = "DATA_USER:";
        public static final String DATA = "DATA:";
    }

    public static class UTILS {
        public static final Integer DEFAULT_PAGE = 0;
        public static final Integer DEFAULT_LIMIT = 20;
    }

    public static class SUBSCRIBE_ACTION {
        public static int INSERT = 1;
        public static int UPDATE = 2;
        public static int DELETE = 3;
        public static int CREATE = 4;
    }
}
