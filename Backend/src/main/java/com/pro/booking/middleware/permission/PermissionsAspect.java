package com.pro.booking.middleware.permission;

import com.pro.booking.constants.ErrorResponse;
import com.pro.booking.core.base.BaseSupport;
import com.pro.booking.entity.model.User;
import com.pro.booking.exception.AppException;
import com.pro.booking.utils.AppUtils;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.reflect.MethodSignature;
import org.springframework.stereotype.Component;

@Aspect
@Component
public class PermissionsAspect extends BaseSupport {
    @Before(value = "@annotation(com.pro.booking.middleware.permission.Permissions)")
    public void getAccountOperationInfo(JoinPoint joinPoint) throws AppException {
        MethodSignature signature = (MethodSignature) joinPoint.getSignature();
        Permissions permissionsOperation = signature.getMethod().getAnnotation(Permissions.class);
        AppUtils.DEBUG(permissionsOperation);
        assert permissionsOperation != null;
        if (AppUtils.isNullObject(permissionsOperation.role())) {
            return;
        }
        long role = permissionsOperation.role();
        User user = getLoginUser();
        if (role != user.getType()) {
            throw new AppException(ErrorResponse.ERROR_PERMISSION);
        }
    }
}
