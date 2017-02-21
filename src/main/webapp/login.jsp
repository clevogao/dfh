<%@ page language="java" contentType="text/html; charset=UTF-8"
	import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<% pageContext.setAttribute("root", request.getContextPath());
	String root=request.getContextPath();
%>
<title>后台报表系统</title>
<meta HTTP-EQUIV="expires" CONTENT="0">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="renderer" content="webkit">

<!-- js方便获取根路径  根路径以/开头-->
<input type="hidden" id="root" value="<%=root%>">
<link rel="shortcut icon" href="favicon.ico" type="image/x-icon" />
<!-- 样式 -->
<link href="<%=root%>/common/css/bootstrap.css" rel="stylesheet"
	type="text/css">
<!-- 脚本 -->
<script type="text/javascript" src="<%=root%>/common/js/jquery1.11.js"> </script>
<script type="text/javascript"
	src="<%=root%>/common/js/bootstrap.min.js"></script>
<script type="text/javascript" src="<%=root%>/common/js/respond.js"></script>
<script type="text/javascript" src="<%=root%>/common/js/public.js"></script>
<script type="text/javascript" src="<%=root%>/common/js/tableWin.js"></script>
<style type="text/css">
.login {
	background: white;
	filter: alpha(Opacity = 60);
	-moz-opacity: 0.6;
	opacity: 0.6;
	border: none;
}
</style>
</head>
<body
	style="background-color:black;background-image: url('<%=root%>/images/2.jpg');">
	<div style="height: 27vh"></div>
	<input id="nologin" type="hidden" value="${nologin}">
	<div class="panel panel-default"
		style="margin: auto; width: 380px; height: 220px; background-color: white; opacity: 0.8;"
		onmouseout="hidenopactiy(this)" onmousemove="showopacity(this)">
		<div style="margin: auto; width: 80%; height: 170px;">
			<form id="loginForm" action="" class="form-horizontal">
				<div style="height: 30px;"></div>
				<div id="divLoginName" style="padding-left: 3%;"
					class="form-group has-feedback">
					<input type="text" class="form-control" id="login_name"
						name="loginname" placeholder="用户名"> <span
						class="glyphicon glyphicon-user form-control-feedback"></span>
				</div>
				<br>
				<div id="divLoginPas" style="padding-left: 3%;"
					class="form-group has-feedback">
					<input type="password" class="form-control" style="" id="password"
						name="password" placeholder="密码"> <span
						class="glyphicon glyphicon-lock form-control-feedback"></span>
				</div>
			</form>
		</div>
		<button type="button" onclick="login()" class="btn btn-primary"
			style="float: right; margin-right: 10%" data-loading-text="等待..."
			value="Login" />
		登录
		</button>
	</div>
</body>

<script type="text/javascript">
function showopacity(o){
	$(o).css("opacity","1");
}
function hidenopactiy(o){
	$(o).css("opacity","0.7");
}

$(document).keyup(function(event) {
	if (event.keyCode == 13) {//回车登陆
		login();
	}
});	
$(function(){
	$('button[data-loading-text]').click(function () {
	    var btn = $(this).button('loading');
	    setTimeout(function () {
	        btn.button('reset');
	    }, 1000);
	});
	if(getval("nologin")==1){
		tableWin.alert("请先登录");
	}
});
function login(){
	$("#lname").html("");
	$("#pass").html("");
	var name=$("#login_name").val();
	var word=$("#password").val();
	removeInfos();
	$("#divLoginName").removeClass("has-error");
	$("#divLoginPas").removeClass("has-error");
	if(name==""){ 
		$("#divLoginName").addClass("has-error");
		$("#divLoginName").append('<label name="infos" class="control-label" >用户名不能为空</label>');
		
	}
	else if(word==""){
		$("#divLoginPas").addClass("has-error");
		$("#divLoginPas").append('<label name="infos" class="control-label" >密码不能为空</label>');
	}else{
		$.ajax({
					type : "POST",
					url :root+"/indexs/login",
					data:$("#loginForm").serialize(),
					contentType : 'application/x-www-form-urlencoded;charset=utf-8',
					success : function(data) {
						//var data = eval('(' + data + ')');
						if(data==0){
							goUrl(getval("root")+"/console.jsp");
						}else{
							if(data.code=="1"){
							$("#divLoginName").addClass("has-error");
							$("#divLoginName").append('<label name="infos" class="control-label" >'+data.msg+'</label>');
							}else if(data.code=="2"){
								$("#divLoginPas").addClass("has-error");
								$("#divLoginPas").append('<label name="infos" class="control-label" >'+data.msg+'</label>');
							}else if(data.code=="3"){
								$("#divLoginPas").append('<label name="infos" class="control-label" >'+data.msg+'</label>');
							}
							else{
								tableWin.alert("数据异常");
							}
						}
					}
				});
	}
}
</script>
</html>