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
<body style="background-color: white;">
	<div class="container-fluid">
		<div id="row" class="row">
			<br>
			<div class="col-sm-4">
				<div class="panel panel-default" style="height: 100%">
					<div class="panel-heading">
						<i class="icon icon-tasks"></i> <strong>功能权限</strong>
						<div class="panel-actions pull-right">
							<button class="btn btn-default btn-small" type="button"
								onclick="addFun(0)">添加功能模块</button>
						</div>
					</div>
					<div class="panel-body" style="height: 200px; overflow: auto;">
						<ul id="regionDealerTree" class="ztree"></ul>
					</div>
				</div>
			</div>
			<div class="col-sm-4">
				<div class="panel panel-default" style="height: 100%">
					<div class="panel-heading">
						<i class="icon icon-tasks"></i> <strong>功能权限</strong>
						<div class="panel-actions pull-right">
							<button class="btn btn-default btn-small" type="button"
								onclick="addFun(0)">添加功能模块</button>
						</div>
					</div>
					<div class="panel-body" style="height: 200px; overflow: auto;">
						<input id="trees22">
					</div>
				</div>
			</div>
			<div class="col-sm-4">
				<div class="panel panel-default" style="height: 100%">
					<div class="panel-heading">
						<i class="icon icon-tasks"></i> <strong>功能权限</strong>
						<div class="panel-actions pull-right">
							<button class="btn btn-default btn-small" type="button"
								onclick="addFun(0)">添加功能模块</button>
						</div>
					</div>
					<div class="panel-body" style="height: 200px; overflow: auto;">
						<ul id="trees" class="ztree"></ul>
					</div>
				</div>
			</div>
			<div class="col-sm-4">
				<div class="panel panel-default" style="height: 100%">
					<div class="panel-heading">
						<i class="icon icon-tasks"></i> <strong>功能权限</strong>
						<div class="panel-actions pull-right">
							<button class="btn btn-default btn-small" type="button"
								onclick="getval('trees33')">添加功能模块</button>
						</div>
					</div>
					<div class="panel-body" style="height: 200px; overflow: auto;">
						<input id="tre">
					</div>
				</div>
			</div>
			<div class="col-sm-4">
				<div class="panel panel-default" style="height: 100%">
					<div class="panel-heading">
						<i class="icon icon-tasks"></i> <strong>功能权限</strong>
						<div class="panel-actions pull-right">
							<button class="btn btn-default btn-small" type="button"
								onclick="addFun(0)">添加功能模块</button>
						</div>
					</div>
					<div class="panel-body" style="height: 200px; overflow: auto;">
						<ul id="trees" class="ztree"></ul>
					</div>
				</div>
			</div>
			<div class="col-sm-4">
				<div class="panel panel-default" style="height: 100%">
					<div class="panel-heading">
						<i class="icon icon-tasks"></i> <strong>功能权限</strong>
						<div class="panel-actions pull-right">
							<button class="btn btn-default btn-small" type="button"
								onclick="addFun(0)">添加功能模块</button>
						</div>
					</div>
					<div class="panel-body" style="height: 200px; overflow: auto;">
						<ul id="trees" class="ztree"></ul>
					</div>
				</div>
			</div>
			<div class="col-sm-4">
				<div class="panel panel-default" style="height: 100%">
					<div class="panel-heading">
						<i class="icon icon-tasks"></i> <strong>功能权限</strong>
						<div class="panel-actions pull-right">
							<button class="btn btn-default btn-small" type="button"
								onclick="addFun(0)">添加功能模块</button>
						</div>
					</div>
					<div class="panel-body" style="height: 200px; overflow: auto;">
						<ul id="trees" class="ztree"></ul>
					</div>
				</div>
			</div>
			<div class="col-sm-4">
				<div class="panel panel-default" style="height: 100%">
					<div class="panel-heading">
						<i class="icon icon-tasks"></i> <strong>功能权限</strong>
						<div class="panel-actions pull-right">
							<button class="btn btn-default btn-small" type="button"
								onclick="addFun(0)">添加功能模块</button>
						</div>
					</div>
					<div class="panel-body" style="height: 200px; overflow: auto;">
						<ul id="trees" class="ztree"></ul>
					</div>
				</div>
			</div>
			<div class="col-sm-4">
				<div class="panel panel-default" style="height: 100%">
					<div class="panel-heading">
						<i class="icon icon-tasks"></i> <strong>功能权限</strong>
						<div class="panel-actions pull-right">
							<button class="btn btn-default btn-small" type="button"
								onclick="addFun(0)">添加功能模块</button>
						</div>
					</div>
					<div class="panel-body" style="height: 200px; overflow: auto;">
						<ul id="trees" class="ztree"></ul>
					</div>
				</div>
			</div>
		</div>
</body>
<!--  区域的js-->
<script type="text/javascript" src="<%=root%>/common/js/city.js"></script>
<script type="text/javascript">
//loadTree('/common/PublicAction/regionDealrTree.json','regionDealerTree',{check : {enable : true}});//区域对应销售店tree
loadSelectTree('trees22',city_tree,{check : {enable : true}});//区域
var a=[{NAME:'石家庄市'}];
checkAllTree("trees22_tree", a, true, true, {name:true})//按name选中
loadSelectTree('tre',city_tree,{check : {enable : true},onCheckForName:true});//区域取name
</script>

</html>