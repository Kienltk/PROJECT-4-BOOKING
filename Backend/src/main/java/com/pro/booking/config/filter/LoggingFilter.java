package com.pro.booking.config.filter;

import com.pro.booking.config.security.CustomUserDetails;
import com.pro.booking.entity.model.User;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;

import java.io.IOException;
import java.time.LocalDateTime;

@Component
public class LoggingFilter extends OncePerRequestFilter {

    private static final Logger logger = LoggerFactory.getLogger(LoggingFilter.class);

    @Override
    protected void doFilterInternal(HttpServletRequest request,
                                    HttpServletResponse response,
                                    FilterChain filterChain)
            throws ServletException, IOException {

        String method = request.getMethod();
        String uri = request.getRequestURI();
        LocalDateTime time = LocalDateTime.now();

        filterChain.doFilter(request, response);
        int status = response.getStatus();
        String username = "ANONYMOUS";
        String fullname = "ANONYMOUS";
        var auth = SecurityContextHolder.getContext().getAuthentication();
        if (auth != null && auth.isAuthenticated() && auth.getPrincipal() instanceof CustomUserDetails(
                User user
        )) {
            username = user.getUsername();
            fullname = user.getFullName();
        }
        logger.info("{} | {} | {} | {} | {}", time, status, username + " (" + fullname + ")", method, uri);
    }

}
