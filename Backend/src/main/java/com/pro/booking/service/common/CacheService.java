package com.pro.booking.service.common;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;

import java.util.Set;

public interface CacheService {
    RedisTemplate getRedisTemplate();

    Object get(String key);

    String getString(String key);

    Set<String> getPattern(String key);

    Boolean hasKey(String key);

    Boolean delete(String key);

    void deleteAll(String key);

    void set(String key, Object value);

    void set(String key, Object value, Long timeoutSeconds);

    void set(String key, Object value, Long timeout, java.util.concurrent.TimeUnit unit);

    String getCacheData(String s);

    void flushAll();
}
