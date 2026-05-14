package com.pro.booking.config;

import com.pro.booking.constants.Constants;
import io.swagger.v3.oas.models.OpenAPI;
import io.swagger.v3.oas.models.info.Contact;
import io.swagger.v3.oas.models.info.Info;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class ApiDocumentConfig {
    @Bean
    public OpenAPI customOpenAPI() {
        return new OpenAPI()
                .info(
                        new Info()
                                .title("Booking App API Documentation")
                                .description("Spring Boot REST API with Swagger & OpenAPI 3")
                                .version("1.0.0")
                                .contact(new Contact()
                                        .name(Constants.OWNER)
                                        .email(Constants.OWNER_MAIL)
                                ));
//                        .license(new License()
//                                .name("Apache 2.0")
//                                .url("http://springdoc.org")));
    }
}