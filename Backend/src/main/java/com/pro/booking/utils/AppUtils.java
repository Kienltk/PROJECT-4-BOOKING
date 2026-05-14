package com.pro.booking.utils;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.SerializationFeature;
import com.fasterxml.jackson.datatype.jsr310.JavaTimeModule;

import java.math.BigDecimal;
import java.math.BigInteger;
import java.util.Collection;

@SuppressWarnings("ALL")
public class AppUtils {

    private static final ObjectMapper mapper = new ObjectMapper()
            .registerModule(new JavaTimeModule())
            .disable(SerializationFeature.WRITE_DATES_AS_TIMESTAMPS)
            .enable(SerializationFeature.INDENT_OUTPUT);

    public static void DEBUG(Object value) {
        try {
            StackTraceElement[] stackTrace = Thread.currentThread().getStackTrace();
            StackTraceElement caller = stackTrace[2];
            String location = caller.getClassName() + "." + caller.getMethodName()
                    + " (line: " + caller.getLineNumber() + ")";

            String output;
            if (value == null) {
                output = "null";
            } else if (value instanceof String) {
                output = (String) value;
            } else {
                try {
                    output = mapper.writeValueAsString(value);
                } catch (Exception e) {
                    output = value.toString();
                }
            }

            System.out.println("[DEBUG] " + location + " => " + output);
        } catch (Exception e) {
            System.out.println("[DEBUG] (error converting debug value) " + e.getMessage());
        }
    }

    public static boolean safeEqual(String baseObj, String... obj2) {
        if (baseObj == null && obj2 == null) return true;
        if (obj2 == null) return false;

        for (String s : obj2) {
            if (baseObj == null && s == null) return true;
            if (baseObj != null && baseObj.equalsIgnoreCase(s)) return true;
        }
        return false;
    }


    public static boolean safeEqual(Object obj1, Object... lstObjs) {
        for (Object obj2 : lstObjs) {
            if (((obj1 != null) && (obj2 != null) && obj2.toString().equals(obj1.toString()))) {
                return true;
            }
        }
        return false;
    }

    public static Long safeToLong(Object obj1) {
        return safeToLong(obj1, 0L);
    }

    public static Long safeToLong(Object obj1, Long defaultValue) {
        Long result = defaultValue;
        if (obj1 != null) {
            if (obj1 instanceof Double) {
                return ((Double) obj1).longValue();
            }
            if (obj1 instanceof BigDecimal) {
                return ((BigDecimal) obj1).longValue();
            }
            if (obj1 instanceof BigInteger) {
                return ((BigInteger) obj1).longValue();
            }
            if (obj1 instanceof Long) {
                return ((Long) obj1).longValue();
            }
            try {
                result = Long.parseLong(obj1.toString());
            } catch (Exception ignored) {
            }
        }

        return result;
    }


    public static int safeToInt(Object obj1, int defaultValue) {
        int result = defaultValue;
        if (obj1 != null) {
            try {
                result = Integer.parseInt(obj1.toString());
            } catch (Exception ignored) {
                ignored.printStackTrace();
            }
        }

        return result;
    }


    public static boolean notNull(Object obj) {
        return !isNullObject(obj);
    }

    public static boolean isNullObject(Object obj1) {
        if (obj1 == null) {
            return true;
        }
        if (obj1 instanceof String) {
            return isNullOrEmpty(obj1.toString());
        }
        return false;
    }

    public static String camelToSnake(String str) {
        String regex = "([a-z])([A-Z]+)";
        String replacement = "$1_$2";
        str = str
                .replaceAll(
                        regex, replacement)
                .toLowerCase();
        return str;
    }

    public static String camelCase(String str) {
        String[] tokens = str.toLowerCase().split("_");
        str = "";
        for (int i = 0; i < tokens.length; i++) {
            char capLetter;
            if (i != 0)
                capLetter = Character.toUpperCase(tokens[i].charAt(0));
            else
                capLetter = Character.toLowerCase(tokens[i].charAt(0));
            str += "" + capLetter + tokens[i].substring(1);
        }
        return str.trim();
    }

    public static boolean nullOrEmpty(String input) {
        return input == null || input.trim().isEmpty();
    }

    public static boolean nullOrEmpty(Collection objects) {
        return objects == null || objects.isEmpty();
    }

    public static boolean isNullOrEmpty(Collection<?> collection) {
        return collection == null || collection.isEmpty();
    }

    public static boolean isNullOrEmpty(String value) {
        return value == null || value.trim().equals("") || value.trim().equalsIgnoreCase("null");
    }

    public static boolean isNullOrEmpty(final Object obj) {
        return obj == null || obj.toString().isEmpty();
    }

    public static boolean notNullOrEmpty(Collection<?> collection) {
        return !isNullOrEmpty(collection);
    }


    public static int safeToInt(Object obj) {
        return safeToInt(obj, 0);
    }


    public static String safeToString(Object obj, String defaultValue) {
        if (obj == null || safeEqual(obj.toString().trim(), "", "null", "NULL")) {
            return defaultValue;
        }
        return obj.toString();
    }

    public static String safeToString(Object obj) {
        return safeToString(obj, "");
    }

    public static boolean isNullOrZero(Long value) {
        return (value == null || value.equals(0L));
    }

    public static boolean isNullOrZero(Float value) {
        return (value == null || value.equals(0f));
    }

    public static boolean isNullOrZero(Integer value) {
        return (value == null || value.equals(0));
    }

    public static boolean isNullOrZero(Double value) {
        return (value == null || value.equals(0d));
    }

}
