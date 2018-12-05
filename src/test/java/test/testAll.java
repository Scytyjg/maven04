package test;

import com.alibaba.fastjson.JSON;
import com.wl.maven04.po.Auth;
import com.wl.maven04.service.impl.AuthServiceImpl;
import org.junit.Test;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import java.util.List;

public class testAll {
    @Test
    public void test(){
        ClassPathXmlApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");
        AuthServiceImpl authMapper = context.getBean(AuthServiceImpl.class);
        List<Auth> list = authMapper.queryAuthByParentId(-1);
        System.out.println(JSON.toJSONString(list));
        context.close();
    }    
    @Test
    public void test1(){
            Integer a = 128;
            Integer b = 128;
        System.out.println(a==(b));/*-128到127为false*/
    }

}
