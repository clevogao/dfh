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
		<div class="col-sm-12" style="height: 30vh;">
			<div class="panel panel-default" style="height: 100%">
				<div class="panel-heading">
					<i class="icon icon-tasks"></i> <strong>报表sql</strong>
					<div class="panel-actions pull-right">
						<button class="btn btn-primary btn-small" type="button"
							onclick="addFun(0)">选 择</button>
					</div>
				</div>
				<div class="panel-body" style="height: 90%; overflow: auto;">
					<ul id="trees" class="ztree"></ul>
				</div>
			</div>
		</div>
		<div class="col-sm-12" style="height: 60vh; margin-top: 10px">
			<div class="panel panel-default" style="height: 100%">
				<div class="panel-heading">
					<i class="icon icon-tasks"></i> <strong>输出结果</strong>
					<div class="panel-actions pull-right">
						<button class="btn btn-primary btn-small" type="button"
							onclick="addMenu(0)">功 能</button>
					</div>
				</div>
				<div class="panel-body" style="height: 90%; overflow: auto;">
					<div id="tree"></div>
				</div>
			</div>
		</div>
	</div>

	<!--编辑表单  -->
	<div id="select_table" class="plaen">dddd</div>
	<!--编辑表单 end -->

</body>
<script type="text/javascript">
var myModal;




$(function(){
	myModal=showModal($("#select_table"),{title:"添加",btnName:'保存',funName:'insert'});//初始化编辑表单
})
function addFun(pid){
		//$("#select_table")[0].reset();
		myModal.modal('show');
}	
function addMenu(pid){
	tableModel.error("aaa","李想傻逼");
}


/**
 * 编辑
 */
function editRes(id,type){
	myModal.modal('show');
	ajaxFunctionAsyncTrue('acl/action/ResManager/searchOne.json', {id:id}, function(data){
		data=eval('(' + data + ')').treeOne[0];
		tableWin.dataToForm(data);
		if(type){
			$("#tubiao_div").hide();
		}else{
			$("#tubiao_div").show();
		}
	})
	
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


//添加或者更新
function insert(type){
	ajaxFunctionAsyncTrue('acl/action/ResManager/addOrUpdate.json',$("#addForm").serialize(), function(data){
			data=eval('(' + data + ')');
			if (data.code == '0') {
				myModal.modal('hide');
				if($("#RES_TYPE").val()==0){
					loadMenuTree();
				}else{
					loadFunTree();
				}
			}else {
				tableWin.alert("错误");
			}
	});
}



</script>

</html>