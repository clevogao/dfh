<%@ page language="java" contentType="text/html; charset=UTF-8"
	import="java.util.*" pageEncoding="UTF-8"%>
	<% pageContext.setAttribute("root", request.getContextPath());
	String root=request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<title>sss </title>
<meta HTTP-EQUIV="pragma" CONTENT="no-cache">
<meta HTTP-EQUIV="Cache-Control" CONTENT="no-cache, must-revalidate">
<meta HTTP-EQUIV="expires" CONTENT="0">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="renderer" content="webkit">
<link rel="shortcut icon" href="favicon.ico" type="image/x-icon" />
<script src="<%=root%>/common/js/jquery1.11.js" type="text/javascript"></script>
<script type="text/javascript" src="<%=root%>/common/js/bootstrap.min.js"></script>
<script type="text/javascript" src="<%=root%>/common/js/public.js"></script>
<script type="text/javascript" src="<%=root%>/common/js/tableWin.js"></script>
<script type="text/javascript" src="<%=root%>/common/heightcharts/highcharts.js"></script>

<link rel="stylesheet" type="text/css" href="common/css/default.css">
<link rel="stylesheet" type="text/css" href="common/css/bootstrap.css">
<link rel='stylesheet prefetch' type="text/css" href="common/css/font-awesome.css">
<link rel="stylesheet" type="text/css" href="common/css/index-styles.css">
<link href="common/css/tableWin.css" rel="stylesheet" type="text/css">


</head>   
<body>
<section class="strips">
  <article class="strips__strip">
	<div class="strip__content" onclick="a()">
	  <h1 class="strip__title" >核<br>心<br>K<br>P<br>I<br></h1> 
		<div class="strip__inner-text" > 
			<div class="panel panel-default" style="height: 100%;overflow: auto;">
				<div class="panel-heading" >
					<i class="icon icon-tasks"></i> <strong>KPI数据展现(测试)</strong>
					<div class="panel-actions pull-right">
						<button class="btn btn-primary btn-small" type="button" onclick="addFun(0)">切换</button>
					</div>
				</div>
				<div id="report_kpi"  style="height: 90%;width: 98%;z-index: 1">
							
				</div>
			</div>
	    </div>
	</div>
  </article>
  <article class="strips__strip">
	<div class="strip__content">
	  <h1 class="strip__title" >成<br>本<br>统<br>计<br></h1>
	  <div class="strip__inner-text">
		<h2>待开发</h2>
		
		<p>
		  <a href="#" target="_blank"><i class="fa fa-car"></i></a>
		</p>
	  </div>
	</div>
  </article>
  <article class="strips__strip">
	<div class="strip__content">
	  <h1 class="strip__title" >基<br>础<br>数<br>据<br></h1>
	  <div class="strip__inner-text">
		<h2>待开发</h2>
		
		<p>
		  <a href="#" target="_blank"><i class="fa fa-car"></i></a>
		</p>
	  </div>
	</div>
  </article>
  <article class="strips__strip">
	<div class="strip__content">
	  <h1 class="strip__title" >待<br>开<br>发</h1>
	  <div class="strip__inner-text">
		<h2>待开发</h2>
		
		<p>
		  <a href="#" target="_blank"><i class="fa fa-car"></i></a>
		</p>
	  </div>
	</div>
  </article>
  <article class="strips__strip">
	<div class="strip__content">
	  <h1 class="strip__title" >待<br>开<br>发</h1>
	  <div class="strip__inner-text">
			<h2>待开发</h2>
			
			<p>
			  <a href="#" target="_blank"><i class="fa fa-car"></i></a>
			</p>
	  </div>
	</div>
  </article>
  <i class="fa fa-close strip__close"></i>
</section>

</body>
<script type="text/javascript" src="<%=root%>/common/js/index.js"></script>
<script>
setTimeout()
</script>
</html>