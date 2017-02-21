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
	<input id="fileds" type="hidden" value='${fileds}'>
	<input id="selects" type="hidden" value='${selects}'>
	<div class="panel panel-default"
		style="margin-bottom: 0px; font-size: 12;">
		<div class="panel-body">

			<form role="form" class="form-horizontal" method="post" id="myForme"
				action="save"></form>
		</div>
	</div>
	<br>
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
		//加载查询条件 必须在table之前
		var select=eval(getval("selects"));
		tableWin.loadSearch(select, {
			tableId : 'myTable',
			formId : 'myForme',
			dataExport:{url:'pointcost/exportData'
				//,onclick:'data_export(\''+property.dataExport.url + '\',\''+ property.formId + '\')
				}
			});
		$("#search_"+"createdate"+"_str").val(newDate());
		$("#search_"+"createdate"+"_end").val(newDate(1));
		//初始化table
		myTable = tableWin.loadTable('myTable', 'pointcost/query', eval(getval("fileds")), {
			sidePagination:'server',singleSelect : true,showColumns : true,showRefresh : true,pagination : true
			,showToggle :true
		});
	});
</script>

</html>