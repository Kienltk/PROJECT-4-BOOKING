package com.pro.booking.service.common.rabbit.producer;
import org.springframework.amqp.rabbit.core.RabbitTemplate;
import org.springframework.stereotype.Service;

@Service
public class BookingProducer {
    private final RabbitTemplate rabbitTemplate;

    public BookingProducer(RabbitTemplate rabbitTemplate) {
        this.rabbitTemplate = rabbitTemplate;
    }

    public void send(Object data) {
//        rabbitTemplate.convertAndSend(
//                RabbitMQConfig.EXCHANGE_NAME,
//                RabbitMQConfig.ROUTING_KEY,
//                data
//        );
    }
}
