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
<script type="text/javascript">
	 //请求的时候改变这个值，用来做请求的路径
	 var tiaozhuanurl="/costCompare/detailForCompany";
	 var tiaozhuanAreaUrl='/costCompare/detailForArea';
	 
	 var myModal;
	 var myTable;
	 var columns = [  {
			field : 'name',
			title : '名称',
			formatter:function(val,a,b){
				//点击表格上的字 出发onclick c1事件 
				 return   '<a><span  onclick="c1(\''+val+'\')">'+val+'</span></a>'; 
			    
			    // return '<a href="echart1/detailforArea"> '+val +'</a>'; 
			    
			}
		}, { 
			field : 'date',//后台得到的数据在表格上显示 
			title : '月对比量'
		}, { 
			field : 'report_date',//后台的时间数据 在表格上显示 
			title : '时间'
		} ];
	 ////初始化table
	 $(function() {
			//初始化table
			 myTable=tableWin.loadTable('myTable', 'costCompare/detail', columns,{singleSelect:true,smallFild:true});
			
		});  
		 
	 	//点击表格中的公司或者大区 触发这个事件， 
		 function c1(val){ 
			 if(val=='公司'){
				 $('#myTable').bootstrapTable('refresh',{url:'detailForCompany'});
					// setChart($('#myTable').bootstrapTable('getData'));
					 
			 			// myTable=tableWin.loadTable('myTable', 'echart1/detailforArea', columns,{singleSelect:true });
			 			   $.ajax({
							url: root+tiaozhuanurl, //发送请求的地址 当前页地址 /costCompare/detailForCompany'
							type:'post',//请求方式
							data: {val:val},
							datatype:'json',
							success:function(data){
								setChart(data)
							},
							error:function(){
								alert('对不起，失败了!');
							}
						}); 
			 }else{
				// $('#myTable').bootstrapTable('refresh',{url:'costCompare/detailForCompany'});
					// setChart($('#myTable').bootstrapTable('getData'));
			 			   $.ajax({
							url:root+tiaozhuanAreaUrl, //发送请求的地址 当前页地址
							type:'post',//请求方式
							data: {val:val},
							datatype:'json',
							success:function(data){
								setChart(data)
							},
							error:function(){
								alert('对不起，失败了!');
							}
						});  
			 }
				   
			  
	 			 
	 		} ; 
	 		//订单视图
	 		function dingdanFun(){
	 			 $('#myTable').bootstrapTable('refresh',{url:'../echart/detail'});
	 		}
	 		//日对比量   初始化表格和图表
	 		function riFun(){
	 			 //请求的时候改变这个值，用来做请求的路径
	 			  tiaozhuanurl="/echartRing/detailForCompany";
	 			 tiaozhuanAreaUrl='/echartRing/detailForArea';
	 			 $('#myTable').bootstrapTable('refresh',{url:'../echartRing/detail'});
	 			 $.ajax({
					url: root+'/echartRing/detail', //发送请求的地址 当前页地址
					type:'post',//请求方式
					data: { },
					datatype:'json',
					success:function(   data ){
						setChart1(  data )
					},
					error:function(){
						alert('对不起，失败了!');
					}
				});
	 		}	
	  
	 		//月对比量yueFun  初始化表格和图表
	 		function yueFun(){
	 			 //请求的时候改变这个值，用来做请求的路径
	 			  tiaozhuanurl="/costMoothEchart/detailforCompany";
	 			  tiaozhuanAreaUrl='/costMoothEchart/detailforArea';
	 			 $('#myTable').bootstrapTable('refresh',{url:'../costMoothEchart/detail'});
	 			 $.ajax({
					url: root+'/costMoothEchart/detail', //发送请求的地址 当前页地址
					type:'post',//请求方式
					data: { },
					datatype:'json',
					success:function(   data ){
						setChart1(  data )
					},
					error:function(){
						alert('对不起，失败了!');
					}
				});
	 		}	
	 		//成本对比量chengbenFun  初始化表格和图表
	 		function chengbenFun(){
	 			//请求的时候改变这个值，用来做请求的路径
	 			  tiaozhuanurl="/costCompare/detailForCompany";
	 			  tiaozhuanAreaUrl='/costCompare/detailForArea';
	 			 $('#myTable').bootstrapTable('refresh',{url:'../costCompare/detail'});
	 			 $.ajax({
					url: root+'/costCompare/detail', //发送请求的地址 当前页地址
					type:'post',//请求方式
					data: { },
					datatype:'json',
					success:function(   data ){
						setChart1(  data )
					},
					error:function(){
						alert('对不起，失败了!');
					}
				});
	 		}	
	 		//点击各个按钮时初始化第一个的图表 （公司的） 
	 		function setChart1 ( Data, name, partent_name,color)  {
				
				   //每日的单量
				var cost_amount_moothaverage_compare= new Array(); 
				 //各个大区的名称
				var name = new Array();		
				 
				var report_date = new Array();		
				 //获取从后天得到的值
				$.each(Data,function(i,obj){
					cost_amount_moothaverage_compare.push(obj.date);
					name.push(obj.organize);
					report_date.push(obj.report_date);
				});  
					 
				//封装各个大区里面具体的城市和城市单量的信息（给按钮用的）
			    $('#container').highcharts({
			    	legend: {
			            data:['单量','票量','票均量']
			        },
			    	 
			        title: {
			            text: "",
			        },
			        xAxis: {
			        	 showFirstLabel:false,//在x轴或y轴设置一个
			        	
			            categories: report_date,
			            title: {
			                text: ' '
			            },
			        },
			        axisLine : {onZero: true},
			        yAxis: {
			            title: {
			                text: ' '
			            },
			           
			        },
			        plotOptions: {
			            column: {
			                cursor: 'pointer',
			                pointWidth:35, //柱子的宽度
			                point: {
			                    events: {
			                        click: function() {
			                            var drilldown = this.drilldown;
			                            if (drilldown) { // drill down
			                                setChart1(drilldown.name, drilldown.categories, drilldown.data, drilldown.color);
			                            } else { // restore
			                            	var categories;
			                            	var name;
			                            	var data;
			                                setChart1(Data, name, partent_name);
			                            }
			                        }
			                    }
			                },
			                dataLabels: {
			                    enabled: true,
			                    
			                    style: {
			                        fontWeight: 'bold'
			                    },
			                    formatter: function() {
			                        return this.y +'';
			                    }
			                }
			            }
			        },
			        series: [  {
			        	name:'公司',
			            data: cost_amount_moothaverage_compare
			        }  ]
			    });
			    
			     
			};
		 function setChart ( Data, name, partent_name,color)  {
				 //各个大区的名称
				var name = new Array();	
				 //时间
				var report_date = new Array();	
				  //获取从后台得到的时间的值
				$.each(Data,function(i,obj){
					 report_date.push(obj.report_date);
					 
				});   
				  
				//封装各个大区里面具体的城市和城市单量的信息
			
				
			    $('#container').highcharts({
			        title: {
			            text: "",
			        },
			        xAxis: {
			            categories: report_date,
			            title: {
			                text: ' '
			            },
			        },
			        yAxis: {
			            title: {
			                text: ''
			            },
			           
			        },
			        plotOptions: {
			            column: {
			                cursor: 'pointer',
			                point: {
			                    events: {
			                        click: function() {
			                            var drilldown = this.drilldown;
			                            if (drilldown) { // drill down
			                                setChart(drilldown.name, drilldown.categories, drilldown.data, drilldown.color);
			                            } else { // restore
			                            	var categories;
			                            	var name;
			                            	var data;
			                                setChart(Data, name, partent_name);
			                            }
			                        }
			                    }
			                },
			                dataLabels: {
			                    enabled: true,
			                    
			                    style: {
			                        fontWeight: 'bold'
			                    },
			                    formatter: function() {
			                        return this.y +'';
			                    }
			                }
			            }
			        },
			        
			        series: Data
			    });
			    
			     
			};
			 
	 		
	 		 
	 		          
        $(function () {
			
			 var colors = Highcharts.getOptions().colors;
			 var name;
				 

				$.ajax({
					url: root+'/costCompare/detail', //发送请求的地址 当前页地址
					type:'post',//请求方式
					data: { },
					datatype:'json',
					success:function(   data ){
						setChart1(  data )
					},
					error:function(){
						alert('对不起，失败了!');
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
					setChart1 (Data, name, partent_name, color);
				};
				 function setChart1 ( Data, name, partent_name,color)  {
						
					   //每日的单量
					var cost_amount_moothaverage_compare= new Array(); 
					 //各个大区的名称
					var name = new Array();		
					 
					var report_date = new Array();		
					 //获取从后天得到的值
					$.each(Data,function(i,obj){
						cost_amount_moothaverage_compare.push(obj.date);
						name.push(obj.organize);
						report_date.push(obj.report_date);
					});  
						 
					//封装各个大区里面具体的城市和城市单量的信息
				
					
				    $('#container').highcharts({
				    	legend: {
				            data:['单量','票量','票均量']
				        },
				    	 
				        title: {
				            text: "",
				        },
				        xAxis: {
				        	min:0,
				        	x:0,
				            categories: report_date,
				            title: {
				                text: ' '
				            },
				        },
				        axisLine : {onZero: true},
				        yAxis: {
				            title: {
				                text: ' '
				            },
				           
				        },
				        plotOptions: {
				            column: {
				                cursor: 'pointer',
				                pointWidth:35, //柱子的宽度
				                point: {
				                    events: {
				                        click: function() {
				                            var drilldown = this.drilldown;
				                            if (drilldown) { // drill down
				                                setChart1(drilldown.name, drilldown.categories, drilldown.data, drilldown.color);
				                            } else { // restore
				                            	var categories;
				                            	var name;
				                            	var data;
				                                setChart1(Data, name, partent_name);
				                            }
				                        }
				                    }
				                },
				                dataLabels: {
				                    enabled: true,
				                    
				                    style: {
				                        fontWeight: 'bold'
				                    },
				                    formatter: function() {
				                        return this.y +'';
				                    }
				                }
				            }
				        },
				        series: [  {
				        	name:'公司',
				            data: cost_amount_moothaverage_compare
				        }  ]
				    });
				};
        });
	</script>

<body>

	<script src="<%=root%>/static/js/highcharts.js"></script>
	<script src="<%=root%>/static/js/modules/exporting.js"></script>
	<div class="panel-body">
		<div class="panel panel-default" style="height: 100%; overflow: auto;">
			<div class="panel-heading">
				<i class="icon icon-tasks"></i> <strong>数据展现</strong>
				<div class="panel-actions pull-right">
					<!-- <button class="btn btn-primary btn-small" type="button" onclick="dingdanFun()">订单视图</button> -->
					<button class="btn btn-primary btn-small" type="button"
						onclick="riFun()">日对比量</button>
					<button class="btn btn-primary btn-small" type="button"
						onclick="yueFun()">月对比量</button>
					<button class="btn btn-primary btn-small" type="button"
						onclick="chengbenFun()">成本对比量</button>
				</div>
			</div>
			<!-- 加载图表 -->
			<div id="container" style="min-width: 310px; height: 400px;"></div>
			<!-- 加载表格 -->
			<div style="min-width: 310px; height: 200px;">
				<table id="myTable" align="center">
					<!-- style="width:80%;  "    -->
				</table>
			</div>
		</div>
	</div>

	</div>
</body>
</html>