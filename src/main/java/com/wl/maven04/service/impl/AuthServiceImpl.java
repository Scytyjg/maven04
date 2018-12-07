package com.wl.maven04.service.impl;

import com.alibaba.fastjson.JSON;
import com.wl.maven04.dao.AuthMapper;
import com.wl.maven04.dao.RolesMapper;
import com.wl.maven04.po.Auth;
import com.wl.maven04.po.RoleAuth;
import com.wl.maven04.service.AuthService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class AuthServiceImpl implements AuthService {

    @Autowired
    private AuthMapper authMapper;
    @Autowired
    private AuthServiceImpl authService;
    @Autowired
    private RolesMapper rolesMapper;

    public List<Auth> queryAuthByParentId(Integer parentId) {
        List<Auth> authList = authMapper.queryAuthByParentId(parentId);
        return authList;
    }
    public List<RoleAuth> queryAuthByParentId1(Integer roleId) {
        //所有有效的权限
        List<RoleAuth> authList = authMapper.queryAuthByParentId1(-1);
        List<Integer> roleAuthList = rolesMapper.queryRoleAuth(roleId);
        System.out.println("roleAuthList = " + roleAuthList);
        parseAuth(authList,roleAuthList);

        //查询角色对应的权限
        return authList;
    }
    public Map valid(String valid,Integer dbid) {
        Map map = new HashMap();
       /* System.out.println("valid = " + valid);*/
        map.put("valid",valid);
        map.put("dbid",dbid);
      /*  System.out.println("Svalid = " + valid);
        System.out.println("Sdbid = " + dbid);*/
        Integer data = authMapper.validAuthByDbid(map);
        map.put("data",data);
        return map;
    }
    public Integer addAuth(Auth auth) {
        Integer data = authMapper.addAuth(auth);
        return data;
    }
    public Integer updateAuth(Auth auth) {
        Integer data = authMapper.updateAuth(auth);
        System.out.println("auth = " + auth.getTag());
        System.out.println("auth = " + auth.getDbid());
        return data;
    }
    public void removeAuth(Integer parentId,Integer dbid) {
        Auth auth = null;
        List<Auth> authList = authService.queryAuthByParentId(parentId);
        System.out.println(JSON.toJSONString(authList));
        for (Auth a: authList) {
            System.out.println(a.getDbid().equals(dbid));
            if (a.getDbid().equals(dbid)){
                /*if (a.getDbid()==dbid){*/
                /*-128到127为false
                * 所以用eqs比较好一些
                * */
                auth = a;
            }
        }
        util(auth);
    }

    @Override
    public List<Auth> getAuthJson(Integer userId) {
        List<Auth> authJson = authMapper.getAuthJson(userId);
        System.out.println( JSON.toJSONString(authJson));
        List<Auth> children = null;
        Auth son = null;
        Auth father = null;
        for (int i = authJson.size()-1; i >= 0; i--) {
            children =  new ArrayList<>();
             father = authJson.get(i);
            for (int j = 0; j <authJson.size() ; j++) {
                 son = authJson.get(j);
                if (son.getParentId().equals(father.getDbid())){
                    authJson.remove(j);
                    j--;
                    children.add(son);
                }
            }
            father.setChildren(children);
        }
        return authJson;
    }

    private void util(Auth auth){
        Integer integer = authMapper.removeAuth(auth.getDbid());
        if (auth.getChildren()!=null){
            for (Auth auth1: auth.getChildren()) {
                util(auth1);
            }
        }
    }
    private void parseAuth( List<RoleAuth> roleAuths, List<Integer> roleAuths1){
        for (RoleAuth roleAuth: roleAuths) {
            if (roleAuths1.contains(roleAuth.getId())){
                roleAuth.setChecked(true);
            }
            System.out.println("roleAuth.getChildren() = " + roleAuth.getChildren());
            if (roleAuth.getChildren()!=null){
                parseAuth(roleAuth.getChildren(),roleAuths1);
            }


        }
    }

}
