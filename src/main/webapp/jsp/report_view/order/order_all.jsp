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
<!-- <div class="progress" data-percent="99%">
66
	<div class="progress-bar" style="width:99%;"></div>												
</div> -->
<div class="panel-body">
	<table id="myTable"></table>
</div>
<div class="panel-body">
	<div class="col-xs-2 col-xs-offset-3">
		<button type="button" onclick="refresh(9)"
			class="btn btn-default  btn-lg btn-block">公司</button>
	</div>
	<div class="col-xs-2">
		<button type="button" onclick="refresh(0)"
			class="btn btn-default  btn-lg btn-block">大区</button>
	</div>
	<div class="col-xs-2">
		<button type="button" onclick="refresh(1)"
			class="btn btn-default  btn-lg btn-block">城市</button>
	</div>
	<form id="myForme" style="display: none;" action="">
		<input id="type_id" name="type" value="9">
	</form>

	</body>
	<script type="text/javascript">
	var myModal;
	var myTable;
	var index_=0;
	$(function() {
		//初始化table
		myTable=tableWin.loadTable('myTable', 'ordercost/detail', columns,{singleSelect:true,smallFild:true});
	});
	
	 function refresh(val){
			$("#type_id").val(val);
			table_search();
	}
	
	
	
	 var columns = [ {
			field : 'organize',
			title : '各个层级'/* ,
			formatter:function(val){
				return '<a onclick="refresh(\''+val+'\')">'+val+'</a>';
			} */
	 	}, {
			field : 'order_amount_daily',
			title : '订单当日',
			sortable:true
		},{
			field : 'order_amount_daily_compare',
			title : '订单比昨日',
			formatter:function(val){
				if(val>0) return '<span style="color:red">'+(val*100).toFixed(2)+'%</span>';
				else if (val<0) return '<span style="color:green">'+(val*100).toFixed(2)+'%</span>';
			},
			sortable:true
		}, {
			field : 'order_amount_moothaverage',
			title : '订单当月日均',
			sortable:true
		},{
			field : 'cost_amount_moothaverage_compare',
			title : '成本月均比上月',
			sortable:true,
			formatter:function(val){
				if(val>0) return '<span style="color:red">'+(val*100).toFixed(2)+'%</span>';
				else if (val<0) return '<span style="color:green">'+(val*100).toFixed(2)+'%</span>';
			}
		},,{
			field : 'cost_amount_daily',
			title : '成本当日',
			sortable:true
		},{
			field : 'cost_amount_daily_compare',
			title : '成本比昨日',
			formatter:function(val){
				if(val>0) return '<span style="color:red">'+(val*100).toFixed(2)+'%</span>';
				else if (val<0) return '<span style="color:green">'+(val*100).toFixed(2)+'%</span>';
			},
			sortable:true
		},{
			field : 'cost_amount_moothaverage',
			title : '成本当月日均',
			sortable:true
		},{
			field : 'cost_amount_moothaverage_compare',
			title : '成本日均比上月',
			formatter:function(val){
				if(val>0) return '<span style="color:red">'+(val*100).toFixed(2)+'%</span>';
				else if (val<0) return '<span style="color:green">'+(val*100).toFixed(2)+'%</span>';
			},
			sortable:true
		},,{
			field : 'cost_average_daily',
			title : '票均当日',
			sortable:true
		},{
			field : 'cost_average_daily_compare',
			title : '票均比昨日',
			formatter:function(val){
				if(val>0) return '<span style="color:red">'+(val*100).toFixed(2)+'%</span>';
				else if (val<0) return '<span style="color:green">'+(val*100).toFixed(2)+'%</span>';
			},
			sortable:true
		},{
			field : 'cost_average_moothaverage',
			title : '票均当月日均',
			sortable:true
		},{
			field : 'cost_average_moothaverage_compare',
			title : '票均日均比上月',
			formatter:function(val){
				if(val>0) return '<span style="color:red">'+(val*100).toFixed(2)+'%</span>';
				else if (val<0) return '<span style="color:green">'+(val*100).toFixed(2)+'%</span>';
			},
			sortable:true
		},,{
			field : 'order_amount_completion ',
			title : '订单完成比',
			formatter:function(val){
				if(val>0) return '<span style="color:red">'+(val*100).toFixed(2)+'%</span>';
				else if (val<0) return '<span style="color:green">'+(val*100).toFixed(2)+'%</span>';
			},
			sortable:true
		},,{
			field : 'order_cost_completion',
			title : '成本完成比',
			formatter:function(val){
				if(val>0) return '<span style="color:red">'+(val*100).toFixed(2)+'%</span>';
				else if (val<0) return '<span style="color:green">'+(val*100).toFixed(2)+'%</span>';
			},
			sortable:true
		},,{
			field : 'cargouser_create',
			title : '货主注册数',
			sortable:true
		},{
			field : 'truckuser_create',
			title : '司机注册数',
			sortable:true
		}];
</script>
</html>