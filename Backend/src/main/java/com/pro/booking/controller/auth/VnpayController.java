package com.pro.booking.controller.auth;

import com.pro.booking.entity.DTO.BaseRequestDTO;
import com.pro.booking.entity.request.PaymentRequest;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.view.RedirectView;

@RestController
@RequestMapping(value = "/api/auth")
public class VnpayController {

    @Value("${vnpay.url}")
    private String vnpUrl;
    @Value("${vnpay.tmnCode}")
    private String vnpTmnCode;
    @Value("${vnpay.hashSecret}")
    private String vnpHashSecret;
    @Value("${vnpay.returnUrl}")
    private String vnpReturnUrl;

    @PostMapping("/createPayment")
    public RedirectView createPayment(@RequestBody BaseRequestDTO<PaymentRequest> req) {
        PaymentRequest dto = req.getPayload();

//        try {
//            Map<String, String> vnpParams = new HashMap<>();
//            vnpParams.put("vnp_Version", "2.1.0");
//            vnpParams.put("vnp_Command", "pay");
//            vnpParams.put("vnp_TmnCode", vnpTmnCode);
//            vnpParams.put("vnp_Amount", String.valueOf(dto.getVnpAmount().multiply(new BigDecimal(100)).longValue()));
//            vnpParams.put("vnp_CurrCode", "VND");
//            vnpParams.put("vnp_TxnRef", dto.getOrderId());
//            vnpParams.put("vnp_OrderInfo", dto.getOrderInfo());
//            vnpParams.put("vnp_OrderType", dto.getOrderType() != null ? dto.getOrderType() : "other");
//            vnpParams.put("vnp_ReturnUrl", vnpReturnUrl);
//            vnpParams.put("vnp_IpAddr", dto.getIp());
//            vnpParams.put("vnp_CreateDate", LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyyMMddHHmmss")));
//
//            String query = VnpayUtil.buildSecureQuery(vnpParams, vnpHashSecret);
//            String redirectUrl = vnpUrl + "?" + query;
//            return new RedirectView(redirectUrl);
//        } catch (Exception e) {
//            throw new RuntimeException(e);
//        }
        throw new RuntimeException();
    }

}
