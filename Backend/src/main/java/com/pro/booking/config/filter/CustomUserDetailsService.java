package com.pro.booking.config.filter;

import com.pro.booking.config.security.CustomUserDetails;
import com.pro.booking.constants.ErrorResponse;
import com.pro.booking.entity.model.User;
import com.pro.booking.exception.AppException;
import com.pro.booking.service.impl.UserServiceImpl;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

@Service
public class CustomUserDetailsService implements UserDetailsService {
    private final UserServiceImpl service;

    public CustomUserDetailsService(UserServiceImpl service) {
        this.service = service;
    }

    @Override
    public UserDetails loadUserByUsername(String username)
            throws UsernameNotFoundException {
        try {
            User user = service.checkExits(username);
            return new CustomUserDetails(user);
        } catch (AppException ex) {
            throw new UsernameNotFoundException(ErrorResponse.USER_NOT_FOUND.getMessage());
        }
    }


}