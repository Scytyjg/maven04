package com.wl.maven04.po;

import java.util.List;

public class RoleAuth {
    private Integer id;
    private Integer dbid;
    private Integer roleId;
    private String text;
    private boolean checked;
    private List<RoleAuth> children;

    public RoleAuth() { }

    public RoleAuth(Integer id ,Integer roleId) {
        this.id = id;this.roleId = roleId;
    }

    @Override
    public String toString() {
        return "RoleAuth{" +
                "id=" + id +
                ", dbid=" + dbid +
                ", roleId=" + roleId +
                ", text='" + text + '\'' +
                ", checked=" + checked +
                ", children=" + children +
                '}';
    }

    public boolean isChecked() {
        return checked;
    }

    public void setChecked(boolean checked) {
        this.checked = checked;
    }

    public Integer getDbid() {
        return dbid;
    }

    public void setDbid(Integer dbid) {
        this.dbid = dbid;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getRoleId() {
        return roleId;
    }

    public void setRoleId(Integer roleId) {
        this.roleId = roleId;
    }

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }

    public List<RoleAuth> getChildren() {
        return children;
    }

    public void setChildren(List<RoleAuth> children) {
        this.children = children;
    }
}
