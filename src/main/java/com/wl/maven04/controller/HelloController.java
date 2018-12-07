package com.wl.maven04.controller;

import com.alibaba.fastjson.JSON;
import com.wl.maven04.po.Auth;
import com.wl.maven04.service.AuthService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
public class HelloController {
    @Autowired
    private AuthService authService;

    @RequestMapping("/index/{data}")
    public String hello(@PathVariable String data, Model model) {
        model.addAttribute("data",data);
        return "index";
    }
    @RequestMapping(value = "/getAuthJson/{userId}" , produces = "application/json;charset=utf-8")
    @ResponseBody
    public String getAuthJson(@PathVariable Integer userId){
        List<Auth> authJson = authService.getAuthJson(userId);
        return JSON.toJSONString(authJson);
    }
}
