package com.pro.booking.entity.request;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.pro.booking.core.base.BaseDTO;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import lombok.experimental.SuperBuilder;

import java.io.Serializable;


@Data
@SuperBuilder
@NoArgsConstructor
@AllArgsConstructor
@EqualsAndHashCode(callSuper = true)
@JsonInclude(JsonInclude.Include.NON_NULL)
public class PaymentRequest extends BaseDTO implements Serializable {
    private String vnpVersion;       // Phiên bản API VNPAY, ví dụ: "2.1.0"
    private String vnpCommand;       // Mặc định: "pay"
    private String vnpTmnCode;       // Mã website do VNPAY cấp
    private String vnpAmount;        // Số tiền (nhân 100, VD: 1000000 -> 100000000)
    private String vnpCurrCode;      // Mã tiền tệ (VNĐ)
    private String vnpTxnRef;        // Mã giao dịch duy nhất
    private String vnpOrderInfo;     // Thông tin đơn hàng
    private String vnpOrderType;     // Loại đơn hàng
    private String vnpLocale;        // Ngôn ngữ hiển thị (vn/en)
    private String vnpReturnUrl;     // URL nhận kết quả trả về
    private String vnpIpAddr;        // IP của khách hàng
    private String vnpCreateDate;    // Thời gian tạo (định dạng yyyyMMddHHmmss)
    private String vnpExpireDate;    // Thời gian hết hạn (tùy chọn)
    private String vnpBankCode;
}