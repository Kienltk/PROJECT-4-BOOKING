package com.pro.booking.core.base;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonInclude;
import com.pro.booking.entity.DTO.ValidateDTO;
import com.pro.booking.entity.model.FilterRequest;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import lombok.experimental.SuperBuilder;
import java.io.Serializable;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@EqualsAndHashCode(callSuper = true)
@Data
@SuperBuilder
@JsonIgnoreProperties
@AllArgsConstructor
@NoArgsConstructor
public class BaseDTO extends ValidateDTO implements Serializable {
    @JsonInclude(JsonInclude.Include.NON_NULL)
    private List<FilterRequest> filterRequests;

    @JsonInclude(JsonInclude.Include.NON_NULL)
    String lang;

    @JsonInclude(JsonInclude.Include.NON_NULL)
    List<String> sort;

    @JsonInclude(JsonInclude.Include.NON_NULL)
    Integer limit;

    @JsonInclude(JsonInclude.Include.NON_NULL)
    Integer page;

    @JsonInclude(JsonInclude.Include.NON_NULL)
    private Long createdBy;
    @JsonInclude(JsonInclude.Include.NON_NULL)
    private String createdByName;

    @JsonInclude(JsonInclude.Include.NON_NULL)
    private Long lastUpdatedBy;
    @JsonInclude(JsonInclude.Include.NON_NULL)
    private String lastUpdatedByName;

    @JsonInclude(JsonInclude.Include.NON_NULL)
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime createdDate;
    @JsonInclude(JsonInclude.Include.NON_NULL)
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime createdDateFrom;
    @JsonInclude(JsonInclude.Include.NON_NULL)
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime createdDateTo;

    @JsonInclude(JsonInclude.Include.NON_NULL)
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime lastUpdatedDate;
    @JsonInclude(JsonInclude.Include.NON_NULL)
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime lastUpdatedDateFrom;
    @JsonInclude(JsonInclude.Include.NON_NULL)
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime lastUpdatedDateTo;

    @JsonInclude(JsonInclude.Include.NON_NULL)
    private Long status;
    @JsonInclude(JsonInclude.Include.NON_NULL)
    private String statusName;

    @JsonIgnore
    @JsonInclude(JsonInclude.Include.NON_NULL)
    public List<String> extenCondition = new ArrayList<>();

    @JsonIgnore
    @JsonInclude(JsonInclude.Include.NON_NULL)
    private Boolean isDefaultStatus = true;
    @JsonInclude(JsonInclude.Include.NON_NULL)
    private String actionKey;
}
