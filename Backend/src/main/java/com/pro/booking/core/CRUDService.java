package com.pro.booking.core;

import com.pro.booking.constants.Constants;
import com.pro.booking.constants.ErrorResponse;
import com.pro.booking.core.base.BaseSupport;
import com.pro.booking.core.base.BaseEntity;
import com.pro.booking.core.base.BaseMapperService;
import com.pro.booking.core.base.BaseDTO;
import com.pro.booking.exception.AppException;
import com.pro.booking.repository.BaseRepositoryCustom;
import com.pro.booking.service.impl.AuditLogServiceImpl;
import com.pro.booking.service.impl.MailServiceImpl;
import com.pro.booking.utils.AppUtils;
import jakarta.persistence.Column;
import jakarta.persistence.Id;
import jakarta.persistence.MappedSuperclass;
import jakarta.transaction.Transactional;
import lombok.SneakyThrows;
import lombok.extern.slf4j.Slf4j;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.transaction.support.TransactionSynchronizationAdapter;
import org.springframework.transaction.support.TransactionSynchronizationManager;

import java.io.Serializable;
import java.lang.reflect.Field;
import java.time.LocalDateTime;
import java.util.*;

@Transactional
@Slf4j
@MappedSuperclass
@SuppressWarnings("all")
public abstract class CRUDService<T extends BaseEntity, DTO, ID extends Serializable, R extends JpaRepository<T, ID>> extends BaseSupport {
    public final R repository;
    private final Class<T> entityType;
    private final Class<DTO> valueType;
    private String className;
    protected BaseMapperService<T, DTO> mapper;
    private static final Long SYSTEM_USER_ID = 0L;
    protected static String[] skipClassLog = {"Notification, Address"};
    protected static String[] classAutoCreateNoti = {
            "Room",
            "Booking",
            "Payment",
            "Review",
    };
    @Autowired
    public ModelMapper modelMapper;
    @Autowired
    @Lazy
    private AuditLogServiceImpl auditService;
    @Autowired
    @Lazy
    private MailServiceImpl mailService;

    public CRUDService(R repository, Class<T> entityType, Class<DTO> valueType) {
        this.repository = repository;
        this.entityType = entityType;
        this.valueType = valueType;
        this.className = this.getClass().getSimpleName();
        this.mapper = new BaseMapperService<>();
        this.mapper.init(entityType, valueType);
    }

    @Transactional(rollbackOn = {AppException.class, Exception.class})
    public DTO create(DTO dto) throws AppException {
        T mainEntity = mapper.toEntity(dto);
        try {
            beforeCreate(dto, mainEntity);
            mainEntity = repository.saveAndFlush(mainEntity);
            repository.flush();
            afterCreate(dto, mainEntity);
            T finalMainEntity = mainEntity;
            commit(finalMainEntity, Constants.SUBSCRIBE_ACTION.INSERT);
            return mapper.toDto(mainEntity);
        } catch (DataIntegrityViolationException ex) {
            String errorMessage = ex.getMostSpecificCause().getMessage();
            if (errorMessage.contains("Duplicate entry")) {
                String value = errorMessage.split("'")[1];
                String field = errorMessage.split("for key '")[1].replace("'", "");
                throw new AppException(ErrorResponse.DUPLICATE_DATA.getCode(), "Value '" + value + "' exists");
            }
            throw new AppException(ErrorResponse.ERROR.getMessage(), "Error Data: " + errorMessage);
        } catch (AppException ex) {
            ex.printStackTrace();
            throw new AppException(ex);
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new AppException(ErrorResponse.ERROR, ex);
        }
    }

    @Transactional(rollbackOn = {AppException.class, Exception.class})
    public T create(T entity) throws AppException {
        try {
            beforeCreate(entity);
            entity = repository.saveAndFlush(entity);
            repository.flush();
            afterCreate(entity);
            T finalEntity = entity;
            commit(finalEntity, Constants.SUBSCRIBE_ACTION.INSERT);
            return entity;
        } catch (DataIntegrityViolationException ex) {
            String errorMessage = ex.getMostSpecificCause().getMessage();
            if (errorMessage.contains("Duplicate entry")) {
                String value = errorMessage.split("'")[1];
                String field = errorMessage.split("for key '")[1].replace("'", "");
                throw new AppException(ErrorResponse.DUPLICATE_DATA.getCode(), "Value '" + value + "' exists");
            }
            throw new AppException(ErrorResponse.ERROR.getMessage(), " Error Data: " + errorMessage);
        } catch (AppException ex) {
            ex.printStackTrace();
            throw new AppException(ex);
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new AppException(ErrorResponse.ERROR, ex);
        }
    }

    private Long getSafeUserId() {
        try {
            return getLoginUser() != null ? getLoginUser().getId() : SYSTEM_USER_ID;
        } catch (Exception e) {
            return SYSTEM_USER_ID;
        }
    }


    @Transactional(rollbackOn = {AppException.class, Exception.class})
    public List<DTO> create(List<DTO> dtoList) throws AppException {
        List<DTO> result = new ArrayList<>();
        for (DTO dto : dtoList) {
            T mainEntity = mapper.toEntity(dto);
            try {
                beforeCreate(dto, mainEntity);
                mainEntity = repository.saveAndFlush(mainEntity);
                repository.flush();
                afterCreate(dto, mainEntity);
                result.add(mapper.toDto(mainEntity));
                commit(mainEntity, Constants.SUBSCRIBE_ACTION.INSERT);
            } catch (DataIntegrityViolationException ex) {
                String errorMessage = ex.getMostSpecificCause().getMessage();
                if (errorMessage.contains("Duplicate entry")) {
                    String value = errorMessage.split("'")[1];
                    throw new AppException(ErrorResponse.DUPLICATE_DATA.getCode(), "Value '" + value + "' exists");
                }
                throw new AppException(ErrorResponse.ERROR.getMessage(), "Error Data: " + errorMessage);
            } catch (AppException ex) {
                ex.printStackTrace();
                throw ex;
            } catch (Exception ex) {
                ex.printStackTrace();
                throw new AppException(ErrorResponse.ERROR.getMessage(), ex);
            }
        }
        return result;
    }


    public void beforeCreate(DTO dto, T entity) throws AppException {
        Long userId = getSafeUserId();
        if (AppUtils.isNullObject(entity.getCreatedDate())) entity.setCreatedDate(LocalDateTime.now());
        if (AppUtils.isNullObject(entity.getLastUpdatedDate())) entity.setLastUpdatedDate(LocalDateTime.now());
    }

    public void beforeCreate(T entity) throws AppException {
        Long userId = getSafeUserId();
        if (AppUtils.isNullObject(entity.getCreatedDate())) entity.setCreatedDate(LocalDateTime.now());
        if (AppUtils.isNullObject(entity.getLastUpdatedDate())) entity.setLastUpdatedDate(LocalDateTime.now());
    }

    @Transactional(rollbackOn = {AppException.class, Exception.class})
    public DTO update(DTO dto) throws AppException {
        T entity = mapper.toEntity(dto);
        try {
            beforeUpdate(dto, entity);
            entity = repository.saveAndFlush(entity);
            repository.flush();
            afterUpdate(dto, entity);
            T finalEntity = entity;
            commit(finalEntity, Constants.SUBSCRIBE_ACTION.UPDATE);
            return mapper.toDto(entity);
        } catch (DataIntegrityViolationException ex) {
            String errorMessage = ex.getMostSpecificCause().getMessage();
            if (errorMessage.contains("Duplicate entry")) {
                String value = errorMessage.split("'")[1];
                String field = errorMessage.split("for key '")[1].replace("'", "");
                throw new AppException(ErrorResponse.DUPLICATE_DATA.getCode(), "Value '" + value + "' exists");
            }
            throw new AppException(ErrorResponse.ERROR.getMessage(), "Error Data: " + errorMessage);
        } catch (Exception ex) {
            ex.printStackTrace();
            log.error(ex.getMessage());
            throw new AppException(ErrorResponse.DEFAULT, ex);
        }
    }

    @Transactional(rollbackOn = {AppException.class, Exception.class})
    public T update(T entity) throws AppException {
        try {
            beforeUpdate(entity);
            entity = repository.saveAndFlush(entity);
            repository.flush();
            afterUpdate(entity);
            T finalEntity = entity;
            commit(finalEntity, Constants.SUBSCRIBE_ACTION.UPDATE);
            return entity;
        } catch (DataIntegrityViolationException ex) {
            ex.printStackTrace();
            String errorMessage = ex.getMostSpecificCause().getMessage();
            if (errorMessage.contains("Duplicate entry")) {
                String value = errorMessage.split("'")[1];
                String field = errorMessage.split("for key '")[1].replace("'", "");
                throw new AppException(ErrorResponse.DUPLICATE_DATA.getCode(), "Value '" + value + "' exists");
            }
            throw new AppException(ErrorResponse.ERROR.getMessage(), "Error Data: " + errorMessage);
        } catch (Exception ex) {
            ex.printStackTrace();
            log.error(ex.getMessage());
            throw new AppException(ErrorResponse.DEFAULT, ex);
        }
    }


    protected void afterCreate(List<DTO> dtos, List<T> entitys) throws AppException {
        if (AppUtils.notNullOrEmpty(entitys)) {
            for (T t : entitys) {
                afterCreate(mapper.toDto(t), t);
            }
        }
    }

    public void commit(List<T> entitys, int action) {
        TransactionSynchronizationManager.registerSynchronization(new TransactionSynchronizationAdapter() {
            @SneakyThrows
            @Override
            public void afterCommit() {
                if (AppUtils.notNullOrEmpty(entitys)) {
                    interfaceAfterCommit(entitys, action);
                    if (AppUtils.safeEqual(entityType.getSimpleName(), classAutoCreateNoti)) {
                        AppUtils.DEBUG(entityType.getSimpleName());
                        for (T entity : entitys) {
                            mailService.sendMail(entity, action);
                            auditService.create(entity, action);
                        }
                    }
                }
            }
        });
    }

    public void commit(T entity, int action) {
        TransactionSynchronizationManager.registerSynchronization(new TransactionSynchronizationAdapter() {
            @SneakyThrows
            @Override
            public void afterCommit() {
                interfaceAfterCommit(entity, action);
                AppUtils.DEBUG(entityType.getSimpleName());
                if (AppUtils.safeEqual(entityType.getSimpleName(), classAutoCreateNoti)) {
                    mailService.sendMail(entity, action);
                    auditService.create(entity, action);
                }
            }
        });
    }

    protected void afterCreate(DTO dto, T entity) throws AppException {
    }

    protected void afterCreate(T entity) throws AppException {
    }

    protected void afterUpdate(DTO dto, T updated) throws AppException {
//        writeLog(getUserInfo(), id, old, updated);
    }

    protected void afterUpdate(T updated) throws AppException {
//        writeLog(getUserInfo(), id, old, updated);
    }

    protected void afterUpdate(List<DTO> dto, List<T> entitys) throws AppException {
        if (AppUtils.notNullOrEmpty(entitys)) {
            for (T t : entitys) {
                afterUpdate(mapper.toDto(t), t);
            }
        }
    }

    @Transactional(rollbackOn = {AppException.class, Exception.class})
    public List<DTO> update(List<DTO> dtos) throws AppException {
        List<T> entitys = mapper.toEntityList(dtos);
        try {
            beforeUpdate(dtos, entitys);
            afterUpdate(dtos, entitys);
            commit(entitys, Constants.SUBSCRIBE_ACTION.UPDATE);
            return mapper.toDtoList(entitys);
        } catch (DataIntegrityViolationException ex) {
            String errorMessage = ex.getMostSpecificCause().getMessage();
            if (errorMessage.contains("Duplicate entry")) {
                String value = errorMessage.split("'")[1];
                String field = errorMessage.split("for key '")[1].replace("'", "");
                throw new AppException(ErrorResponse.DUPLICATE_DATA.getCode(), "Value '" + value + "' exists");
            }
            throw new AppException(ErrorResponse.ERROR.getMessage(), "Error Data: " + errorMessage);
        } catch (Exception ex) {
            ex.printStackTrace();
            log.error(ex.getMessage());
            throw new AppException(ErrorResponse.DEFAULT, ex);
        }
    }


    public T get(ID id) throws AppException {
        Optional<T> optionalT = repository.findById(id);
        if (AppUtils.notNull(optionalT)) {
            if (optionalT.isPresent()) {
                return optionalT.get();
            }
        }
        return null;
    }


    public DTO getDto(ID id) throws AppException {
        T entity = repository.findById(id)
                .orElseThrow(() -> new AppException());
        return mapper.toDto(entity);
    }

    public List<T> findAll() {
        return repository.findAll();
    }

    public List<T> findAllByIds(Iterable<Long> ids) {
        return repository.findAllById((Iterable<ID>) ids);
    }

    public List<DTO> getAll() {
        return mapper.toDtoList(repository.findAll());
    }

    public Page<T> findAll(Pageable pageable) {
        return repository.findAll(pageable);
    }

    public List<T> search(String query) {
        return repository.findAll();
    }

    public Page<T> search(String query, Pageable pageable) {
        return searchByQuery(query, pageable);
    }

    public <DTO> Page<DTO> search(Object searchDTO, Class<T> classOutput) {
        try {
            if (AppUtils.isNullOrZero(((BaseDTO) searchDTO).getLimit())) ((BaseDTO) searchDTO).setLimit(10);
            if (AppUtils.isNullOrZero(((BaseDTO) searchDTO).getPage())) ((BaseDTO) searchDTO).setPage(0);
            return ((BaseRepositoryCustom) repository).search(searchDTO, classOutput);
        } catch (Exception e) {
            e.printStackTrace();
            log.error(e.getMessage(), e);
        } finally {
//            createLogTIMKIEM();
        }
        return null;
    }

    public Page<T> searchByQuery(String query, Pageable pageable) {
        if (AppUtils.isNullOrEmpty(query)) {
            return repository.findAll(pageable);
        }
        return searchByQuery(query, pageable);
    }

    public DTO getDetail(DTO tmp) throws AppException {
        return getDetailData(tmp);
    }

    public DTO getDetailData(DTO tmp) throws AppException {
        T entity = get(getID(mapper.toEntity(tmp)));
        return mapper.toDto(entity);
    }

    protected void beforeUpdate(DTO dto, T entity) throws AppException {
        entity.setLastUpdatedDate(LocalDateTime.now());
    }

    protected void beforeUpdate(T entity) throws AppException {
        entity.setLastUpdatedDate(LocalDateTime.now());
    }

    protected void beforeUpdate(List<DTO> dto, List<T> entitys) throws AppException {
        for (T entity : entitys) {
            entity.setLastUpdatedDate(LocalDateTime.now());
        }
    }

    protected ID getID(T entity) throws AppException {
        try {
            for (Field f : entity.getClass().getDeclaredFields()) {
                Column column = f.getAnnotation(Column.class);
                if (column != null) {
                    Id id = f.getAnnotation(Id.class);
                    if (id != null) {
                        Field field = entity.getClass().getDeclaredField(f.getName());
                        field.setAccessible(true);
                        return (ID) field.get(entity);
                    }
                }
            }
        } catch (Exception ex) {
            log.error("khong ton tai ID");
        }
        return null;
    }

    protected List<ID> getIDS(List<T> entitys) throws AppException {
        try {
            for (T t : entitys) {
                List<Id> ids = Arrays.stream(entitys.getClass().getDeclaredFields()).map(field -> field.getAnnotation(Id.class)).toList();
            }
        } catch (Exception ex) {
            log.error("khong ton tai ID");
        }
        return null;
    }

    @Transactional(rollbackOn = {AppException.class, Exception.class})
    public void delete(List<DTO> dtos) throws AppException {
        List<T> entitys = mapper.toEntityList(dtos);
        try {
            repository.deleteInBatch(entitys);
            repository.flush();
            commit(entitys, Constants.SUBSCRIBE_ACTION.DELETE);
        } catch (Exception ex) {
        }
    }

    @Transactional(rollbackOn = {AppException.class, Exception.class})
    public void delete(DTO dto) throws AppException {
        T entity = get(getID(mapper.toEntity(dto)));
        try {
            repository.delete(entity);
            repository.flush();
            commit(entity, Constants.SUBSCRIBE_ACTION.DELETE);
        } finally {

        }
    }

    @Transactional(rollbackOn = {AppException.class, Exception.class})
    public void delete(ID id) throws AppException {
        T entity = get(id);
        try {
            repository.delete(entity);
            repository.flush();
            commit(entity, Constants.SUBSCRIBE_ACTION.DELETE);
        } finally {
        }
    }

    @Transactional(rollbackOn = {AppException.class, Exception.class})
    public void deleteAll() {
        try {
            repository.deleteAllInBatch();
        } catch (Exception e) {
            throw e;
        }
    }

    protected void afterCommit(T entity, int action) throws AppException {
    }

    protected void interfaceAfterCommit(T entity, int action) throws AppException {
        afterCommit(entity, action);
    }

    protected void afterCommit(List<T> entities, int action) throws AppException {
    }

    protected void interfaceAfterCommit(List<T> entities, int action) throws AppException {
        afterCommit(entities, action);
    }

    public long cound() {
        return repository.count();
    }

}
