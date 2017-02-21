<%@ page language="java" contentType="text/html; charset=UTF-8"
	import="java.util.*" pageEncoding="UTF-8"%>
<% String path = request.getContextPath();%>
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
		style="margin-right: 0px; height: 70vh;">
		<br>
		<div class="col-sm-3" style="height: 100%;">
			<div class="panel panel-default" style="height: 100%">
				<div class="panel-heading">
					<i class="icon icon-tasks"></i> <i class="fa fa-car"></i><strong>系统组</strong>
					<div class="panel-actions pull-right">
						<!-- 	<button class="btn btn-primary btn-small" type="button" onclick="addFun(0)">添加组</button> -->
					</div>
				</div>
				<div class="panel-body" style="height: 90%; overflow: auto;">
					<ul id="trees_group" class="ztree"></ul>
				</div>
			</div>
		</div>
		<div class="col-sm-3" style="height: 100%;">
			<div class="panel panel-default" style="height: 100%">
				<div class="panel-heading">
					<i class="icon icon-tasks"></i> <i class="fa fa-car"></i><strong>系统菜单</strong>
					<div class="panel-actions pull-right">
						<button class="btn btn-primary btn-small" type="button"
							onclick="editAuth(0)">保存</button>
					</div>
				</div>
				<div class="panel-body" style="height: 90%; overflow: auto;">
					<ul id="trees_menu" class="ztree"></ul>
				</div>
			</div>
		</div>

		<div class="col-sm-3" style="height: 100%">
			<div class="panel panel-default" style="height: 100%">
				<div class="panel-heading">
					<i class="icon icon-tasks"></i> <strong>对应层级</strong>
					<div class="panel-actions pull-right">
						<button class="btn btn-primary btn-small" type="button"
							onclick="editAuth(1)">保存</button>
					</div>
				</div>
				<div class="panel-body" style="height: 90%; overflow: auto;">
					<ul id="trees_org" class="ztree"></ul>
				</div>
			</div>
		</div>
		<div class="col-sm-3" style="height: 100%">
			<div class="panel panel-default" style="height: 100%">
				<div class="panel-heading">
					<i class="icon icon-tasks"></i> <strong>对应字段</strong>
					<div class="panel-actions pull-right">
						<button class="btn btn-primary btn-small" type="button"
							onclick="editAuth(2)">保存</button>
					</div>
				</div>
				<div class="panel-body" style="height: 90%; overflow: auto;">
					<ul id="trees_field" class="ztree"></ul>
				</div>
			</div>
		</div>
	</div>

	<!--编辑表单 end -->

</body>
<script type="text/javascript">
$(function(){
	loadGroup();
	loadMenuTree();
	loadOrgTree();
	loadOrgField();
})
var myModal;
var click_menuid;
var setting = {
		check : {
			enable : false
		},
		view : {
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

function loadGroup(){
	$.ajax({
		type : "POST",
		url : root + "/auth/getOrg",
		async : true,
		data : {},
		dataType : 'text',
		contentType : 'application/x-www-form-urlencoded;charset=utf-8',
		success : function(data) {
			var zNodes = eval('(' + data + ')');
			$.fn.zTree.init($("#trees_group"), setting, zNodes);
		}
	});
}


function loadMenuTree(){
	loadTree('/group/getMenu','trees_menu',{expandAll:true,check : {enable : true},data : {
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
	},
	view : {
		dblClickExpand : true,
		showLine : true,
		selectedMulti : false,
		fontCss: function(treeId, treeNode){
			return treeNode.del == 1 ? {color:"red"} : {};
		}
	}
	
	});//tree
}
function loadOrgTree(){
	loadTree('/group/getOrg','trees_org',{expandAll:true,check : {enable : true},data : {
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
function loadOrgField(){
	loadTree('/group/getFieldAll','trees_field',{
		check : {enable : true},
		view : {
			dblClickExpand : true,
			showLine : true,
			selectedMulti : false,
			fontCss: function(treeId, treeNode){
				return treeNode.del == 1 ? {color:"red"} : {};
			}
		},
		data : {
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



/*点击左边显示右边拥有菜单权限的人*/
function showMenuAuth(id){
	ajaxFunctionAsyncTrue("group/getMenuAuth", {id:id}, function(data){
		checkAllTree("trees_menu",data);
	});
	ajaxFunctionAsyncTrue("group/getOrgAuth", {id:id}, function(data){
		checkAllTree("trees_org",data);
	});
	ajaxFunctionAsyncTrue("group/getFieldAuth", {id:id}, function(data){
		checkAllTree("trees_field",data);
	});
}
/*编辑菜单权限*/
function editAuth(type){
	if(!click_menuid){
		tableModel.error("请先选择左侧人员","警告");
		return ;
	}
	if((""+click_menuid).length<15){
		tableModel.error("请选择左侧的人员","警告");
		return ;
	}
	
	var editurl="";
	var treeid="";
	if(type==2){
		editurl="editFieldAuth";
		treeid="trees_field";
	}else if(type==1){
		editurl="editOrgAuth";
		treeid="trees_org";
	}else{
		editurl="editMenuAuth";
		treeid="trees_menu";
	}
	var nodes=$.fn.zTree.getZTreeObj(treeid).getCheckedNodes(true);
	var ids="";
/* 	if(type==2){
		$.each(nodes, function(i, o) {
			if(o.id=="0"||o.id==0){
				
			}else{
				if(o.tablename=="0"||o.tablename==0){
					
				}else{
					ids += ","+o.id;
				}
			}
		});
		ids=ids.substring(1);
	}else{ */
		$.each(nodes, function(i, o) {
			if(o.id=="0"||o.id==0){
			}else{
				ids += ","+o.id;
			}
		});
		ids=ids.substring(1);
//	}
	ajaxFunction("group/"+editurl, {ids:ids,id:click_menuid}, function(data){
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

function setFontCss(treeId, treeNode){
	return treeNode.del == 1 ? {color:"red"} : {};
}	

</script>

</html>