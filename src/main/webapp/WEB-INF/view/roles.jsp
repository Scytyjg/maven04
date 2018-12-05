<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <title>角色管理</title>
    <link rel="stylesheet" type="text/css" href="${path}/static/css/easyui.css">
    <link rel="stylesheet" type="text/css" href="${path}/static/css/icons/icon.css">
    <script type="text/javascript" src="${path}/static/js/jquery.min.js"></script>
    <script type="text/javascript" src="${path}/static/js/jquery.easyui.min.js"></script>
    <script>
        /*显示角色管理窗口*/
        $(function () {
            $('#dg').datagrid({
                url:'${path}/getRoleJSON',
                idField:'dbid',
                rownumbers:true,
                singleSelect:true,
                pagination:true,
                columns: [[
                   /* {title: '编码', field: 'dbid'},*/
                    {title: '角色名称', field: 'roleName'},
                    {title: '角色编码', field: 'roleCode'},
                    {
                        title: '是否有效', field: 'valid',
                        formatter: function (value, row, index) {
                            if (value === "1") {
                                return "有效";
                            } else {
                                return "<span style='color:red'>无效</span>";
                            }
                        }
                    },
                    {title: '排序', field: 'orders'},
                    {field: 'dbid', title: '授权',
                        formatter: function(value,row,index){
                            return "<button  onclick='accredit("+value+")'>授权</button>";
                        }}

                    ]],
                onDblClickCell: function(index,field,value){
                    var node = $(this).datagrid('getSelected');
                    /*console.log(node);*/
                    $("#ff").form("clear");
                    $("#window").window({
                        title: "角色编辑窗口",
                        iconCls: "icon-edit",
                        collapsible: false,
                        minimizable: false,
                        maximizable: false,
                        modal: true,
                        resizable: false
                    }).window("open");
    /*              $("#dbid").textbox("setValue",node.dbid);
                    $("#roleName").textbox("setValue",node.roleName);
                    $("#roleCode").textbox("setValue",node.roleCode);
                    $("#valid").textbox("setValue",node.valid);
                    $("#orders").textbox("setValue",node.orders);*/
                    $("#ff").form("load", {
                        dbid: node.dbid,
                        roleName: node.roleName,
                        roleCode: node.roleCode,
                        valid: node.valid,
                        orders: node.orders
                    });
                }
            });
        });
        /*显示树形权限，并有数据回显*/
        function accredit(dbid) {
            $("#window1").window({
                title: "角色授权窗口",
                iconCls: "icon-edit",
                collapsible: false,
                minimizable: false,
                maximizable: false,
                modal: true,
                resizable: false,
                onOpen:function () {
                    //初始化tree，显示系统中所有有效的权限
                    $("#roleTree").tree({
                        url:"${path}/getAuthJSON1/"+dbid,
                        animate:true,
                        /*cascadeCheck:false,*/ //不会级联选择
                        onlyLeafCheck: false,//仅叶子节点可以被选中
                        checkbox:true,
                 /*       onLoadSuccess:function (node, data) {
                            $.ajax({
                                url:"path}/getRoleAuthJSON/"+dbid,
                                /!*  type:"post",*!/
                                success:function (res) {
                                    for (var i = 0;i<res.length;i++){
                                        /!*    list.push(res[i].id);*!/
                                        var n = $("#roleTree").tree('find',res[i].id);
                                        if (n!=null){
                                            $("#roleTree").tree('check',n.target);
                                        }
                                    }
                                    /!* recursive(data,list);*!/
                                }
                            });
                        }*/
                    });
                },
            }).window("open");

        }
     /*   function recursive(data,list) {
     /!*      var auth = data[0];
           console.log(auth.children);*!/
            for (var i = 0;i<data.length;i++) {
                for (var j = 0; j < list.length; j++) {
                    if (data[i].id===list[j]){
                        alert("success");
                        var a = $("#roleTree").tree("find",data[i].id);
                        if (a!=null){
                            $("#roleTree").tree("check",a.target);
                        }

                    }
                }
              /!*  console.log(data[i].id);*!/
                if (data[i].children != null) {
                    recursive(data[i].children, list);
                }
            }
        }*/
         /*修改权限提交*/
        function submitForm() {
            $.messager.progress();	// 显示进度条
            $('#ff').form('submit', {
                url: "${path}/roleSubmit",
                type:"post",
                onSubmit: function () {
                    var roleName = $("#roleName").textbox("getValue");
                    if (roleName == "") {
                        $.messager.progress('close');
                        $.messager.alert("提示", "角色名称为必填项！");
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
        /*增删权限提交*/
        function submitRoles() {
            //获取打钩的权限
            var selectRole = $("#roleTree").tree("getChecked");
            //获取对应角色
            var node = $("#dg").datagrid('getSelected');
            var arr = [];
            for (var a = 0;a<selectRole.length;a++){
                arr.push(selectRole[a].id);
            }
             arr = arr.toString();
            $.ajax({
                url:"${path}/RoleAuthSubmit",
                type:"post",
                data:{
                    arr:arr,
                    dbid:node.dbid
                },
                success:function (res) {
                    clearForm1();
                    relode();
                }
            });
        }
        /*关闭修改权限表单*/
        function clearForm() {
            $('#window').window('close');
        }
        /*关闭授权表单*/
        function clearForm1() {
            $('#window1').window('close');
        }
        /*刷新*/
        function relode() {
            $("#dg").datagrid("reload");
        }
    </script>
</head>
<body>
<table id="dg"></table>
<div id="window1" class="easyui-window" title="添加" data-options="closed:true"
     style="width:550px;height:450px;padding:10px">
        <input type="hidden" id="roleId">
        <ul id="roleTree"></ul>
        <div id="roleSubmit" style="text-align:center;padding:5px 0">
            <a href="javascript:void(0)" class="easyui-linkbutton" onclick="submitRoles()" style="width:80px">保存</a>
            <a href="javascript:void(0)" class="easyui-linkbutton" onclick="clearForm1()" style="width:80px">关闭</a>
        </div>
</div>

<div id="window" class="easyui-window" data-options="closed:true"
     style="width:550px;height:450px;padding:10px">
    <form id="ff" class="easyui-form" style="width:450px;margin-top:70px;padding-left: 140px" method="post"
          data-options="novalidate:true">
        <div style="margin-bottom:20px">
            <input class="easyui-textbox" id="dbid" name="dbid" style="width:300px"
                   data-options=" label:'编码：',required:true,readonly:true">
        </div>
        <div style="margin-bottom:20px">
            <input id="roleName" name="roleName" class="easyui-textbox" style="width:300px"
                   data-options="label:'角色名称：',required:true">
        </div>
        <div style="margin-bottom:20px">
            <input id="roleCode" name="roleCode" class="easyui-textbox" style="width:300px"
                   data-options="label:'角色编码：',required:true">
        </div>
        <select id="valid" name="valid" class="easyui-combobox"
                data-options="label:'是否有效：',editable:false,panelHeight:'70px'" style="width:300px;height:30px">
            <option value="1">有效</option>
            <option value="0">无效</option>
        </select>
        </br>
        <div style="margin-bottom:20px;margin-top: 20px">
            <input id="orders" name="orders" class="easyui-textbox" style="width:300px"
                   data-options="label:'排序：',required:true">
        </div>
    </form>
    <div style="text-align:center;padding:5px 0">
        <a href="javascript:void(0)" class="easyui-linkbutton" onclick="submitForm()" style="width:80px">保存</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" onclick="clearForm()" style="width:80px">关闭</a>
    </div>
</div>

</body>
</html>
