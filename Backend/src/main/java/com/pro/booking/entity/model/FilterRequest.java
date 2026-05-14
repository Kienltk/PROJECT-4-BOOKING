package com.pro.booking.entity.model;

import lombok.Data;

import java.io.Serializable;
import java.util.List;
import java.util.Objects;

@Data
public class FilterRequest implements Serializable {

    public enum ORDER_BY {
        ASC, DESC
    }

    public enum Operator {
        IN,
        IN_OR,
        EQ,
        NE,
        NOTIN,
        EQALL,
        AQANY,
        AS,
        LT,//nho hon
        LT_OR,//nho hon
        GT,//lon hon
        GT_DATE,
        LT_DATE,
        GT_DATE_TRUNC,
        LT_DATE_TRUNC,
        EQ_DATE_TRUNC,
        LOE,
        GOE,
        BETWEEN,
        LIKE,
        LIMIT,
        LIKE_OR,
        DATE_LIKE_OR,
        EXACT,
        LIKE_BEGIN,
        LIKE_END,
        RANGE,
        TRUNC_DAY_LOE,
        IS_NULL,
        IS_NOT_NULL,
        OR_REQUEST,
        AND_REQUEST,
        ORDER_BY,
    }

    private String property;
    private String propertyName;
    private String entity;
    private Object value;
    private boolean extract = true;
    private boolean notEqual;
    private boolean isNull;
    private boolean forLookup;
    private Operator operator;
    private ORDER_BY orderBy;
    private String valueType;
    private String valueText;

    private boolean valueInRange; // Tham so truyen vao la 1 RangeValue
    private boolean valueInList; // Tham so truyen vao la 1 list

    private List<FilterRequest> filterRequests;


    @Override
    public int hashCode() {
        return Objects.hash(property, value, operator);
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }
        if (obj == null || getClass() != obj.getClass()) {
            return false;
        }
        final FilterRequest other = (FilterRequest) obj;
        return Objects.equals(this.property, other.property) && Objects.equals(this.value, other.value) && Objects.equals(this.operator, other.operator);
    }

    public FilterRequest(Operator operator, Object value) {
        this.value = value;
        this.operator = operator;
    }

    public FilterRequest(String property, Operator operator, Object value) {
        this.property = property;
        this.value = value;
        this.operator = operator;
    }

    public FilterRequest(String property, Operator operator, ORDER_BY orderBy) {
        this.property = property;
        this.orderBy = orderBy;
        this.operator = operator;
    }

    public FilterRequest(String property, Operator operator, String propertyName, Object value) {
        this.property = property;
        this.value = value;
        this.propertyName = propertyName;
        this.operator = operator;
    }


    public FilterRequest(String property, Operator operator, Object value, List<FilterRequest> filterRequests) {
        this.property = property;
        this.value = value;
        this.operator = operator;
        this.filterRequests = filterRequests;
    }

    public FilterRequest(Operator operator, List<FilterRequest> filterRequests) {
        this.property = property;
        this.filterRequests = filterRequests;
        this.operator = operator;
    }

    public FilterRequest(String property, Operator operator, List<FilterRequest> filterRequests) {
        this.property = property;
        this.filterRequests = filterRequests;
        this.operator = operator;
    }

    public FilterRequest(String property, Operator operator, Object value, boolean extract) {
        this.property = property;
        this.value = value;
        this.extract = extract;
        this.operator = operator;
    }

    public FilterRequest(Operator operator, FilterRequest filterRequest) {
        this.property = property;
        this.operator = operator;
    }

    public FilterRequest(String property, Object value) {
        super();
        this.property = property;
        this.value = value;
    }

    public FilterRequest(String property, Operator operator) {
        this.property = property;
        this.operator = operator;
//        this.value = "unary_operator";
        this.value = null;
    }

    public FilterRequest(String property, Object value, boolean extract) {
        super();
        this.property = property;
        this.value = value;
        this.extract = extract;
    }

    public FilterRequest(String property, Object value, boolean extract, boolean isNull) {
        super();
        this.property = property;
        this.value = value;
        this.extract = extract;
        this.isNull = isNull;
    }

    public FilterRequest() {
    }

    public FilterRequest(List<FilterRequest> filterRequests) {
        this.filterRequests = filterRequests;
    }
}
