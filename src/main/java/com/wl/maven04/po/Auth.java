package com.wl.maven04.po;

import java.util.List;

public class Auth {
    private Integer dbid;
    private String authName;
    private String authCode;
    private String authURL;
    private String type;
    private Integer parentId;
    private Integer orders;
    private String valid;
    private Integer layer;
    private Integer tag;
    private List<Auth> children;

    public Integer getTag() {
        return tag;
    }

    public void setTag(Integer tag) {
        this.tag = tag;
    }

    public Integer getDbid() {
        return dbid;
    }

    public void setDbid(Integer dbid) {
        this.dbid = dbid;
    }

    public String getAuthName() {
        return authName;
    }

    public void setAuthName(String authName) {
        this.authName = authName;
    }

    public String getAuthCode() {
        return authCode;
    }

    public void setAuthCode(String authCode) {
        this.authCode = authCode;
    }

    public String getAuthURL() {
        return authURL;
    }

    public void setAuthURL(String authURL) {
        this.authURL = authURL;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public Integer getParentId() {
        return parentId;
    }

    public void setParentId(Integer parentId) {
        this.parentId = parentId;
    }

    public Integer getOrders() {
        return orders;
    }

    public void setOrders(Integer orders) {
        this.orders = orders;
    }

    public String getValid() {
        return valid;
    }

    public void setValid(String valid) {
        this.valid = valid;
    }

    public Integer getLayer() {
        return layer;
    }

    public void setLayer(Integer layer) {
        this.layer = layer;
    }

    public List<Auth> getChildren() {
        return children;
    }

    public void setChildren(List<Auth> children) {
        this.children = children;
    }

    @Override
    public String toString() {
        return "Auth{" +
                "dbid=" + dbid +
                ", authName='" + authName + '\'' +
                ", authCode='" + authCode + '\'' +
                ", authURL='" + authURL + '\'' +
                ", type='" + type + '\'' +
                ", parentId=" + parentId +
                ", orders=" + orders +
                ", valid='" + valid + '\'' +
                ", layer=" + layer +
                ", tag=" + tag +
                ", children=" + children +
                '}';
    }
}