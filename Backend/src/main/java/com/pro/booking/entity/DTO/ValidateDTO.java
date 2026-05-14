package com.pro.booking.entity.DTO;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.SuperBuilder;
import lombok.extern.slf4j.Slf4j;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

@Data
@SuperBuilder
@JsonIgnoreProperties
@AllArgsConstructor
@NoArgsConstructor
@Slf4j
public class ValidateDTO implements Serializable {
    @JsonIgnore
    protected String keyName;
    @JsonIgnore
    protected Object dataObj;
    @JsonIgnore
    protected Integer maxLenV;
    @JsonIgnore
    protected Integer minLenV;
    @JsonIgnore
    protected Boolean isRequired;
    @JsonIgnore
    protected Class dataType;
    @JsonIgnore
    protected String requiredMsg;
    @JsonIgnore
    protected List<String> msgParam = new ArrayList<>();
    @JsonIgnore
    protected String maxlengthMsgV;
    @JsonIgnore
    protected String minlenMsgV;
    @JsonIgnore
    protected String dataTypeMsg;
    @JsonIgnore
    protected Boolean isError;
    @JsonIgnore
    protected String msg;

    public ValidateDTO(Object dataObj) {
        this.dataObj = dataObj;
        this.msg = "";
    }


}
