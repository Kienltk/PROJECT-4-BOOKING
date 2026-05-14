package com.pro.booking.config.filter;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.pro.booking.config.LocalDateTimeAdapter;
import com.pro.booking.config.security.CustomUserDetails;
import com.pro.booking.constants.Constants;
import com.pro.booking.constants.ErrorResponse;
import com.pro.booking.entity.model.User;
import com.pro.booking.service.common.CacheService;
import com.pro.booking.service.common.JwtService;
import com.pro.booking.utils.AppUtils;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.WebAuthenticationDetailsSource;
import org.springframework.stereotype.Component;
import org.springframework.util.AntPathMatcher;
import org.springframework.web.filter.OncePerRequestFilter;

import java.io.IOException;
import java.time.LocalDateTime;
import java.util.Arrays;

@Component
public class JwtAuthenticationFilter extends OncePerRequestFilter {

    @Value("${api.public.endpoint}")
    private String PUBLIC_ENDPOINT;
    @Autowired
    private CacheService cacheService;

    private final Gson gson = new GsonBuilder()
            .registerTypeAdapter(LocalDateTime.class, new LocalDateTimeAdapter())
            .create();

    private final JwtService jwtService;

    public JwtAuthenticationFilter(JwtService jwtService) {
        this.jwtService = jwtService;
    }

    @Override
    protected void doFilterInternal(HttpServletRequest request,
                                    HttpServletResponse response,
                                    FilterChain filterChain) throws ServletException, IOException {
        String path = request.getRequestURI();
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        for (String endpoint : Arrays.stream(PUBLIC_ENDPOINT.split(","))
                .map(String::trim)
                .toList()) {
            if (new AntPathMatcher().match(endpoint, path)) {
                filterChain.doFilter(request, response);
                return;
            }
        }

        final String authHeader = request.getHeader("Authorization");
        if (authHeader == null || !authHeader.startsWith("Bearer ")) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            response.getWriter().write(gson.toJson(ErrorResponse.INVALID_OR_EXPIRED_TOKEN));
            return;
        }

        String jwt = authHeader.substring(7);
        if ((jwt.startsWith("\"") && jwt.endsWith("\"")) ||
                (jwt.startsWith("'") && jwt.endsWith("'"))) {
            jwt = jwt.substring(1, jwt.length() - 1);
        }

        try {
            String username = jwtService.extractUsername(jwt);
            if (sendError(response, username == null, username)) return;
            if (SecurityContextHolder.getContext().getAuthentication() != null) {
                filterChain.doFilter(request, response);
                return;
            }
            Object cachedUser = cacheService.get(Constants.REDIS.DATA_USER + username);
            if (sendError(response, cachedUser == null, username)) return;

            User user = gson.fromJson((String) cachedUser, User.class);
            CustomUserDetails userDetails = new CustomUserDetails(user);

            if (!jwtService.isTokenValid(jwt, userDetails)) {
                response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
                response.getWriter().write(gson.toJson(ErrorResponse.INVALID_OR_EXPIRED_TOKEN));
                return;
            }

            UsernamePasswordAuthenticationToken authToken =
                    new UsernamePasswordAuthenticationToken(
                            userDetails,
                            null,
                            userDetails.getAuthorities()
                    );
            authToken.setDetails(new WebAuthenticationDetailsSource().buildDetails(request));
            SecurityContextHolder.getContext().setAuthentication(authToken);
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            response.getWriter().write(gson.toJson(ErrorResponse.INVALID_TOKEN));
            return;
        }
        filterChain.doFilter(request, response);
    }

    private boolean sendError(HttpServletResponse response, boolean b, String username) throws IOException {
        if (b) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            response.getWriter().write(gson.toJson(ErrorResponse.INVALID_OR_EXPIRED_TOKEN));
            return true;
        }
        return false;
    }

}
