package com.wl.maven04.dao;

import com.wl.maven04.po.Role;
import com.wl.maven04.po.RoleAuth;
import com.wl.maven04.po.User;

import java.util.List;

public interface UsersMapper {
    List<User> queryUsers();
    User queryUser(User user);
    Integer updateUser(User user);
    List<RoleAuth> queryUserRole(Integer userId);
    Integer deleteUserRole(Integer dbid);
    Integer deleteUserRoleByUserId(Integer userId);
    Integer addUserRole(List<RoleAuth> list);
}
