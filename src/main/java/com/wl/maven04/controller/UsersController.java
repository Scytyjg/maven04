package com.wl.maven04.controller;

import com.alibaba.fastjson.JSON;
import com.wl.maven04.po.RoleAuth;
import com.wl.maven04.po.User;
import com.wl.maven04.service.impl.UsersServiceImpl;
import com.wl.maven04.util.MsgMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
public class UsersController {
    @Autowired
    private UsersServiceImpl usersService;

    @RequestMapping("/users")
    public String roles(Model model) {
        return "users";
    }

    @RequestMapping(value = "/getUserJSON", produces = "application/json;charset=utf-8")
    @ResponseBody
    public String getUserJSON(Model model) {
        List<User> userList = usersService.queryUsers();
  /*      System.out.println("roleList = " + roleList);
        System.out.println(JSON.toJSONString(roleList));*/
        return JSON.toJSONString(userList);
    }
    @RequestMapping(value = "/userSubmit", produces = "application/json;charset=utf-8")
    @ResponseBody
    public String userSubmit(User user, Model model) {
        System.out.println("user = " + user);
        /*更改*/
        Integer integer = usersService.updateUser(user);
        System.out.println("integer = " + integer);
        return JSON.toJSONString(MsgMap.success("tag", 2));
    }
    @RequestMapping(value = "/getUserRoleJSON/{userId}" , produces = "application/json;charset=utf-8")
    @ResponseBody
    public String getRoleAuthJSON(@PathVariable Integer userId, Model model) {
        List<RoleAuth> roleAuths = usersService.queryUserRole(userId);
          System.out.println("roleAuths = " + JSON.toJSONString(roleAuths));
        return JSON.toJSONString(roleAuths);
    }
    @RequestMapping(value = "/userRoleSubmit", produces = "application/json;charset=utf-8")
    @ResponseBody
    public String userRoleSubmit(String arr,Integer userId, Model model) {
      /*  System.out.println("arr = " + arr);
        System.out.println("userId = " + userId);*/
        Integer integer = usersService.adUserRole(arr, userId);
        return JSON.toJSONString(MsgMap.success("tag", 2));
    }


}
