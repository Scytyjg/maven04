package com.wl.maven04.service;

import com.wl.maven04.po.Auth;
import com.wl.maven04.po.RoleAuth;

import java.util.List;
import java.util.Map;

public interface AuthService {
    List<Auth> queryAuthByParentId(Integer parentId);

    List<RoleAuth> queryAuthByParentId1(Integer dbid);

    Map valid(String valid, Integer dbid);

    Integer addAuth(Auth auth);

    Integer updateAuth(Auth auth);

    void removeAuth(Integer parentId, Integer dbid);



}
