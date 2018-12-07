package com.wl.maven04.service.impl;

import com.alibaba.fastjson.JSON;
import com.wl.maven04.dao.RolesMapper;
import com.wl.maven04.dao.UsersMapper;
import com.wl.maven04.po.Role;
import com.wl.maven04.po.RoleAuth;
import com.wl.maven04.po.User;
import com.wl.maven04.service.UsersService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class UsersServiceImpl implements UsersService {

    @Autowired
    private UsersMapper usersMapper;

    public List<User> queryUsers() {
        List<User> users = usersMapper.queryUsers();
        return users;
    }

    public User queryUser(User user) {
        User user1 = usersMapper.queryUser(user);
        return user1;
    }

    public List<RoleAuth> queryUserRole(Integer userId) {
        List<RoleAuth> roleAuths = usersMapper.queryUserRole(userId);
        return roleAuths;
    }

    public Integer updateUser(User user) {
        Integer data = usersMapper.updateUser(user);
        return data;
    }
    public Integer adUserRole(String arr,Integer userId) {
        if (arr.trim()==""){
            Integer integer = usersMapper.deleteUserRoleByUserId(userId);
                return integer;
        }
        String[] split = arr.split(",");
        List<Integer> list = new ArrayList();
        for (String num: split) {
            list.add(Integer.parseInt(num));
        }
        System.out.println("list = " + list);
        List<RoleAuth> roleAuths = usersMapper.queryUserRole(userId);
        System.out.println("roleAuths = " + roleAuths);
        for (RoleAuth roleAuth:roleAuths) {
            if (list.contains(roleAuth.getRoleId())){
                System.out.println("已拥有的权限" + roleAuth.getRoleId());
                list.remove(roleAuth.getRoleId());
            }else {
                System.out.println("取消选择而删除的删除的权限 = " + roleAuth.getDbid());
                usersMapper.deleteUserRole(roleAuth.getDbid());
            }
        }
        if (list.size()>0){
            System.out.println("应添加的权限 = " + list);
            List<RoleAuth> list1 = new ArrayList();
            for (Integer num:list) {
                System.out.println("role = " + num);
                System.out.println("userId = " + userId);
                list1.add(new RoleAuth(userId,num));
            }
            Integer integer = usersMapper.addUserRole(list1);
            if (integer>0){
                System.out.println("添加权限成功");
            }
        }
        return 1;
    }



}
