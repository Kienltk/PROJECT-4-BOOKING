package com.pro.booking.entity.DTO;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.pro.booking.core.base.BaseDTO;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.Accessors;
import lombok.experimental.SuperBuilder;
import org.modelmapper.ModelMapper;

import java.io.Serializable;
@Data
@SuperBuilder
@AllArgsConstructor
@NoArgsConstructor
@JsonInclude
@Accessors(chain = true)
@JsonIgnoreProperties(ignoreUnknown = true)

public class BaseRequestDTO<DTO extends BaseDTO> implements Serializable {
    @JsonProperty("payload")
    DTO payload;
    @JsonProperty("object")
    private Object object;
    String type;

    @JsonIgnore
    private ModelMapper modelMapper;
}
