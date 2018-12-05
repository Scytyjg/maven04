package com.wl.maven04.dao;

import com.wl.maven04.po.Auth;
import com.wl.maven04.po.Role;
import com.wl.maven04.po.RoleAuth;

import java.util.List;
import java.util.Map;

public interface RolesMapper {
    List<Role> queryRoles();
    List<Role> queryRolesByValid();
    Integer updateRole(Role role);
    List<Integer> queryRoleAuth(Integer roleId);
    Integer deleteRoleAuth(Integer dbid);
    Integer deleteRoleAuthByRoleId(Integer roleId);
    Integer addRoleAuth(List<RoleAuth> list);
}
