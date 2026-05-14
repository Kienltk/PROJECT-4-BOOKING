package com.pro.booking.service.common.impl;

import com.pro.booking.constants.Constants;
import com.pro.booking.exception.AppException;
import com.pro.booking.service.common.CacheService;
import com.pro.booking.utils.AppUtils;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;

import java.util.Set;
import java.util.concurrent.TimeUnit;


@Slf4j
@Service
public class CacheServiceImpl implements CacheService {

    private final RedisTemplate<String, Object> redisTemplate;
    private String key;
    private Object object;
    private TimeUnit unit;
    private Integer expire;

    public CacheServiceImpl(RedisTemplate<String, Object> redisTemplate) {
        this.key = "";
        this.object = "";
        this.unit = null;
        this.expire = null;
        this.redisTemplate = redisTemplate;
    }

    public RedisTemplate getRedisTemplate() {
        return this.redisTemplate;
    }

    public Object get(String key) {
        return this.redisTemplate.opsForValue().get(key);
    }

    public String getString(String key) {
        try {
            return AppUtils.safeToString(this.redisTemplate.opsForValue().get(key));
        } catch (Exception ex) {
            log.error(ex.getStackTrace().toString());
        }
        return "";
    }

    public String getCacheData(String key) {
        return AppUtils.safeToString(this.redisTemplate.opsForValue().get(Constants.REDIS.DATA + key));
    }

    public CacheServiceImpl pushCacheData(String key, Object object) {
        if (AppUtils.notNull(key) && AppUtils.notNull(object)) {
            this.redisTemplate.opsForValue().set(Constants.REDIS.DATA + key, object);
        }
        return this;
    }


    public Boolean hasKey(String key) {
        return AppUtils.notNull(this.redisTemplate.opsForValue().get(key));
    }


    public Boolean delete(String key) {
        try {
            return this.redisTemplate.delete(key);
        } catch (Exception ex) {
            log.error("delete error: " + ex.getMessage());
        }
        return false;
    }


    public void deleteAll(String pattern) {
        Set<String> keys = redisTemplate.keys(pattern);
        for (String key : keys) {
            redisTemplate.delete(key);
        }
    }

    @Override
    public void set(String key, Object value) {
        redisTemplate.opsForValue().set(key, value);
    }

    @Override
    public void set(String key, Object value, Long timeoutMinutes) {
        AppUtils.DEBUG(key);
        AppUtils.DEBUG(value);
        redisTemplate.opsForValue().set(key, value, timeoutMinutes, TimeUnit.MINUTES);
    }

    @Override
    public void set(String key, Object value, Long timeout, TimeUnit unit) {
        redisTemplate.opsForValue().set(key, value, timeout, unit);
    }

    public Set<String> getPattern(String pattern) {
        return redisTemplate.keys(pattern);
    }

    public void init() {
        this.key = "";
        this.object = "";
        this.unit = null;
        this.expire = null;
    }

    public CacheServiceImpl setDataBase(Integer dataBase) {
//        RedisConnectionFactory jedisConnectionFactory = redisTemplate.getConnectionFactory();
//        jedisConnectionFactory.getConnection().select(5);
//        redisTemplate.setConnectionFactory(jedisConnectionFactory);
        return this;
    }

    public CacheServiceImpl expire_seconds(Integer expire) {
        this.expire = expire;
        this.unit = TimeUnit.SECONDS;
        if (AppUtils.notNull(this.key) && AppUtils.notNull(expire) && AppUtils.notNull(unit)) {
            this.redisTemplate.expire(this.key, expire, unit);
        }
        return this;
    }

    public CacheServiceImpl expire_minutes(Integer expire) {
        this.expire = expire;
        this.unit = TimeUnit.MINUTES;
        if (AppUtils.notNull(this.key) && AppUtils.notNull(expire) && AppUtils.notNull(unit)) {
            this.redisTemplate.expire(this.key, expire, unit);
        }
        return this;
    }

    public CacheServiceImpl setKey(String key) {
        this.key = key;
        if (AppUtils.notNull(this.object)) {
            this.redisTemplate.opsForValue().set(key, object);
        }
        return this;
    }

    public CacheServiceImpl setObject(Object object) {
        this.object = object;
        if (AppUtils.notNull(this.key)) {
            this.redisTemplate.opsForValue().set(key, object);
        }
        return this;
    }

    public CacheServiceImpl pushMemoryCache(String key, Object object) throws AppException {
        try {
            if (AppUtils.notNull(key)) {
                this.redisTemplate.opsForValue().set(key, object);
                if (AppUtils.notNull(this.expire) && AppUtils.notNull(this.unit)) {
                    this.redisTemplate.expire(key, this.expire, this.unit);
                    init();
                }
            } else {
                return this;
            }
            return this;
        } catch (Exception ex) {
            log.error(ex.getMessage());
            return null;
        }
    }

    public CacheServiceImpl pushMemoryCache(String key, Object object, Integer expire) throws AppException {
        if (AppUtils.notNull(key) && AppUtils.notNull(object)) {
            this.redisTemplate.opsForValue().set(key, object);
            if (AppUtils.notNull(expire)) {
                this.redisTemplate.expire(key, expire, TimeUnit.SECONDS);
            }
            init();
        } else {
            throw new AppException("key null");
        }
        return this;
    }

    public CacheServiceImpl pushMemoryCache(String key, Object object, Integer expire, TimeUnit unit) throws AppException {
        if (AppUtils.notNull(key) && AppUtils.notNull(object)) {
            this.redisTemplate.opsForValue().set(key, object);
            if (AppUtils.notNull(expire) && AppUtils.notNull(unit)) {
                this.redisTemplate.expire(key, expire, unit);
            }
            init();
        } else {
            throw new AppException("key null");
        }
        return this;
    }

    public CacheServiceImpl pushMemoryCache() throws AppException {
        if (AppUtils.notNull(this.key) && AppUtils.notNull(this.object)) {
            this.redisTemplate.opsForValue().set(this.key, this.object);
            if (AppUtils.notNull(this.expire) && AppUtils.notNull(this.unit)) {
                this.redisTemplate.expire(this.key, this.expire, this.unit);
                init();
            }
        } else {
            throw new AppException("key null");
        }
        return this;
    }


    @Override
    public void flushAll() {
        redisTemplate.getConnectionFactory().getConnection().flushAll();
    }
}
