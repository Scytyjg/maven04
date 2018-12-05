package com.wl.maven04.controller;

import com.alibaba.fastjson.JSON;
import com.wl.maven04.po.Role;
import com.wl.maven04.po.RoleAuth;
import com.wl.maven04.service.impl.RolesServiceImpl;
import com.wl.maven04.util.MsgMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
public class RolesController {
    @Autowired
    private RolesServiceImpl rolesService;

    @RequestMapping("/roles")
    public String roles(Model model) {
        return "roles";
    }
    @RequestMapping(value = "/getRoleAuthJSON/{roleId}" , produces = "application/json;charset=utf-8")
    @ResponseBody
    public String getRoleAuthJSON(@PathVariable Integer roleId, Model model) {
        List<Integer> rAList = rolesService.queryRoleAuth(roleId);
      //  System.out.println("rAList = " + JSON.toJSONString(rAList));
        return JSON.toJSONString(rAList);
    }
    @RequestMapping(value = "/getRoleJSON", produces = "application/json;charset=utf-8")
    @ResponseBody
    public String getRoleJSON(Model model) {
        List<Role> roleList = rolesService.queryRoles();
        //System.out.println(123+"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
  /*      System.out.println("roleList = " + roleList);
        System.out.println(JSON.toJSONString(roleList));*/
        return JSON.toJSONString(roleList);
    }
    @RequestMapping(value = "/getRolesByValid", produces = "application/json;charset=utf-8")
    @ResponseBody
    public String getRolesByValid(Model model) {
        List<Role> roleList = rolesService.queryRolesByValid();
        //System.out.println(123+"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
  /*      System.out.println("roleList = " + roleList);
        System.out.println(JSON.toJSONString(roleList));*/
        return JSON.toJSONString(roleList);
    }

    @RequestMapping(value = "/roleSubmit", produces = "application/json;charset=utf-8")
    @ResponseBody
    public String submit(Role role, Model model) {
        System.out.println("role = " + role);
        /*更改*/
        Integer integer = rolesService.updateRole(role);
        System.out.println("integer = " + integer);
        return JSON.toJSONString(MsgMap.success("tag", 2));
    }
    @RequestMapping(value = "/RoleAuthSubmit", produces = "application/json;charset=utf-8")
    @ResponseBody
    public String RoleAuthSubmit(String arr,Integer dbid, Model model) {
        Integer integer = rolesService.adRoleAuth(arr,dbid);
        return JSON.toJSONString(MsgMap.success("tag", 2));
    }
}
