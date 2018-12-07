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
        $(function () {
            //防止当前页面在iframe中打开
            if (top !== self) {
                top.location.replace(self.location);
            }
        });
        var PATH = "${path}";
        $(function () {
            var tabs = $("#tabs");
            $("#tree1").tree({
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
    </script>
    
</head>

<body class="easyui-layout">
<div data-options="region:'north',border:false" style="height:40px;background:#B3DFDA;">
    <p style="position: absolute;right: 200px ">用户:${sessionScope.get("user").userName}  你好!  <a href="loginOut">退出</a></p>
</div>
<div data-options="region:'west',split:true,title:'功能模块'" style="width:150px;">
    <div class="easyui-accordion" data-options="fit:true">
      <c:forEach items="${sessionScope.authJson}" var="auth">
          <div title="${auth.text}"style="overflow:auto;">
              <ul id="tree-${auth.id}"></ul>
          </div>
      </c:forEach>
    </div>
    </div>
<div data-options="region:'east',split:true,collapsed:true,title:'East'" style="width:100px;padding:10px;">east region</div>
<div data-options="region:'center'">
        <div id="tabs" class="easyui-tabs"></div>
</div>
</body>
</html>
