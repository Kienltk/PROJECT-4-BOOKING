package com.pro.booking.controller.auth;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.pro.booking.config.security.CustomUserDetails;
import com.pro.booking.constants.Constants;
import com.pro.booking.constants.ErrorResponse;
import com.pro.booking.core.CRUDInterface;
import com.pro.booking.entity.DTO.AuthToken;
import com.pro.booking.entity.DTO.BaseRequestDTO;
import com.pro.booking.entity.DTO.UserDTO;
import com.pro.booking.entity.model.User;
import com.pro.booking.entity.request.CallbackBalanceRequest;
import com.pro.booking.entity.request.LoginRequest;
import com.pro.booking.entity.request.UserRegisterRequest;
import com.pro.booking.exception.AppException;
import com.pro.booking.repository.UserRepository;
import com.pro.booking.service.impl.BookingServiceImpl;
import com.pro.booking.service.impl.UserServiceImpl;
import com.pro.booking.utils.AppUtils;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.Map;

@RestController
@Slf4j
@RequestMapping(value = "/api/auth")
public class AuthController extends CRUDInterface<User, Long, UserDTO, UserRepository, UserServiceImpl> {
    protected AuthController(UserServiceImpl service, AuthenticationManager auth, BookingServiceImpl bookingService) {
        super(service, User.class, UserDTO.class);
        this.authenticationManager = auth;
        this.bookingService = bookingService;
    }
    private final BookingServiceImpl bookingService;
    @Value("${jwt.expiration}")
    private long JWT_EXPIRATION_MINUTES;

    @Value("${jwt.refresh.expiration}")
    private long JWT_REFRESH_EXPIRATION_MINUTES;

    private final AuthenticationManager authenticationManager;


    @PostMapping("/callbackChangeBalance")
    public Object callbackChangeBalance(@RequestBody BaseRequestDTO<CallbackBalanceRequest> baseRequestDTO) {
        CallbackBalanceRequest dto = baseRequestDTO.getPayload();
        bookingService.changeBalance(dto);
        return sendSuccess();
    }



    @PostMapping("/register")
    public Object create(@RequestBody BaseRequestDTO<UserRegisterRequest> baseRequestDTO) {
        try {
            service.create(baseRequestDTO.getPayload());
            return sendSuccess();
        } catch (AppException e) {
            return sendError(e.getErrorCode(), e.getMessage());
        }
    }

    @PostMapping("/login")
    public Object login(@RequestBody BaseRequestDTO<LoginRequest> baseRequestDTO) {
        try {
            LoginRequest loginRequest = baseRequestDTO.getPayload();
            Authentication auth = authenticationManager.authenticate(
                    new UsernamePasswordAuthenticationToken(
                            loginRequest.getUsername(), loginRequest.getPassword())
            );
            if (auth.isAuthenticated()) {
                CustomUserDetails custom = (CustomUserDetails) auth.getPrincipal();
                User user = custom.user();
                Map<String, Object> response = new HashMap<>();
                String refreshToken = jwtService.generateRefreshToken(user.getUsername());
                String token = jwtService.generateToken(user.getUsername());
                setLoginUser(user);
                UserDTO userDTO = modelMapper.map(user, UserDTO.class);
                userDTO.setAddress(getFullAddress(user));
                userDTO.setPassword(null);
                response.put("token", token);
                response.put("refreshToken", refreshToken);
                response.put("expiration", JWT_EXPIRATION_MINUTES);
                response.put("refreshExpiration", JWT_REFRESH_EXPIRATION_MINUTES);
                response.put("user", userDTO);
                return sendSuccess(response);
            }
        } catch (BadCredentialsException ignored) {
            return sendError(ErrorResponse.INCORRECT_USERNAME_OR_PASSWORD);
        } catch (AppException e) {
            return sendError(e.getErrorCode(), e.getMessage());
        } catch (JsonProcessingException e) {
            throw new RuntimeException(e);
        }
        return sendError(ErrorResponse.INCORRECT_USERNAME_OR_PASSWORD);
    }

    @PostMapping("/refreshToken")
    public Object refreshToken(@RequestBody BaseRequestDTO<AuthToken> requestDTO) {
        AuthToken authToken = requestDTO.getPayload();
        try {
            String refreshToken = authToken.getRefreshToken();
            if (refreshToken == null || refreshToken.isBlank()) {
                return sendError(ErrorResponse.INVALID_REFRESH_TOKEN);
            }
            if (!jwtService.validateToken(refreshToken)) {
                return sendError(ErrorResponse.INVALID_OR_EXPIRED_TOKEN);
            }
            String username = jwtService.extractUsername(refreshToken);
            if (username == null) {
                return sendError(ErrorResponse.INVALID_OR_EXPIRED_TOKEN);
            }
            Object cachedUser = cacheService.get(Constants.REDIS.DATA_USER + username);
            if (cachedUser == null) {
                User user = service.checkExits(username);
                cachedUser = gson.toJson(user);
            }
            User user = gson.fromJson((String) cachedUser, User.class);
            setLoginUser(user);
            user.setPassword(null);
            String newToken = jwtService.generateToken(username);
            Map<String, Object> response = new HashMap<>();
            response.put("token", newToken);
            response.put("refreshToken", refreshToken);
            response.put("expiration", JWT_EXPIRATION_MINUTES);
            response.put("refreshExpiration", JWT_REFRESH_EXPIRATION_MINUTES);
            response.put("user", user);
            return sendSuccess(response);
        } catch (Exception e) {
            return sendError(ErrorResponse.INVALID_REFRESH_TOKEN);
        }
    }


}
