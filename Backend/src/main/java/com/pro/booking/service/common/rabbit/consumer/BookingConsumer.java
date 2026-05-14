package com.pro.booking.service.common.rabbit.consumer;

import com.pro.booking.config.RabbitMQConfig;
import com.pro.booking.core.base.BaseSupport;
import com.pro.booking.entity.DTO.BookingDTO;
import com.pro.booking.utils.AppUtils;
import org.springframework.amqp.rabbit.annotation.RabbitListener;
import org.springframework.stereotype.Service;

import java.util.Objects;

@Service
public class BookingConsumer extends BaseSupport {

    @RabbitListener(queues = RabbitMQConfig.QUEUE_NAME)
    public void handleMessage(Object data) {
        AppUtils.DEBUG(data);
    }


    public String generateBookingEmail(BookingDTO bookingDTO) {
        String template = loadTemplate("booking_email_template.html");
        return template
                .replace("{{customerName}}", bookingDTO.getRenterDTO().getUsername())
                .replace("{{bookingId}}", bookingDTO.getId().toString())
                .replace("{{roomName}}", bookingDTO.getRoomDTO().getTitle())
                .replace("{{checkInDate}}", bookingDTO.getCheckInDate().toString())
                .replace("{{checkOutDate}}", bookingDTO.getCheckOutDate().toString())
                .replace("{{totalNights}}", bookingDTO.getCheckOutDate().toString())
                .replace("{{totalPrice}}", bookingDTO.getTotalPrice().toString())
                .replace("{{year}}", String.valueOf(java.time.Year.now()));
    }

    private String loadTemplate(String fileName) {
        try {
            return new String(Objects.requireNonNull(getClass().getClassLoader()
                    .getResourceAsStream("templates/" + fileName)).readAllBytes());
        } catch (Exception e) {
            throw new RuntimeException("Cannot load email template", e);
        }
    }

}

