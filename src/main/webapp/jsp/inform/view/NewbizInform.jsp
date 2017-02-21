<%@ page language="java" contentType="text/html; charset=UTF-8"
	import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@include file="/common/jsp/public.jsp"%>
<link href="<%=root%>/common/css/zTreeStyle/metro.css" rel="stylesheet"
	type="text/css">
<script type="text/javascript"
	src="<%=root%>/common/js/jquery.ztree.all-3.5.min.js"></script>
<script type="text/javascript" src="<%=root%>/common/js/loadTree.js"></script>
</head>
<body>
	<h1></h1>
	<input id="fileds" type="hidden" value='${fileds}'>
	<form hidden="true" action="" id="myForme">
		<input name="date_id" value="${_day}">
	</form>
	<div class="panel panel-default"
		style="margin-bottom: 0px; font-size: 12;">
		<div class="panel-body">
			<table id="myTable"></table>
		</div>
	</div>
</body>
<script type="text/javascript">
var myModal;
var myTable;
$(function() {
	//初始化table
	myTable = tableWin.loadTable('myTable', 'newbizinform/query', eval(getval("fileds")), {
		singleSelect : true,showColumns : true,showRefresh : true,pagination : false
		,showToggle :true,smallFild:true
	});
	
});
</script>

</html>