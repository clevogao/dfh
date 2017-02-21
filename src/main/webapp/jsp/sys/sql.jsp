<%@ page language="java" contentType="text/html; charset=UTF-8"
	import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
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
					<i class="icon icon-tasks"></i> <strong>sql</strong>
					<div class="panel-actions pull-right">
						<button class="btn btn-primary btn-small" type="button"
							onclick="select()">查询</button>
							<button class="btn btn-primary btn-small" type="button"
							onclick="excute()">执行</button>
					</div>
				</div>
				<div class="panel-body" style="height: 90%; overflow: auto;">
					<textarea id="select" rows="" cols="" style="height: 98%;resize:none;font-size: 16px" class="form-control"></textarea>
				</div>
			</div>
		</div>
		<div class="col-sm-12" style="height: 60vh; margin-top: 10px">
			<div class="panel panel-default" style="height: 100%">
				<div class="panel-heading">
					<i class="icon icon-tasks"></i> <strong>输出结果</strong>
					<div class="panel-actions pull-right">
						<button class="btn btn-primary btn-small" type="button"
							onclick="clear()">清空</button>
					</div>
				</div>
				<div class="panel-body" style="height: 90%; overflow: auto;">
						<textarea id="jieguo" readonly="readonly" rows="" cols="" style="height: 98%;resize:none;font-size: 16px" class="form-control"></textarea>
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
function select(){
	$.ajax({
				type : "POST",
				url :getval("root")+"/sql/select",
				async:false,
				data :{sql:$("#select").val()},
				contentType : 'application/x-www-form-urlencoded;charset=utf-8',
				success : function(data) {
					$("#jieguo").val(data.value);
				},
				error:function(a){
					console.log(a);
				}
			});
}
function excute(){
	$.ajax({
		type : "POST",
		url :getval("root")+"/sql/excute",
		async:false,
		data :{sql:$("#select").val()},
		contentType : 'application/x-www-form-urlencoded;charset=utf-8',
		success : function(data) {
			$("#jieguo").val(data.value);
		},
		error:function(a){
			console.log(a);
		}
	});
}
function clear(){
	$("#jieguo").val("");
}

</script>

</html>