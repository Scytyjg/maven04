<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <title>TAB</title>
</head>
<link rel="stylesheet" type="text/css" href="${path}/static/css/easyui.css">
<link rel="stylesheet" type="text/css" href="${path}/static/css/icons/icon.css">
<script type="text/javascript" src="${path}/static/js/jquery.min.js"></script>
<script type="text/javascript" src="${path}/static/js/jquery.easyui.min.js"></script>
<script>
    $(function () {
        $('#treeGrid').treegrid({
            url: '${path}/getAuthJSON',
            idField: 'dbid',
            treeField: 'authName',
            rownumbers: true,
            columns: [[
                {title: '编码', field: 'dbid'},
                {title: '权限名称', field: 'authName'},
                {title: '权限编码', field: 'authCode'},
                {title: 'url', field: 'authURL'},
                {
                    title: '类型', field: 'type',
                    formatter: function (value, row, index) {
                        if (value === "1") {
                            return "模块";
                        } else {
                            return "资源";
                        }
                    }
                },
                {title: '排序', field: 'orders'},
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
                {title: '层级', field: 'layer'},
            ]],
            //右键菜单
            onContextMenu: function (e, row) {

                /*  console.log("e~~~"+e);
                  console.log("row~~~"+row);*/
                //如果是行内
                if (row) {
                    //阻止默认事件
                    e.preventDefault();
                    //选中所点行
                    $("#treeGrid").treegrid("select", row.dbid);
                    //显示右键菜单
                    $("#mm").menu("show", {
                        left: e.pageX,
                        top: e.pageY
                    });
                }
            }
        });

    });

    function valid(valid) {
        $('#treeGrid').treegrid('beginEdit', 5);
        var node = $('#treeGrid').treegrid('getSelected');
        var dbid = node.dbid;
        $.ajax({
            url: "${path}/valid",
            data: {
                valid: valid,
                dbid: dbid
            },
            success: function (res) {
                $('#treeGrid').treegrid("update", {
                    id: dbid,
                    row: {
                        valid: res.valid,
                    }
                });
            }
        });

    }

    /*刷新*/
    function relode() {
        $("#treeGrid").treegrid("reload");
    }

    /*关闭提交表单*/
    function clearForm() {
        $('#window').window('close');
    }

    /*提交提交表单*/
    function submitForm() {
        $.messager.progress();	// 显示进度条
        var node = $('#treeGrid').datagrid('getSelected');

        $('#ff').form('submit', {
            url: "${path}/submit",
            onSubmit: function () {
                var authName = $("#authName").textbox("getValue");
                var layer = $("#layer").textbox("getValue");
                alert($("#tag").val());
                /*      var dbid = $("#dbid").textbox("getValue");
                      var parentId = $("#parentId").textbox("getValue");
                         var authCode = $("#authCode").textbox("getValue");
                         var authURL = $("#authURL").textbox("getValue");
                         var type = $("#type").combobox("getValue");
                         var orders = $("#orders").textbox("getValue");
                         var valid = $("#valid").combobox("getValue");*/

                if (authName == "") {
                    $.messager.progress('close');
                    $.messager.alert("提示", "权限名称为必填项！");
                    return false;// 返回false终止表单提交
                }
                if (layer != node.layer) {
                    alert("添加操作")
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
/*删除某选项及其子选项*/
    function removeAuth() {
        var node = $('#treeGrid').treegrid('getSelected');
        $.ajax({
            url: "${path}/remove",
            data: {
                parentId: node.parentId,
                dbid: node.dbid,
            },
            success: function (res) {
                relode();
            }
        });

    }
/*右键添加修改选项
* add:
* update:
* */
    function au(index) {
        var node = $("#treeGrid").treegrid("getSelected");
        console.log(node);
        /*add*/
        if (index == 1) {
            $("#window").window({
                title: "编辑权限",
                iconCls: "icon-edit",
                collapsible: false,
                minimizable: false,
                maximizable: false,
                modal: true,
                resizable: false
            }).window("open");
            $("#ff").form("clear");
            /*id 取什么=-=*/
            $("#parentId").textbox("setValue", node.dbid);
            $("#parentName").textbox("setValue", node.authName);
            $("#layer").textbox("setValue", node.layer + 1);
            $("#tag").textbox("setValue", 1);
        }
        /*update*/
        if (index == 2) {
            if (node.parentId === -1) {
                $.messager.alert('警告', '根节点无法编辑', 'warning');
                return;
            }
            $("#window").window({
                title: "编辑权限",
                iconCls: "icon-edit",
                collapsible: false,
                minimizable: false,
                maximizable: false,
                modal: true,
                resizable: false
            }).window("open");
            $("#ff").form("clear");
            var parent = $('#treeGrid').treegrid('getParent', node.dbid);
               console.log(parent);
            /*         $("#parentName").text(parent.authName);
                     $("#layer").text(node.layer);*/
            $("#ff").form('load', {
                tag: 2,
                dbid: node.dbid,
                parentId: node.parentId,
                parentName: parent.authName,
                authName: node.authName,
                layer: node.layer,
                authCode: node.authCode,
                authURL: node.authURL,
                orders: node.orders,
                type: node.type,
                valid: node.valid
            });
            /*                 $("#tag").textbox("setValue",2);
                             $("#dbid").textbox("setValue",node.dbid);
                             $("#parentId").textbox("setValue",node.parentId);
                             $("#parentName").textbox("setValue",parent.authName);
                             $("#layer").textbox("setValue",node.layer);
                             $("#authName").textbox("setValue",node.authName);
                             $("#authCode").textbox("setValue",node.authCode);
                             $("#authURL").textbox("setValue",node.authURL);
                             $("#orders").textbox("setValue",node.orders);
                             $("#type").combobox("setValue",node.type);
                             $("#valid").combobox("setValue",node.valid);*/
        }
    }

</script>
<body>
<%--右键菜单--%>
<div id="mm" class="easyui-menu" style="width:120px;">
    <div onclick="au(1)" data-options="iconCls:'icon-add'">添加</div>
    <div onclick="au(2)" data-options="iconCls:'icon-edit'">编辑</div>
    <div onclick="removeAuth()" data-options="iconCls:'icon-remove'">删除</div>
    <%--    <div onclick="valid(1)" data-options="iconCls:'icon-remove'">生效</div>
        <div onclick="valid(0)" data-options="iconCls:'icon-remove'">失效</div>--%>
    <div class="menu-sep"></div>
    <div onclick="relode()" data-options="iconCls:'icon-reload'">刷新</div>
</div>


<%--添加列表--%>
<div id="window" class="easyui-window" title="添加" data-options="closed:true"
     style="width:550px;height:450px;padding:5px">
    <form id="ff" class="easyui-form" style="width:450px;margin-top:5px;padding-left: 40px" method="post"
          data-options="novalidate:true">
        <input type="hidden" id="dbid"  name="dbid" class="easyui-textbox">
        <input type="hidden" id="tag" name="tag" class="easyui-textbox">
        <input type="hidden" id="parentId" name="parentId" class="easyui-textbox">
        <div style="margin-bottom:20px">
            <input class="easyui-textbox" id="parentName" name="parentName"  style="width:100%"
                   data-options=" label:'上级节点：',required:true,readonly:true">
        </div>
        <div style="margin-bottom:20px">
            <input class="easyui-textbox" id="layer" name="layer"  style="width:100%"
                   data-options=" label:'当前层级：',required:true,readonly:true">
        </div>
        <div style="margin-bottom:20px">
            <input id="authName" name="authName"  class="easyui-textbox" style="width:100%"
                   data-options="label:'权限名称：',required:true">
        </div>
        <div style="margin-bottom:20px">
            <input id="authCode" name="authCode"  class="easyui-textbox" style="width:100%"
                   data-options="label:'权限编码：',required:true">
        </div>
        <div style="margin-bottom:20px">
            <input id="authURL" name="authURL" class="easyui-textbox" style="width:100%"
                   data-options="label:'URL：',required:true">
        </div>
        <div style="margin-bottom:20px">
            <input id="orders" name="orders" class="easyui-textbox" style="width:100%;height:60px"
                   data-options="label:'排序：',multiline:true">
        </div>
        <select id="type" name="type"  class="easyui-combobox"
                data-options="label:'类型：',editable:false,panelHeight:'70px'" style="width:200px;height:30px">
            <option value="1">模块</option>
            <option value="2">资源</option>
        </select>
        <select id="valid" name="valid"  class="easyui-combobox"
                data-options="label:'是否有效：',editable:false,panelHeight:'70px'" style="width:200px;height:30px">
            <option value="1">有效</option>
            <option value="0">无效</option>
        </select>
    </form>
    <div style="text-align:center;padding:5px 0">
        <a href="javascript:void(0)" class="easyui-linkbutton" onclick="submitForm()" style="width:80px">保存</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" onclick="clearForm()" style="width:80px">关闭</a>
    </div>
</div>
<%--treeGrid--%>
<table id="treeGrid"  style="width:100%;height:100%"></table>
</body>
</html>
