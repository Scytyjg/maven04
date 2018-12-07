<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" type="text/css" href="${path}/static/css/easyui.css">
    <link rel="stylesheet" type="text/css" href="${path}/static/css/icons/icon.css">
    <script type="text/javascript" src="${path}/static/js/jquery.min.js"></script>
    <script type="text/javascript" src="${path}/static/js/jquery.easyui.min.js"></script>
    <script>
        function submitForm() {
            $("#ff").form('submit',{
                url:"${path}/doLogin",
                success: function (res) {
                    var a = JSON.parse(res);
                    if (a.msg === "Success!"){
                        alert(a.msg);
                        window.location.replace("${path}/hello")
                    }else {
                        alert(a.msg);
                    }
                }
            })
        }
    </script>
</head>
<body>
<div style="margin: 0 auto;background-color: #6b9cde;width: 400px">
    <div class="easyui-panel" title="用户登录" style="width:100%;max-width:400px;padding:30px 60px;">
        <form  id="ff" class="easyui-form" method="post" data-options="novalidate:true">
            <div style="margin-bottom:20px">
                <input class="easyui-textbox" name="userName" prompt="userName" style="width:100%" data-options="label:'用户名:',required:true">
            </div>
            <div style="margin-bottom:20px">
                <input class="easyui-passwordbox" name="passWord" prompt="passWord" iconWidth="28" style="width:100%" data-options="label:'密<font color=#FFFFFF>密</font>码:',required:true">
            </div>

        </form>
        <div style="text-align:center;padding:5px 0">
            <a href="javascript:void(0)" class="easyui-linkbutton" onclick="submitForm()" style="width:80px">Submit</a>
        </div>
    </div>
</div>
</body>
</html>
