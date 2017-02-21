<%@ page language="java" contentType="text/html; charset=UTF-8"
	import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
%>
<%
	if (request.getSession().getAttribute("user") == null) {
		response.sendRedirect(request.getContextPath() + "/redirect.jsp");
	}
%>
<!DOCTYPE html>
<html>
<head>
<%@include file="/common/jsp/public.jsp"%>
<link href="<%=root%>/common/css/bootstrap-treeview.css"
	rel="stylesheet" type="text/css">
<link href="<%=root%>/common/css/zTreeStyle/metro.css" rel="stylesheet"
	type="text/css">
<script language="JavaScript"
	src="<%=root%>/common/js/bootstrap-treeview.js"></script>
<script language="JavaScript"
	src="<%=root%>/common/js/jquery.ztree.all-3.5.min.js"></script>
<script language="JavaScript" src="<%=root%>/common/js/loadTree.js"></script>
<style type="text/css">
</style>
</head>
<body style="background-color: white;">
	<div id="row" class="row nobottom"
		style="margin-right: 0px; height: 520px;">
		<br>
		<div class="col-sm-6" style="height: 100%;">
			<div class="panel panel-default" style="height: 100%">
				<div class="panel-heading">
					<i class="icon icon-tasks"></i> <i class="fa fa-car"></i><strong>菜单</strong>
					<div class="panel-actions pull-right">
						<button class="btn btn-primary btn-small" type="button"
							onclick="addFun(0)">添加菜单模块</button>
					</div>
				</div>
				<div class="panel-body" style="height: 90%; overflow: auto;">
					<ul id="trees" class="ztree"></ul>
				</div>
			</div>
		</div>
		<div class="col-sm-6" style="height: 100%">
			<div class="panel panel-default" style="height: 100%">
				<div class="panel-heading">
					<i class="icon icon-tasks"></i> <strong>分配权限</strong>
					<div class="panel-actions pull-right">
						<button class="btn btn-primary btn-small" type="button"
							onclick="editMenuAuth()">保存</button>
					</div>
				</div>
				<div class="panel-body" style="height: 90%; overflow: auto;">
					<ul id="trees_organization" class="ztree"></ul>
				</div>
			</div>
		</div>
	</div>

	<!--编辑表单  -->
	<form id="addForm" class="form-horizontal">
		<input id="id" name="id" style="display: none;"> <input
			id="pid" name="pid" style="display: none;">
		<div class="form-group">
			<label id="res_name_title" class="control-label col-sm-2">菜单名称:</label>
			<div class="col-sm-10">
				<input type="text" id='text' name="text" class="form-control">
			</div>
		</div>
		<div class="form-group">
			<label class="control-label col-sm-2">URL:</label>
			<div class="col-sm-10">
				<input type="text" id='url' name="url" class="form-control">
			</div>
		</div>
		<div id="tubiao_div" class="form-group">
			<label class="control-label col-sm-2">图标:
				<li id="tubiao" class="glyphicon glyphicon-th-list"></li>
			</label>
			<div class="col-sm-10">
				<input onchange="changeTubiao(this)" type="text" id='icon'
					name="icon" class="form-control">
			</div>
		</div>
	</form>
	<!--编辑表单 end -->

</body>
<script type="text/javascript">
$(function(){
	myModal=showModal($("#addForm"),{title:"添加",btnName:'保存',funName:'insert'});//初始化编辑表单
	loadMenuTree();
	//loadFunTree();
	loadOrgTree();
})
var myModal;
var click_menuid;
var setting = {
		check : {
			enable : false
		},
		view : {
			addHoverDom : addHoverDom,
			removeHoverDom : removeHoverDom,
			dblClickExpand : true,
			showLine : true,
			selectedMulti : false,
			fontCss: setFontCss
		},
		data : {
			simpleData : {
				enable : true,
				idKey : "id",
				pIdKey : "pid",

			},
			key : {
				name : "name",
				url : "",
				title : "t"
			}
		},
		callback : {
			beforeClick : function(treeId, treeNode) {
				click_menuid=treeNode.id;
				showMenuAuth(treeNode.id);
			}
		}
	};


function loadMenuTree(){
	$.ajax({
		type : "POST",
		url : root + "/auth/getmenu",
		async : true,
		data : {},
		dataType : 'text',
		contentType : 'application/x-www-form-urlencoded;charset=utf-8',
		success : function(data) {
			var zNodes = eval('(' + data + ')');
			$.fn.zTree.init($("#trees"), setting, zNodes);
		}
	});
}
function loadOrgTree(){
	loadTree('/auth/getOrg','trees_organization',{check : {enable : true},all:false,data : {
		simpleData : {
			enable : true,
			idKey : "id",
			pIdKey : "pid",

		},
		key : {
			name : "name",
			url : "url",
			title : "title"
		}
	}});//tree
}

function addFun(pid){
		$("#addForm")[0].reset();
		$("#pid").val(pid);
		if(pid>0){
			$("#tubiao_div").hide();
		}else{
			$("#tubiao_div").show();
		}
		//$("#RES_TYPE").val(1);
		myModal.modal('show');
}
function insert(){
	ajaxFunctionAsyncTrue('auth/addmenu',$("#addForm").serialize(), function(data){
		if (data==1) {
				myModal.modal('hide');
				loadMenuTree();
		}else {
			tableModel.error("错误","提示");
		}
});
}



function delRes(id,type){
	tableModel.alert("","确定要删除吗？",function(){
		$.ajax({
			type : "POST",
			url :root+"/acl/action/ResManager/del.json",
			async:false,
			data :{id:id},
			contentType : 'application/x-www-form-urlencoded;charset=utf-8',
			success : function(data) {
				var data = eval('(' + data + ')');
				if(data.code=="0"){
					if(type!=null){
						loadFunTree();
					}else{
						loadMenuTree();
						window.parent.loadmenus();
					}
				}else{
					tableWin.alert("删除异常")
				}
			}
		});
})
}

/*点击左边显示右边拥有菜单权限的人*/
function showMenuAuth(id){
	ajaxFunctionAsyncTrue("auth/getMenuAuth", {id:id}, function(data){
		checkAllTree("trees_organization",data);
	});
}
/*编辑菜单权限*/
function editMenuAuth(){
	var nodes=$.fn.zTree.getZTreeObj("trees_organization").getCheckedNodes(true);
	var ids="";
	$.each(nodes, function(i, o) {
		ids += ","+o.id;
	});
	ids=ids.substring(1);
	if(!click_menuid){
		tableModel.error("错误","请先选择左边菜单");
		return ;
	}
	ajaxFunction("auth/editMenuAuth", {ids:ids,menu_id:click_menuid}, function(data){
		if(data==1){
			tableWin.alert("成功");
		}else{
			tableWin.alert("错误");
		}
	});
}

function changeTubiao(o){
	$("#tubiao").removeClass();
	$("#tubiao").addClass($(o).val());
}

/*添加tree按钮  */
function addHoverDom(treeId, treeNode) {
	var sObj = $("#" + treeNode.tId + "_span");
		if (treeNode.editNameFlag || $("#addBtn_" + treeNode.tId).length > 0)return;
		var addStr = "<span class='button add' onclick='addFun("+treeNode.id+")' id='addBtn_" + treeNode.tId + "' title='添加'></span>";
		addStr += "<span class='button edit' onclick='editRes(\""+treeNode.id+"\",1)' id='editBtn_" + treeNode.tId + "' title='编辑'></span>";
		addStr += "<span class='button remove' onclick='delRes("+treeNode.id+",1)' id='removeBtn_" + treeNode.tId + "' title='删除' onfocus='this.blur();'></span>";
		sObj.after(addStr);
	};
	
function setFontCss(treeId, treeNode){
	return treeNode.del == 1 ? {color:"red"} : {};
}	
function removeHoverDom(treeId, treeNode) {
		$("#addBtn_" + treeNode.tId).unbind().remove();
		$("#removeBtn_" + treeNode.tId).unbind().remove();
		$("#editBtn_" + treeNode.tId).unbind().remove();
	};

</script>

</html>