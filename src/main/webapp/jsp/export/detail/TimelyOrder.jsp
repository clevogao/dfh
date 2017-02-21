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
	tableWin.loadSearch(eval(getval("selects")), {
		tableId : 'myTable',
		formId : 'myForme',
		dataExport:{url:'timelyorder/exportData'
			//,onclick:'data_export(\''+property.dataExport.url + '\',\''+ property.formId + '\')
			}
		});
	tableWin.loadSearchValue([
	          				{filed : "business_type",data : [{id :"null",name : "不限"}, {name : "即时性用车"},{name : "拼车"},{name : "计划性用车"}]},
	          				{filed : "instantaneity_category",data : [{id :"null",name : "不限"}, {name : "专业市场"},{name : "物流"}]},
	          				{filed : "isbdimport",data : [{id :"null",name : "不限"}, {name : "是"},{name : "否"}]},
	          				{filed : "cargo_status",data : [{id :"null",name : "不限"}, {name : "1"},{name : "0"}]},
	          				{filed : "coupon_status",data : [{id :"null",name : "不限"}, {name : "初始状态"},{name : "刚生成"},{name : "正在使用"},{name : "已使用"},{name : "已过期"},{name : "已删除"}]},
	          				{filed : "order_range",data : [{id :"null",name : "不限"}, {name : "附近司机"},{name : "常用司机"},{name : "V司机"},{name : "回程司机"},{name:"指定司机"}]}
	          			]);
	$("#search_"+"order_create_time_str").val(newDate());
	$("#search_"+"order_create_time_end").val(newDate(1));
	//初始化table
	myTable = tableWin.loadTable('myTable', 'timelyorder/query', eval(getval("fileds")), {
		sidePagination:'server',singleSelect : true,showColumns : true,showRefresh : true,pagination : true
		,showToggle :true
	});
	
});
</script>

</html>