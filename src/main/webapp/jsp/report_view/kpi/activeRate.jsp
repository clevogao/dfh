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
					url:'http://localhost:8080/data-report/kpi/getCargoActiveRate',
					type:'post',
					data: {'butype':0, "type":4},
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
				var title = '直达用户活跃度'
				var butype = '0a21c7e5-8f44-4371-b752-ea16584d529d';
				var targetData= new Array(); 
				//var targetData=[-0.9, 0.6, 3.5, 8.4, 13.5, 17.0, 18.6];
				var time = new Array();
				//var time=['2015-10-23', '2015-10-24', '2015-10-25', '2015-10-26', '2015-10-27', '2015-10-28', '2015-10-29']
				var realData = new Array();
				//var realData=[-0.2, 0.8, 5.7, 11.3, 17.0, 22.0, 24.8];
				$.each(Data.Data.lately,function(i,obj){
					//console.log(obj)
					if(obj.position_id == butype){
						time.push(obj.createtime);
						realData.push(obj.month_over);
						targetData.push(obj.active_target);
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
</body>
</html>