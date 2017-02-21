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


<script type="text/javascript">
	 
	     var myModal;
		 var myTable;
		 var columns = [  {
				field : 'name',
				title : '名称',
				formatter:function(val,a,b){
					 return   '<a><span  onclick="c1(\''+val+'\')">'+val+'</span></a>';
				    
				    // return '<a href="echart1/detailforArea"> '+val +'</a>'; 
				    
				}
			}, { 
				field : 'date',
				title : '月对比量'
			}, { 
				field : 'report_date',
				title : '时间'
			} ]; 
		 $(function() {
				//初始化table
				 myTable=tableWin.loadTable('myTable', 'costMoothEchart/detail', columns,{singleSelect:true,smallFild:true});
				
			});
		//点击表格中的公司或者大区 触发这个事件， 
		 function c1(val){ 
			 if(val=='公司'){
				 $('#myTable').bootstrapTable('refresh',{url:'detailforCompany'});
					// setChart($('#myTable').bootstrapTable('getData'));
					 
			 			// myTable=tableWin.loadTable('myTable', 'echart1/detailforArea', columns,{singleSelect:true });
			 			   $.ajax({
			 				  url:root+'/costMoothEchart/detailforCompany', //发送请求的地址 当前页地址 /costCompare/detailForCompany'
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
			 				  url:root+'/costMoothEchart/detailforArea', //发送请求的地址 当前页地址
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
 
		 function setChart ( Data, name, partent_name,color)  {
				 
				 //各个大区的名称
				var name = new Array();	
				 //时间
				var  report_date= new Array();	
					
			  //获取从后天得到的值
				$.each(Data,function(i,obj){
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
			            categories: report_date,
			            title: {
			                text: ' '
			            },
			        },
			        yAxis: {
			            title: {
			                text: '订单量月对比'
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
					url:root+'/costMoothEchart/detail', //发送请求的地址 当前页地址
					type:'post',//请求方式
					data: { },
					datatype:'json',
					success:function(   data ){
						setChart(  data )
					},
					error:function(){
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
					setChart (Data, name, partent_name, color);
				};
				 function setChart ( Data, name, partent_name,color)  {
						
					   //每日的单量
					var cost_amount_moothaverage_compare= new Array(); 
					 //各个大区的名称
					var name = new Array();		
					var report_date= new Array();		
					 
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
				            categories: report_date,
				            title: {
				                text: ' '
				            },
				        },
				        yAxis: {
				            title: {
				                text: '订单量'
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
	<div id="container" style="min-width: 310px; height: 400px;"></div>
	<div class="panel-body">
		<table id="myTable">
		</table>
	</div>
</body>
</html>