package com.wl.maven04.service;

import com.wl.maven04.po.RoleAuth;
import com.wl.maven04.po.User;

import java.util.List;

public interface UsersService {
    List<User> queryUsers();
    List<RoleAuth> queryUserRole(Integer userId);
    Integer updateUser(User user);
    Integer adUserRole(String arr,Integer userId);
}
