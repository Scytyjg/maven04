package com.wl.maven04.service.impl;

import com.alibaba.fastjson.JSON;
import com.wl.maven04.dao.AuthMapper;
import com.wl.maven04.dao.RolesMapper;
import com.wl.maven04.po.Auth;
import com.wl.maven04.po.Role;
import com.wl.maven04.po.RoleAuth;
import com.wl.maven04.service.RolesService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class RolesServiceImpl implements RolesService {

    @Autowired
    private RolesMapper rolesMapper;

    public List<Role> queryRoles() {
        List<Role> roles = rolesMapper.queryRoles();
        return roles;
    }
    public List<Role> queryRolesByValid() {
        List<Role> roles = rolesMapper.queryRolesByValid();
        return roles;
    }
    public List<Integer> queryRoleAuth(Integer roleId) {
        List<Integer> roleAuths = rolesMapper.queryRoleAuth(roleId);
        return roleAuths;
    }

    public Integer updateRole(Role role) {
        Integer data = rolesMapper.updateRole(role);
        return data;
    }

    public Integer adRoleAuth(String data, Integer dbid){
        System.out.println("dbid = " + dbid);
        if (data.trim()==""){
            Integer integer = rolesMapper.deleteRoleAuthByRoleId(dbid);
            return integer;
        }
       // System.out.println("dbid = " + dbid);
        String[] arr = data.split(",");
        List<Integer> list = new ArrayList();
        for (String num: arr) {
            list.add(Integer.parseInt(num));
        }
     //   System.out.println("list = " + JSON.toJSONString(list));
        List<Integer> authIds = queryRoleAuth(dbid);
        for (Integer authId:authIds) {
           if (list.contains(authId)){
               System.out.println(authId+"重复");
               list.remove(authId);
               System.out.println("删除重复元素后的list " + JSON.toJSONString(list));
           }else {
               System.out.println("取消的权限roleAuth = " + authId);
               Integer integer = rolesMapper.deleteRoleAuth(authId);
               if (integer==1){
                   System.out.println("删除权限success");
               }
           }
        }
        System.out.println("即将添加的权限list = " + JSON.toJSONString(list));
        List<RoleAuth> list1 = new ArrayList();
        for (Integer num1:list) {
            list1.add(new RoleAuth(num1,dbid));
        }
        System.out.println("list1 = " + JSON.toJSONString(list1));
        if (list1.size()>0){
            Integer integer = rolesMapper.addRoleAuth(list1);
            if (integer>0){
                System.out.println("添加权限成功");
            }
        }

        return 1;
    }
}
