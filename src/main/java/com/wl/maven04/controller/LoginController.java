package com.wl.maven04.controller;

import com.alibaba.fastjson.JSON;
import com.wl.maven04.po.Auth;
import com.wl.maven04.po.User;
import com.wl.maven04.service.AuthService;
import com.wl.maven04.service.UsersService;
import com.wl.maven04.util.MsgMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
public class LoginController {
    @Autowired
    private UsersService usersService;
    @Autowired
    private AuthService authService;

    @RequestMapping("/login")
    public String getRoleAuthJSON( Model model) {
       return "login";
    }
    @RequestMapping(value = "/doLogin" , produces = "application/json;charset=utf-8")
    @ResponseBody
    public String getRoleAuthJSON(User user, HttpSession session, Model model) {
        System.out.println("user = " + user);
        User user1 = usersService.queryUser(user);
        List<Auth> authJson = authService.getAuthJson(user1.getDbid());
        if (user1!=null){
            session.setAttribute("user",user1);
            session.setAttribute("authJson",authJson);
            return JSON.toJSONString(MsgMap.success());
        }
        return JSON.toJSONString(MsgMap.error());
    }
    @RequestMapping("/loginOut")
    public String loginOut(HttpSession session, Model model) {
        session.invalidate();
        return "redirect:/login";
    }

}
