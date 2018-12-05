<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" type="text/css" href="${path}/static/css/easyui.css">
    <link rel="stylesheet" type="text/css" href="${path}/static/css/icons/icon.css">
    <script type="text/javascript" src="${path}/static/js/jquery.min.js"></script>
    <script type="text/javascript" src="${path}/static/js/jquery.easyui.min.js"></script>
    <script>

        var PATH = "${path}";
        var data = [{
            "id":1,
            "text":"数码",
            "children":[{
                "id":11,
                "text":"手机",
                "state":"closed",
                "children":[{
                    "id":111,
                    "text":"苹果"
                },{
                    "id":112,
                    "text":"三星"
                },{
                    "id":113,
                    "text":"小米"
                }]
            },{
                "id":12,
                "text":"电脑",
                "children":[{
                    "id":121,
                    "text":"联想"
                },{
                    "id":122,
                    "text":"惠普",
                    "attributes":{
                        "p1":"Custom Attribute1",
                        "p2":"Custom Attribute2"
                    }
                },{
                    "id":123,
                    "text":"外星人"
                },{
                    "id":124,
                    "text":"戴尔",
                    "checked":true
                }]
            },{
                "id":13,
                "text":"1"
            },{
                "id":14,
                "text":"2"
            },{
                "id":15,
                "text":"3"
            }]
        }];
        $(function () {
            var tabs = $("#tabs");
            $("#tree1").tree({
            url:PATH+"/json/tree_data1.json",
           /* data:data,*/
            onClick:function (node) {
              if(!node.children){
                 /*alert(node.url)*/
                  /*location = PATH+"/index/"+node.text;*/
                if (!tabs.tabs("exists",node.text)){
               //     alert(node.url);
                    tabs.tabs("add",{
                        /*标题*/
                        title:node.text,
                        /*内容*/
                        content:"<iframe width='100%' height='100%' src='${path}/"+node.url+"'/>",
                        /*可关闭*/
                        closable:true
                    });
                } else {
                    /*选中*/
                    tabs.tabs("select",node.text);
                }
              }
            }
            });
            $("#tree2").tree({
            url:PATH+"/json/tree_data2.json",
           /* data:data,*/
            onClick:function (node) {
              if(!node.children){
                 /*alert(node.url)*/
                  /*location = PATH+"/index/"+node.text;*/
                if (!tabs.tabs("exists",node.text)){
               //     alert(node.url);
                    tabs.tabs("add",{
                        /*标题*/
                        title:node.text,
                        /*内容*/
                        content:"<iframe width='100%' height='100%' src='${path}/"+node.url+"'/>",
                        /*可关闭*/
                        closable:true
                    });
                } else {
                    /*选中*/
                    tabs.tabs("select",node.text);
                }
              }
            }
            });
        });
/*        $(document).ready(function () {
    /!*        $("#tree1").tree({
                onClick:function (node) {
                    location = PATH+"/index/"+node.text;
                },
            });*!/
        });*/

    </script>
    
</head>

<body class="easyui-layout">

<div data-options="region:'north',border:false" style="height:60px;background:#B3DFDA;padding:10px">north region</div>
<div data-options="region:'west',split:true,title:'功能模块'" style="width:150px;">
    <div class="easyui-accordion" data-options="fit:true">
        <div title="考试管理"style="overflow:auto;">
            <ul id="tree1"></ul>
        </div>
     <%--   <div title="" style="padding:10px;">

        </div>--%>
        <div title="系统管理" style="padding:10px 0;">
            <ul id="tree2"></ul>
        </div>
    </div>
    </div>
<div data-options="region:'east',split:true,collapsed:true,title:'East'" style="width:100px;padding:10px;">east region</div>
<div data-options="region:'center'">
        <div id="tabs" class="easyui-tabs"></div>

</div>
</body>
</html>
