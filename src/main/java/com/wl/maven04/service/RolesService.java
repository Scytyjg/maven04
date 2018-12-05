package com.wl.maven04.service;

import com.wl.maven04.po.Role;
import com.wl.maven04.po.RoleAuth;

import java.util.List;

public interface RolesService {
    List<Role> queryRoles();
    List<Role> queryRolesByValid();
    List<Integer> queryRoleAuth(Integer roleId);
    Integer updateRole(Role role);
    Integer adRoleAuth(String data, Integer dbid);
}
