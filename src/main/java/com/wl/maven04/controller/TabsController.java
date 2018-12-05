package com.wl.maven04.controller;

import com.alibaba.fastjson.JSON;
import com.wl.maven04.po.Auth;
import com.wl.maven04.service.impl.AuthServiceImpl;
import com.wl.maven04.util.MsgMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.Map;

@Controller
public class TabsController {
    @Autowired
    private AuthServiceImpl authService;

    @RequestMapping("/tabs")
    public String hello(Model model) {
       model.addAttribute("AutoList",JSON.toJSONString(authService.queryAuthByParentId(-1)));
        return "tabs";

    }
    @RequestMapping(value = "/getAuthJSON",produces = "application/json;charset=utf-8")
    @ResponseBody
    public String getAuthJSON(Model model) {
        /*System.out.println("11111"+authService.queryAuthByParentId(-1));*/
        /*System.out.println("22222"+JSON.toJSONString(authService.queryAuthByParentId(-1)));*/
        return JSON.toJSONString(authService.queryAuthByParentId(-1));
    }
    @RequestMapping(value = "/getAuthJSON1/{roleId}",produces = "application/json;charset=utf-8")
    @ResponseBody
    public String getAuthJSON1(@PathVariable Integer roleId,Model model) {
        /*System.out.println("11111"+authService.queryAuthByParentId1(-1));*/
   //     System.out.println("22222"+JSON.toJSONString(authService.queryAuthByParentId1(-1)));
        return JSON.toJSONString(authService.queryAuthByParentId1(roleId));
    }

    @RequestMapping(value = "/valid",produces = "application/json;charset=utf-8")
    @ResponseBody
    public String valid(String valid,Integer dbid,Model model) {
        Map map = authService.valid(valid, dbid);
        System.out.println("valid = " + valid);
        System.out.println("data = " + map.get("data"));
        if (valid!=null){
            return JSON.toJSONString(map);
        }else {
            return JSON.toJSONString(map);
        }
    }
    @RequestMapping(value = "/remove",produces = "application/json;charset=utf-8")
    @ResponseBody
    public String remove(Integer parentId,Integer dbid,Model model) {
        System.out.println("parentId = " + parentId);
        System.out.println("dbid = " + dbid);
        authService.removeAuth(parentId,dbid);
        return JSON.toJSONString(MsgMap.success());
        /*return "{\"msg\":\"Success!\"}";*/
    }
    @RequestMapping(value = "/submit",produces = "application/json;charset=utf-8")
    @ResponseBody
    public String submit(Auth auth, Model model) {
        System.out.println("auth = " + auth);
        if (auth.getTag()==null){
            return JSON.toJSONString(MsgMap.error("info","tag==null"));
        }
        if (auth.getTag()==1){
            /*添加*/
            Integer integer = authService.addAuth(auth);
           // System.out.println("integer = " + integer);
            return JSON.toJSONString(MsgMap.success("tag",1));
        }
        if (auth.getTag()==2){
            /*更改*/
            Integer integer = authService.updateAuth(auth);
            return JSON.toJSONString(MsgMap.success("tag",2));
        }
        return JSON.toJSONString(MsgMap.error());
    }

}
