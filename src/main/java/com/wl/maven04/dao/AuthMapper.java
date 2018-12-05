package com.wl.maven04.dao;

import com.wl.maven04.po.Auth;
import com.wl.maven04.po.RoleAuth;

import java.util.List;
import java.util.Map;

public interface AuthMapper {
    List<Auth> queryAuthByParentId(Integer parentId);
    List<RoleAuth> queryAuthByParentId1(Integer parentId);
    Integer validAuthByDbid(Map map);
    Integer addAuth(Auth auth);
    Integer updateAuth(Auth auth);
    Integer removeAuth(Integer dbid);
}
