package com.wl.maven04.controller;

import com.alibaba.fastjson.JSON;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class HelloController {
    @RequestMapping("/index/{data}")
    public String hello(@PathVariable String data, Model model) {
        model.addAttribute("data",data);
        return "index";
    }
}
