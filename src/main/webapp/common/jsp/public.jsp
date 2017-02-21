<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<% pageContext.setAttribute("root", request.getContextPath());
	String root=request.getContextPath();
	String version="1.0";
%>
<% if(request.getSession().getAttribute("user")==null){
	response.sendRedirect(request.getContextPath()+"/redirect.jsp");
}
%>
<title>后台报表系统 </title>
<meta HTTP-EQUIV="pragma" CONTENT="no-cache">
<meta HTTP-EQUIV="Cache-Control" CONTENT="no-cache, must-revalidate">
<meta HTTP-EQUIV="expires" CONTENT="0">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="renderer" content="webkit">

<!-- js方便获取根路径  根路径以/开头-->
<input type="hidden" id="root" value="<%=root%>">
<link rel="shortcut icon" href="favicon.ico" type="image/x-icon" />
<!-- 样式 -->
<link href="<%=root%>/common/css/bootstrap.css?v=<%=version%>" rel="stylesheet" type="text/css">
<link href="<%=root%>/common/css/font-awesome.min.css?v=<%=version%>" rel="stylesheet" type="text/css">
<link href="<%=root%>/common/css/bootstrap-table.css?v=<%=version%>" rel="stylesheet" type="text/css">
<link href="<%=root%>/common/css/bootstrap-select.min.css?v=<%=version%>" rel="stylesheet" type="text/css">
<link href="<%=root%>/common/css/bootstrap-datetimepicker.min.css?v=<%=version%>" rel="stylesheet" type="text/css">
<link href="<%=root%>/common/css/tableWin.css?v=<%=version%>" rel="stylesheet" type="text/css">
<!-- 脚本 -->
<script type="text/javascript" src="<%=root%>/common/js/jquery1.11.js?v=<%=version%>"> </script>
<script type="text/javascript" src="<%=root%>/common/js/bootstrap.min.js?v=<%=version%>"></script>
<script type="text/javascript" src="<%=root%>/common/js/bootstrap-table.js?v=<%=version%>"></script>
<script type="text/javascript" src="<%=root%>/common/js/bootstrap-select.min.js?v=<%=version%>"></script>
<script type="text/javascript" src="<%=root%>/common/js/bootstrap-datetimepicker.min.js?v=<%=version%>"></script>
<script type="text/javascript" src="<%=root%>/common/js/respond.js?v=<%=version%>"></script>
<script type="text/javascript" src="<%=root%>/common/js/public.js?v=<%=version%>"></script>
<script type="text/javascript" src="<%=root%>/common/js/tableWin.js?v=<%=version%>"></script>

