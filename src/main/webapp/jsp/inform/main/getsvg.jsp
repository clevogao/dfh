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

<script type="text/javascript">
	
</script>
<div id="main"></div>
<!-- ECharts单文件引入 -->
<script src="http://echarts.baidu.com/build/dist/echarts.js"></script>
<script type="text/javascript">
	var myModal;
	var myTable;
	var columns = [ {
		field : 'organize',
		title : '名称',
		formatter : function(val) {
			return '<a><span  onclick="c1(\'' + val + '\')">' + val + '</span></a>';

			// return '<a href="echart1/detailforArea"> '+val +'</a>'; 

		}
	}, {
		field : 'order_amount_daily',
		title : '单量统计'
	}, {
		field : 'cost_amount_daily',
		title : '成本统计'
	}, {
		field : 'cost_average_daily',
		title : '票均统计'
	} ];
	function c1(val) {
		if (val == '公司') {
			$('#myTable').bootstrapTable('refresh', {
				url : 'detailforArea'
			});
			// setChart($('#myTable').bootstrapTable('getData'));

			// myTable=tableWin.loadTable('myTable', 'echart1/detailforArea', columns,{singleSelect:true });
			$.ajax({
				url : root + '/echart/detailforArea', //发送请求的地址 当前页地址
				type : 'post',//请求方式
				data : {},
				datatype : 'json',
				success : function(data) {
					setChart(data)
				},
				error : function() {
					alert('连接超时!');
				}
			});
		}
		else {
			// $('#myTable').bootstrapTable('refresh',{url:'echart1/detailforArea'});
			// setChart($('#myTable').bootstrapTable('getData'));

			$.ajax({
				url : root + '/echart/detailforArea1', //发送请求的地址 当前页地址
				type : 'post',//请求方式
				data : {
					val : val
				},
				datatype : 'json',
				success : function(data) {
					setChart(data)
				},
				error : function() {
					alert('连接超时!');
				}
			});
		}

	};
	function setChart(Data, name, partent_name, color) {

		//每日的单量
		var order_amount_daily = new Array();
		//各个大区的名称
		var organize = new Array();

		var cost_amount_daily = new Array();
		var cost_average_daily = new Array();
		//获取从后天得到的值
		$.each(Data, function(i, obj) {
			order_amount_daily.push(obj.order_amount_daily);
			organize.push(obj.organize);
			cost_amount_daily.push(obj.cost_amount_daily);
			cost_average_daily.push(obj.cost_average_daily);
		});
		//封装各个大区里面具体的城市和城市单量的信息
		$('#container').highcharts({
			legend : {
				data : [ '单量统计', '成本统计', '票均统计 ' ]
			},
			chart : {
				barWidth : 15,
				type : 'column'
			},
			title : {
				text : "",
			},
			xAxis : {
				categories : organize,
				title : {
					text : ' '
				},
			},
			yAxis : {
				title : {
					text : ' '
				},
			},
			plotOptions : {
				column : {
					cursor : 'pointer',
					pointWidth : 35, //柱子的宽度
					point : {
						events : {
							click : function() {
								var drilldown = this.drilldown;
								if (drilldown) { // drill down
									setChart(drilldown.name, drilldown.categories, drilldown.data, drilldown.color);
								}
								else { // restore
									var categories;
									var name;
									var data;
									setChart(Data, name, partent_name);
								}
							}
						}
					},
					dataLabels : {
						enabled : true,

						style : {
							fontWeight : 'bold'
						},
						formatter : function() {
							return this.y + '';
						}
					}
				}
			},
			series : [ {
				barWidth : 5,
				name : '单量统计',
				data : order_amount_daily
			}, {
				barWidth : 5,
				name : '成本统计',
				data : cost_amount_daily

			}, {
				barWidth : 5,
				name : '票均统计',
				data : cost_average_daily
			} ]
		});
	};

	$(function() {
		var colors = Highcharts.getOptions().colors;
		var categories;
		$.ajax({
			url : root + '/echart/detail', //发送请求的地址 当前页地址
			type : 'post',//请求方式
			data : {},
			datatype : 'json',
			success : function(data) {
				setChart(data)
			},
			error : function() {
				alert('连接超时!');
			}
		});
		function displayData(Data) {
			/*  //每日的单量
			var order_amount_daily= new Array(); 
			 //各个大区的名称
			var partent_name = new Array();		
			 //获取从后天得到的值
			$.each(Data,function(i,obj){
				order_amount_daily.push(obj.order_amount_daily);
				partent_name.push(obj.partent_name);
			}); */
			setChart(Data, name, partent_name, color);
		}
		;

		function setChart(Data, name, partent_name, color) {
			//每日的单量
			var order_amount_daily = new Array();
			//各个大区的名称
			var organize = new Array();

			var cost_amount_daily = new Array();
			var cost_average_daily = new Array();
			//获取从后天得到的值
			$.each(Data, function(i, obj) {
				order_amount_daily.push(obj.order_amount_daily);
				organize.push(obj.organize);
				cost_amount_daily.push(obj.cost_amount_daily);
				cost_average_daily.push(obj.cost_average_daily);
			});
			//封装各个大区里面具体的城市和城市单量的信息
			$('#container').highcharts({
				legend : {
					data : [ '今日单量', '今日成本', '今日票均' ]
				},
				chart : {
					barWidth : 15,
					type : 'column'
				},
				title : {
					text : "",
				},
				xAxis : {
					categories : organize,
					title : {
						text : ' '
					},
				},
				yAxis : {
					title : {
						text : ' '
					},

				},
				plotOptions : {
					column : {
						cursor : 'pointer',
						pointWidth : 35, //柱子宽度
						point : {
							events : {
								click : function() {
									var drilldown = this.drilldown;
									if (drilldown) { // drill down
										setChart(drilldown.name, drilldown.categories, drilldown.data, drilldown.color);
									}
									else { // restore
										var categories;
										var name;
										var data;
										setChart(Data, name, partent_name);
									}
								}
							}
						},
						dataLabels : {
							enabled : true,

							style : {
								fontWeight : 'bold'
							},
							formatter : function() {
								return this.y + '';
							}
						}
					}
				},

				series : [ {
					barWidth : 5,
					name : '单量统计',
					data : order_amount_daily

				}, {
					barWidth : 5,
					name : '成本统计',
					data : cost_amount_daily

				}, {
					barWidth : 5,
					name : '票均统计',
					data : cost_average_daily

				} ]
			});
		}
		;

	});
	
	 $(function() {
			//初始化table
			 myTable=tableWin.loadTable('myTable', 'echart/detail', columns,{singleSelect:true,smallFild:true});
			// $('#container').highcharts().getSVG();
			//Download PNG image
			 setTimeout(function(){
				$("#svgdiv").html($('#container').highcharts().getSVG());
				//$(".highcharts-button").click();
				//$("div:contains('Download PNG image')").click();
			}, 1000); 
			
		});
	 
			 function ExportChart() {
				// console.log($('#container').highcharts().getSVG());
		            $.ajax(
		            {
		                type: 'POST', //post方式异步提交
		                async: false, //同步提交
		                url: root+"/index/downloadImg", //导出图表的服务页面地址
		                dataType: "json",//传递方式为json
		                //几个重要的参数 如果这里不传递width的话，需要修改导出服务页面内的Request.Form["width"].ToString() 把这句代码注释掉即可
		                data: { type: 'image/png', filename: 'MyChartTest', width: 400, svg:  $('#container').highcharts().getSVG() }, 
		                success: function (msg) {
		                    alert("图表导出成功!");
		                },
		                error: function (errorMsg) {
		                    if (errorMsg.statusText == "OK") {
		                        alert("图表导出成功!");
		                    } else {
		                        alert("图表导出失败!");
		                    }                    
		                }
		            }
		            );
		}
</script>

<body>

	<script src="<%=root%>/static/js/highcharts.js"></script>
	<script src="<%=root%>/static/js/modules/exporting.js"></script>
	<div id="container" style="min-width: 310px; height: 400px;"></div>

	<div class="panel-body">
		<table id="myTable">

		</table>
	</div>
	<div id="svgdiv"></div>

</body>
</html>