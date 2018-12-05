<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <title>用户管理</title>
    <link rel="stylesheet" type="text/css" href="${path}/static/css/easyui.css">
    <link rel="stylesheet" type="text/css" href="${path}/static/css/icons/icon.css">
    <script type="text/javascript" src="${path}/static/js/jquery.min.js"></script>
    <script type="text/javascript" src="${path}/static/js/jquery.easyui.min.js"></script>
    <script>
        $(function () {

            /*显示用户管理窗口*/
            $('#dg').datagrid({
                url:'${path}/getUserJSON',
                idField:'dbid',
                rownumbers:true,
                singleSelect:true,
                pagination:true,
                columns: [[
                    {title: '用户名称', field: 'userName'},
                    {title: '真实姓名', field: 'realName'},
                    {
                        title: '用户状态', field: 'valid',
                        formatter: function (value, row, index) {
                            if (value === "1") {
                                return "正常";
                            } else {
                                return "<span style='color:red'>冻结</span>";
                            }
                        }
                    },
                    {field: 'dbid', title: '授予角色',
                        formatter: function(value,row,index){
                        //alert(value);
                            return "<button  onclick='Grant("+value+")'>授权</button>";
                        }}

                ]],
                onDblClickCell: function(index,field,value){
                    var node = $(this).datagrid('getSelected');
                    /*console.log(node);*/
                    $("#ff").form("clear");
                    $("#window").window({
                        title: "用户编辑窗口",
                        iconCls: "icon-edit",
                        collapsible: false,
                        minimizable: false,
                        maximizable: false,
                        modal: true,
                        resizable: false
                    }).window("open");
                    $("#ff").form("load", {
                        dbid: node.dbid,
                        userName: node.userName,
                        realName: node.realName,
                        valid: node.valid,
                    });
                }
            });
        });
        /*显示授予角色窗口且数据回显*/
        function Grant(dbid) {
           // alert(dbid);
            $("#window1").window({
                title: "授予角色窗口",
                iconCls: "icon-edit",
                collapsible: false,
                minimizable: false,
                maximizable: false,
                modal: true,
                resizable: false,
                onClose:function () {
                    $("#dg1").datagrid("unselectAll");
                 //   $("#dg1").datagrid("uncheckAll");//以上都可以
                }
            }).window("open");
          //
            $("#dg1").datagrid({
                url:'${path}/getRolesByValid',
                rownumbers: true,//多出一列行号
                idField:'dbid',
                //checkbox:true,//显示复选框
    /*          singleSelect: false,//true为只可单选
                fitColumns: "true",//真正的自动展开/收缩列的大小，以适应网格的宽度，防止水平滚动。
                fit: true,//当设置为true的时候面板大小将自适应父容器。下面的例子显示了一个面板，可以自动在父容器的最大范围内调整大小。
                autoRowHeight: false,
                //定义设置行的高度，根据该行的内容。设置为false可以提高负载性能。
                */
                columns: [[
                    {title: '',checkbox:true, field: 'dbid'},
                    {title: '角色名称', field: 'roleName'},
                    {title: '角色编码', field: 'roleCode'}
                ]],
                onLoadSuccess:function (node, data) {
                  /*  console.log(node);
                    console.log(data);//null*/
                    $.ajax({
                        url:"${path}/getUserRoleJSON/"+dbid,
                        success:function (res) {
                            //alert(res[0].roleId);
                            for (var i = 0;i<res.length;i++){
                                $("#dg1").datagrid("selectRecord",res[i].roleId);//selectRecord 根据ID选择行
                            }
                        }
                    });
                }
            })
        }
        /*修改用户信息提交*/
        function submitForm() {
            $.messager.progress();	// 显示进度条
            $('#ff').form('submit', {
                url: "${path}/userSubmit",
                type:"post",
                onSubmit: function () {
                    var roleName = $("#userName").textbox("getValue");
                    var passWord = $("#passWord").textbox("getValue");
                    var conPassWord = $("#conPassWord").textbox("getValue");
                    if (roleName === "") {
                        $.messager.progress('close');
                        $.messager.alert("提示", "用户名称为必填项！");
                        return false;// 返回false终止表单提交
                    }
                    if (passWord ===""&&conPassWord==="") {
                        return true;// 返回false终止表单提交
                    }
                    if (passWord ==="") {
                        $.messager.progress('close');
                        $.messager.alert("提示", "密码不可为空！");
                        return false;// 返回false终止表单提交
                    }
                    if (passWord !== conPassWord) {
                        $.messager.progress('close');
                        $.messager.alert("提示", "密码必须相同！");
                        return false;// 返回false终止表单提交
                    }
                    return true;
                },
                success: function (res) {
                    $.messager.progress('close');	// 如果提交成功则隐藏进度条
                    alert(res);
                    clearForm();
                    relode();
                }
            });
        }
        /*授予角色信息提交*/
        function submitUsers() {
           var node = $("#dg1").datagrid("getSelections");
           var userId = $("#dg").datagrid('getSelected').dbid;
           var arr = [];
           for (var i = 0;i<node.length;i++){
               arr.push(node[i].dbid);
           }
           console.log("用户id = "+userId);
           console.log(arr);
            arr = arr.toString();
            $.ajax({
                url:"${path}/userRoleSubmit",
                type:"post",
                data:{
                    arr:arr,
                    userId:userId
                },
                success:function (res) {
                    clearForm1();
                    relode();
                }
            });
        }
        /*关闭修改用户信息窗口*/
        function clearForm() {
            $('#window').window('close');
        }
        /*关闭授予角色窗口*/
        function clearForm1() {

            $('#window1').window('close');
        }
        /*刷新*/
        function relode() {
            $("#dg").datagrid("reload");
        }
        function relode1() {

            $("#dg1").datagrid("reload");
        }
    </script>
</head>
<body>
<table id="dg"></table>
<div id="window" class="easyui-window" data-options="closed:true"
     style="width:550px;height:450px;padding:10px">
    <form id="ff" class="easyui-form" style="width:450px;margin-top:70px;padding-left: 140px" method="post"
          data-options="novalidate:true">
        <div style="margin-bottom:20px">
            <input class="easyui-textbox" id="dbid" name="dbid" style="width:300px"
                   data-options=" label:'编码：',required:true,readonly:true">
        </div>
        <div style="margin-bottom:20px">
            <input id="userName" name="userName" class="easyui-textbox" style="width:300px"
                   data-options="label:'用户名称：',required:true">
        </div>
        <div style="margin-bottom:20px">
            <input id="realName" name="realName" class="easyui-textbox" style="width:300px"
                   data-options="label:'真实名称：',required:true">
        </div>
        <div style="margin-bottom:20px">
            <input id="passWord" name="passWord" class="easyui-passwordbox" style="width:300px"
                   data-options="label:'密码：',required:true,prompt:'默认为不修改'"  >
        </div>
        <div style="margin-bottom:20px">
            <input id="conPassWord" name="conPassWord" class="easyui-passwordbox" style="width:300px"
                   data-options="label:'确认密码：',required:true,prompt:'默认为不修改'"  >
        </div>
        <select id="valid" name="valid" class="easyui-combobox"
                data-options="label:'用户状态：',editable:false,panelHeight:'70px'" style="width:300px;height:30px">
            <option value="1">正常</option>
            <option value="0">冻结</option>
        </select>
        </br>
    </form>
    <div style="text-align:center;padding:5px 0">
        <a href="javascript:void(0)" class="easyui-linkbutton" onclick="submitForm()" style="width:80px">保存</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" onclick="clearForm()" style="width:80px">关闭</a>
    </div>
</div>
<div id="window1" class="easyui-window" title="添加" data-options="closed:true"
     style="width:440px;height:330px;padding:10px">
    <table id="dg1"></table>
    <div id="roleSubmit" style="text-align:center;padding:5px 0">
        <a href="javascript:void(0)" class="easyui-linkbutton" onclick="submitUsers()" style="width:80px">保存</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" onclick="clearForm1()" style="width:80px">关闭</a>
    </div>
</div>
</body>
</html>
