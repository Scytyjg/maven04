package com.wl.maven04.util;

import java.util.HashMap;

public class MsgMap extends HashMap {
    public MsgMap(){
        put("msg","Success!");
    };
    public static MsgMap success(){
        return new MsgMap();
    }
    public static MsgMap success(String kay,Object value){
        MsgMap msgMap = new MsgMap();
        msgMap.put(kay,value);
        return msgMap;
    }

    public static MsgMap error(String kay,Object value){
        MsgMap error = error();
        error.put(kay,value);
        return error;
    }
    public static MsgMap error(){
        return success("msg","Error!");
    }
}
