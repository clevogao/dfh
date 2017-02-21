<%@ page language="java" contentType="text/html; charset=UTF-8"
	import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="../../../common/jsp/public.jsp"%>
<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<script type="text/javascript" src="<%=root%>/common/js/jquery1.11.js"></script>
<script type="text/javascript">
			$(function () {
				$.ajax({
					url:'http://localhost:8080/data-report/kpi/getCargoRegCount',
					type:'post',
					data: {'butype':0, "type":2},
					datatype:'json',
					success:function(data){
						displayData(data)
					},
					error:function(){
						alert('连接超时!');
					}
				});
			});
			function displayData(Data) {
				var title = '货主注册数'
				var butype = '上海市';
				var targetData= new Array(); 				
				var time = new Array();				
				var realData = new Array();
				
				$.each(Data.Data.lately,function(i,obj){
					if(obj.position_id == butype){
						time.push(obj.createtime);
						realData.push(obj.count);
						targetData.push(obj.target);
					}
				});
			    $('#container').highcharts({
			        title: {
			            text: title,
			            x: -20 //center
			        },
			        subtitle: {
			            text: butype,
			            x: -20
			        },
			        xAxis: {
			            categories: time
			        },
			        yAxis: {
			            title: {
			                text: '完成量(人)'
			            },
			            plotLines: [{
			                value: 0,
			                width: 1,
			                color: '#808080'
			            }]
			        },
			        tooltip: {
			            valueSuffix: ''
			        },
			        legend: {
			            layout: 'vertical',
			            align: 'right',
			            verticalAlign: 'middle',
			            borderWidth: 0
			        },
			        series: [ {
			            name: '目标值',
			            data: targetData
			        }, {
			            name: '完成值',
			            data: realData
			        }]
			    });
			}
		</script>
</head>
<body>
	<script src="<%=root%>/static/js/highcharts.js"></script>
	<script src="<%=root%>/static/js/modules/exporting.js"></script>
	<div id="container"
		style="min-width: 310px; height: 400px; margin: 0 auto"></div>
	<!-- <div class="btn-group btn-group-justified " style="width: 80%;" >
  <div class="btn-group " role="group"> 
    <button type="button" class="btn btn-default">大区</button>
  </div>
  <div class="btn-group" role="group">
    <button type="button" class="btn btn-default">城市</button>
  </div>
  <div class="btn-group" role="group">
    <button type="button" class="btn btn-default">区域</button>
  </div>
  <div class="btn-group" role="group">
    <button type="button" class="btn btn-default">BD</button>
  </div>
</div>  -->

	<br>
	<br>
	<a href="./Rate">查看活跃度报表</a>
</body>
</html>