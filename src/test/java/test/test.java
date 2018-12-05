package test;

import com.alibaba.fastjson.JSON;
import org.junit.Test;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.jar.JarEntry;

public class test  {
    @Test
    public void abc(){
        List list = new ArrayList();
        list.add("a");
        list.add("b");
        list.add("c");
        list.add("e");
        list.add("e");
        list.add("f");
        list.remove("e");
        System.out.println("list = " + JSON.toJSONString(list));
    }
}
