<%@ page language="java" contentType="text/html; charset=UTF-8"
	import="java.util.*" pageEncoding="UTF-8"%>
<% pageContext.setAttribute("root", request.getContextPath());
	String root=request.getContextPath();
%>
<% if(request.getSession().getAttribute("user")==null){
	response.sendRedirect(request.getContextPath()+"/redirect.jsp");
}
%>
<!DOCTYPE html>
<html>
<head>
<title>后台报表系统</title>
<meta HTTP-EQUIV="pragma" CONTENT="no-cache">
<meta HTTP-EQUIV="Cache-Control" CONTENT="no-cache, must-revalidate">
<meta HTTP-EQUIV="expires" CONTENT="0">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="renderer" content="webkit">

<!-- js方便获取根路径  根路径以/开头-->
<input type="hidden" id="root" value="<%=root%>">
<link rel="shortcut icon" href="favicon.ico" type="image/x-icon" />
<!-- 样式 -->
<link href="<%=root%>/common/css/bootstrap.css" rel="stylesheet"
	type="text/css">
<link href="<%=root%>/common/css/font-awesome.css" rel="stylesheet"
	type="text/css">
<link href="<%=root%>/common/css/font-awesome.min.css" rel="stylesheet"
	type="text/css">

<link href="<%=root%>/common/css/bootstrap-table.css" rel="stylesheet"
	type="text/css">
<link href="<%=root%>/common/css/bootstrap-select.min.css"
	rel="stylesheet" type="text/css">
<link href="<%=root%>/common/css/bootstrap-datetimepicker.min.css"
	rel="stylesheet" type="text/css">
<link href="<%=root%>/common/css/tableWin.css" rel="stylesheet"
	type="text/css">
<!-- 脚本 -->
<script type="text/javascript" src="<%=root%>/common/js/jquery1.11.js"> </script>
<script type="text/javascript"
	src="<%=root%>/common/js/bootstrap.min.js"></script>
<script type="text/javascript"
	src="<%=root%>/common/js/bootstrap-table.js"></script>
<script type="text/javascript"
	src="<%=root%>/common/js/bootstrap-select.min.js"></script>
<script type="text/javascript"
	src="<%=root%>/common/js/bootstrap-datetimepicker.min.js"></script>
<script type="text/javascript" src="<%=root%>/common/js/respond.js"></script>
<script type="text/javascript" src="<%=root%>/common/js/public.js"></script>
<script type="text/javascript" src="<%=root%>/common/js/tableWin.js"></script>
<link href="${root}/common/css/ace.min.css" rel="stylesheet"
	type="text/css">

<script type="text/javascript" src="<%=root%>/common/js/ace.min.js"></script>
<script type="text/javascript"
	src="<%=root%>/common/js/ace-extra.min.js"></script>
<style type="text/css">
table {
	color: red;
}
</style>
</head>
<body>
	<div id="index_moddal"></div>
	<div class="navbar navbar-default" id="navbar">
		<div class="navbar-container" id="navbar-container">
			<div class="navbar-header pull-left">
				<a href="#" class="navbar-brand"> <small> <img
						src="images/logo.png" alt="" width="50px" height="50px" style="">
						后台报表系统
				</small>
				</a>
				<!-- /.brand -->
			</div>
			<!-- /.navbar-header -->

			<div class="navbar-header pull-right" role="navigation">
				<ul class="nav ace-nav">
					<!-- <li class="grey">
							<a data-toggle="dropdown" class="dropdown-toggle" href="#">
								<i class="icon-tasks"></i>
								<span class="badge badge-grey">4</span>
							</a>

							<ul class="pull-right dropdown-navbar dropdown-menu dropdown-caret dropdown-close">
								<li class="dropdown-header">
									<i class="icon-ok"></i>
									4个任务需要处理
								</li>

								<li>
									<a href="#">
										<div class="clearfix">
											<span class="pull-left">Software Update</span>
											<span class="pull-right">65%</span>
										</div>

										<div class="progress progress-mini ">
											<div style="width:65%" class="progress-bar "></div>
										</div>
									</a>
								</li>

								<li>
									<a href="#">
										<div class="clearfix">
											<span class="pull-left">Hardware Upgrade</span>
											<span class="pull-right">35%</span>
										</div>

										<div class="progress progress-mini ">
											<div style="width:35%" class="progress-bar progress-bar-danger"></div>
										</div>
									</a>
								</li>

								<li>
									<a href="#">
										<div class="clearfix">
											<span class="pull-left">Unit Testing</span>
											<span class="pull-right">15%</span>
										</div>

										<div class="progress progress-mini ">
											<div style="width:15%" class="progress-bar progress-bar-warning"></div>
										</div>
									</a>
								</li>

								<li>
									<a href="#">
										<div class="clearfix">
											<span class="pull-left">Bug Fixes</span>
											<span class="pull-right">90%</span>
										</div>

										<div class="progress progress-mini progress-striped active">
											<div style="width:90%" class="progress-bar progress-bar-success"></div>
										</div>
									</a>
								</li>

								<li>
									<a href="#">
										查看所有
										<i class="icon-arrow-right"></i>
									</a>
								</li>
							</ul>
						</li>
						<li class="purple">
							<a data-toggle="dropdown" class="dropdown-toggle" href="#">
								<i class="icon-bell-alt icon-animated-bell"></i>
								<span class="badge badge-important">8</span>
							</a>

							<ul class="pull-right dropdown-navbar navbar-pink dropdown-menu dropdown-caret dropdown-close">
								<li class="dropdown-header">
									<i class="icon-warning-sign"></i>
									8 个通告
								</li>

								<li>
									<a href="#">
										<div class="clearfix">
											<span class="pull-left">
												<i class="btn btn-xs no-hover btn-pink icon-comment"></i>
												New Comments
											</span>
											<span class="pull-right badge badge-info">+12</span>
										</div>
									</a>
								</li>

								<li>
									<a href="#">
										<i class="btn btn-xs btn-primary icon-user"></i>
										Bob just signed up as an editor ...
									</a>
								</li>

								<li>
									<a href="#">
										<div class="clearfix">
											<span class="pull-left">
												<i class="btn btn-xs no-hover btn-success icon-shopping-cart"></i>
												New Orders
											</span>
											<span class="pull-right badge badge-success">+8</span>
										</div>
									</a>
								</li>


								<li>
									<a href="#">
										查看所有
										<i class="icon-arrow-right"></i>
									</a>
								</li>
							</ul>
						</li> -->
					<li class="light-blue"><a data-toggle="dropdown" href="#"
						onclick="out()" class="dropdown-toggle"
						style="background-color: #009F5D;"> <i class="icon-off"></i>退出
							<!-- <i class="icon-caret-down"></i> -->
					</a> <!-- <ul class="user-menu pull-right dropdown-menu dropdown-yellow dropdown-caret dropdown-close">
								<li>
									<a href="#">
										<i class="icon-cog"></i>
										设置
									</a>
								</li>

								<li>
									<a href="#">
										<i class="icon-user"></i>
										基本信息
									</a>
								</li>

								<li class="divider"></li>

								<li>
									<a href="#" onclick="out()">
										<i class="icon-off"></i>
										退出
									</a>
								</li>
							</ul> --></li>
				</ul>
				<!-- /.ace-nav -->
			</div>
			<!-- /.navbar-header -->
		</div>
		<!-- /.navbar-header -->
	</div>
	<!-- /.container -->

	</div>
	<div class="main-container" id="main-container">

		<div class="main-container-inner">
			<a class="menu-toggler" id="menu-toggler" href="#"> <span
				class="menu-text"></span>
			</a>

			<div class="sidebar" id="sidebar">
				<ul id="ulList" class="nav nav-list">

				</ul>

				<div class="sidebar-collapse" id="sidebar-collapse">
					<i class="icon-double-angle-left"
						data-icon1="icon-double-angle-left"
						data-icon2="icon-double-angle-right"></i>
				</div>

			</div>

			<div id="main_content" class="main-content">
				<div class="breadcrumbs" id="breadcrumbs">
					<ul id="breadcrumb" class="breadcrumb">
						<li><i class="icon-home home-icon"></i> <a href="console.jsp">主页</a>
						</li>
						<li id="breadcrumb1"></li>
						<li id="breadcrumb2" class="active"></li>
					</ul>
					<!-- .breadcrumb -->

					<div id="page-content" class="page-content">
						<iframe id="iframe" width="100%" height="100%" name="iframe"
							onload="iFrameHeight()" frameborder="0" src="index.jsp">

						</iframe>
					</div>
				</div>
				<!-- /.main-content -->

			</div>
			<!-- /.main-container-inner -->


		</div>
		<!-- /.main-container -->

	</div>
	</div>
</body>
<script type="text/javascript">
 function iFrameHeight() {
	var heigth = $(window).height();
	var ifm= document.getElementById("iframe");
	var subWeb = document.frames ? document.frames["iframe"].document : ifm.contentDocument;
	if(ifm != null && subWeb != null) {
				//ifm.height = subWeb.body.offsetHeight>$(window).height()-100?subWeb.body.offsetHeight+30:$(window).height()-110;
				$("#page-content").height(subWeb.body.offsetHeight+40>$(window).height()-50?subWeb.body.offsetHeight+40:$(window).height()-100);
				//ifm.height=$(window).height()-115;
	}
	//console.log("subWeb.body.scrollHeight:"+subWeb.body.scrollHeight+"   ifm:"+ifm.height+"   $(window).height():"+$(window).height());
	}  
	

	
$(function(){
	$("#breadcrumb1").hide();
	$("#breadcrumb2").hide();
	loadmenus();
	var b=true;
	//1分钟校验一次session是否存在
	//existSession();
});
function existSession(){
	$.ajax({
				type : "POST",
				url :getval("root")+"/common/PublicAction/existSession.json",
				async:false,
				dataType : 'text',
				contentType : 'application/x-www-form-urlencoded;charset=utf-8',
				success : function(data) {
					var data = eval('(' + data + ')');
					if(data.code=="0"){
							goUrl(root+'/login.jsp');
					}
				}
			});
	setTimeout(existSession, 1000*60);
}

function loadmenus(){
	$.ajax({
		type : "POST",
		url :getval("root")+"/auth/getallmenu",
		async:false,
		data :{},
		dataType : 'text',
		contentType : 'application/x-www-form-urlencoded;charset=utf-8',
		success : function(data) {
			var data = eval('(' + data + ')');
			loadmenu($("#ulList"),data);
		}
	}); 
//	var menu=[{text:"直达报表",url:"aa",notes:[{text:"第一个报表",url:"/res.jsp"}]},{text:"物流报表",url:"aa",notes:[{text:"第一个报表",url:"/res.jsp"}]}];
	//loadmenu($("#ulList"),menu);
}

function out(){
	goUrl(root+"/indexs/loginout");
}

function loadmenu(menu, note) {
	console.log(note);
	menu.html('');
	$.each(note, function(i, o) {
		o.icon = o.icon || "glyphicon glyphicon-cog";
		if (o.nodes == null) {
			menu.append('<li><a href="#" onclick="toBreadcrumb(\'' + o.text + '\',\'' + o.text + '\',\'' + o.url + '\')" ><i class="' + o.icon + '"></i><span class="menu-text">'
					+ o.text + '</span></a></li>')
		}
		else {
			var $li = $('<li ><a href="#" class="dropdown-toggle"><i class=\'' + o.icon + '\'></i><span class="menu-text">' + o.text
					+ '</span><b class="arrow icon-angle-down"></b></a>');
			var $ul = $('<ul class="submenu"></ul>');
			$.each(o.nodes, function(j, n) {
				n.icon = n.icon || "glyphicon glyphicon-cog";
				$ul.append('<li><a href="#" onclick="toBreadcrumb(\'' + o.text + '\',\'' + n.text + '\',\'' + n.url + '\')" ><i class="icon-double-angle-right"></i>' + n.text
						+ '</a></li>');
			});
			$li.append($ul);
			menu.append($li);
		}
	});
}

</script>
</html>
