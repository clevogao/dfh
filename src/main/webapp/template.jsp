<%@ page language="java" contentType="text/html; charset=UTF-8"
	import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>



<title>后台报表系统</title>
<meta content="no-cache" http-equiv="pragma" />
<meta content="no-cache, must-revalidate" http-equiv="Cache-Control" />
<meta content="0" http-equiv="expires" />
<meta content="IE=edge" http-equiv="X-UA-Compatible" />
<meta content="webkit" name="renderer" />

<!-- js方便获取根路径  根路径以/开头-->
</head>
<body>
	<input type="hidden" value="/report" id="root" />
	<!-- 样式 -->
	<link type="text/css" rel="stylesheet"
		href="/report/common/css/bootstrap.css?v=1.0" />
	
	<h1></h1>
	<div style="margin-bottom: 0px; font-size: 12;"
		class="panel panel-default">
		<div class="panel-body">
			<div class="bootstrap-table">
				<!-- 标题
				 <div class="fixed-table-toolbar">
					<div class="columns columns-right btn-group pull-right">
						<button title="刷新" name="refresh" type="button"
							class="btn btn-default">
							<i class="glyphicon glyphicon-refresh icon-refresh"></i>
						</button>
						<button title="切换" name="toggle" type="button"
							class="btn btn-default">
							<i class="glyphicon glyphicon-list-alt icon-list-alt"></i>
						</button>
						<div title="列" class="keep-open btn-group">
							<button data-toggle="dropdown"
								class="btn btn-default dropdown-toggle" type="button">
								<i class="glyphicon glyphicon-th icon-th"></i> <span
									class="caret"></span>
							</button>
							<ul role="menu" class="dropdown-menu">
								<li><label><input type="checkbox" checked="checked"
										value="0" data-field="cityname" /> 层级</label></li>
								<li><label><input type="checkbox" checked="checked"
										value="1" data-field="_day" /> 时间维度</label></li>
								<li><label><input type="checkbox" checked="checked"
										value="2" data-field="month_count" /> 本月成单累计</label></li>
								<li><label><input type="checkbox" checked="checked"
										value="3" data-field="target" /> 成单指标</label></li>
								<li><label><input type="checkbox" checked="checked"
										value="4" data-field="rank" /> 成单排名</label></li>
								<li><label><input type="checkbox" checked="checked"
										value="5" data-field="response_taketime_month" /> 接单响应时长（月）</label></li>
								<li><label><input type="checkbox" checked="checked"
										value="6" data-field="response_taketime_today" /> 接单响应时长（日）</label></li>
								<li><label><input type="checkbox" checked="checked"
										value="7" data-field="hcompared_percent" /> 成单环比</label></li>
								<li><label><input type="checkbox" checked="checked"
										value="8" data-field="tcompared_percent" /> 成单同比</label></li>
								<li><label><input type="checkbox" checked="checked"
										value="9" data-field="today_count" /> 今天成单累计</label></li>
								<li><label><input type="checkbox" checked="checked"
										value="10" data-field="success_percent_month" /> 成交率（月）</label></li>
								<li><label><input type="checkbox" checked="checked"
										value="11" data-field="payonline_percent_month" />
										在线支付订单占比（月）</label></li>
								<li><label><input type="checkbox" checked="checked"
										value="12" data-field="nonetruckuser_percent_month" />
										无人接单占比(月）</label></li>
								<li><label><input type="checkbox" checked="checked"
										value="13" data-field="success_percent_today" /> 成交率（日）</label></li>
								<li><label><input type="checkbox" checked="checked"
										value="14" data-field="payonline_percent_today" />
										在线支付订单占比（日）</label></li>
								<li><label><input type="checkbox" checked="checked"
										value="15" data-field="nonetruckuser_percent_today" />
										无人接单占比(日)</label></li>
							</ul>
						</div>
					</div>
				</div>
				 -->
				<div class="fixed-table-container" style="padding-bottom: 0px;">
					<div class="fixed-table-header" style="display: none;">
						<table></table>
					</div>
					<div class="fixed-table-body">
					
						<table id="myTable" class="table table-hover table-striped">
							<thead>
								<tr>
									<th style=""><div class="th-inner ">层级</div>
										<div class="fht-cell"></div></th>
									<th style=""><div class="th-inner ">时间维度</div>
										<div class="fht-cell"></div></th>
									<th style=""><div class="th-inner sortable both">本月成单累计</div>
										<div class="fht-cell"></div></th>
									<th style=""><div class="th-inner sortable both">成单指标</div>
										<div class="fht-cell"></div></th>
									<th style=""><div class="th-inner sortable both">成单排名</div>
										<div class="fht-cell"></div></th>
									<th style=""><div class="th-inner sortable both">接单响应时长（月）</div>
										<div class="fht-cell"></div></th>
									<th style=""><div class="th-inner sortable both">接单响应时长（日）</div>
										<div class="fht-cell"></div></th>
									<th style=""><div class="th-inner sortable both">成单环比</div>
										<div class="fht-cell"></div></th>
									<th style=""><div class="th-inner sortable both">成单同比</div>
										<div class="fht-cell"></div></th>
									<th style=""><div class="th-inner sortable both">今天成单累计</div>
										<div class="fht-cell"></div></th>
									<th style=""><div class="th-inner sortable both">成交率（月）</div>
										<div class="fht-cell"></div></th>
									<th style=""><div class="th-inner sortable both">在线支付订单占比（月）</div>
										<div class="fht-cell"></div></th>
									<th style=""><div class="th-inner sortable both">无人接单占比(月）</div>
										<div class="fht-cell"></div></th>
									<th style=""><div class="th-inner sortable both">成交率（日）</div>
										<div class="fht-cell"></div></th>
									<th style=""><div class="th-inner sortable both">在线支付订单占比（日）</div>
										<div class="fht-cell"></div></th>
									<th style=""><div class="th-inner sortable both">无人接单占比(日)</div>
										<div class="fht-cell"></div></th>
								</tr>
							</thead>
							<tbody>
								<tr data-index="0">
									<td style="">深圳市</td>
									<td style="">2016-01-03</td>
									<td style="">190</td>
									<td style="">1</td>
									<td style="">1</td>
									<td style="">37.21秒</td>
									<td style="">34.14秒</td>
									<td style=""><span style="color: red">47.06%</span></td>
									<td style="">-</td>
									<td style="">75</td>
									<td style="">37.48%</td>
									<td style="">31.05%</td>
									<td style="">8.88%</td>
									<td style="">40.54%</td>
									<td style="">33.33%</td>
									<td style="">4.32%</td>
								</tr>
								<tr data-index="1">
									<td style="">广州市</td>
									<td style="">2016-01-03</td>
									<td style="">171</td>
									<td style="">1</td>
									<td style="">2</td>
									<td style="">35.25秒</td>
									<td style="">33.39秒</td>
									<td style=""><span style="color: red">7.94%</span></td>
									<td style="">-</td>
									<td style="">68</td>
									<td style="">40.71%</td>
									<td style="">52.63%</td>
									<td style="">10.24%</td>
									<td style="">44.44%</td>
									<td style="">58.82%</td>
									<td style="">8.50%</td>
								</tr>
								<tr data-index="2">
									<td style="">上海市</td>
									<td style="">2016-01-03</td>
									<td style="">212</td>
									<td style="">1</td>
									<td style="">3</td>
									<td style="">30.57秒</td>
									<td style="">32.21秒</td>
									<td style=""><span style="color: green">-20.48%</span></td>
									<td style="">-</td>
									<td style="">66</td>
									<td style="">42.23%</td>
									<td style="">46.70%</td>
									<td style="">8.37%</td>
									<td style="">41.51%</td>
									<td style="">42.42%</td>
									<td style="">11.95%</td>
								</tr>
								<tr data-index="3">
									<td style="">北京市</td>
									<td style="">2016-01-03</td>
									<td style="">132</td>
									<td style="">1</td>
									<td style="">4</td>
									<td style="">34.83秒</td>
									<td style="">29.25秒</td>
									<td style=""><span style="color: red">13.64%</span></td>
									<td style="">-</td>
									<td style="">50</td>
									<td style="">36.67%</td>
									<td style="">37.12%</td>
									<td style="">12.50%</td>
									<td style="">45.45%</td>
									<td style="">36.00%</td>
									<td style="">12.73%</td>
								</tr>
								<tr data-index="4">
									<td style="">杭州市</td>
									<td style="">2016-01-03</td>
									<td style="">118</td>
									<td style="">1</td>
									<td style="">5</td>
									<td style="">30.17秒</td>
									<td style="">30.28秒</td>
									<td style=""><span style="color: red">23.53%</span></td>
									<td style="">-</td>
									<td style="">42</td>
									<td style="">47.20%</td>
									<td style="">30.51%</td>
									<td style="">11.60%</td>
									<td style="">48.84%</td>
									<td style="">30.95%</td>
									<td style="">6.98%</td>
								</tr>
								<tr data-index="5">
									<td style="">天津市</td>
									<td style="">2016-01-03</td>
									<td style="">109</td>
									<td style="">1</td>
									<td style="">6</td>
									<td style="">20.70秒</td>
									<td style="">22.41秒</td>
									<td style=""><span style="color: red">34.48%</span></td>
									<td style="">-</td>
									<td style="">39</td>
									<td style="">59.89%</td>
									<td style="">1.83%</td>
									<td style="">9.34%</td>
									<td style="">51.32%</td>
									<td style="">-</td>
									<td style="">9.21%</td>
								</tr>
								<tr data-index="6">
									<td style="">东莞市</td>
									<td style="">2016-01-03</td>
									<td style="">114</td>
									<td style="">1</td>
									<td style="">7</td>
									<td style="">19.88秒</td>
									<td style="">19.88秒</td>
									<td style=""><span style="color: red">22.22%</span></td>
									<td style="">-</td>
									<td style="">33</td>
									<td style="">64.41%</td>
									<td style="">4.39%</td>
									<td style="">6.21%</td>
									<td style="">75.00%</td>
									<td style="">3.03%</td>
									<td style="">-</td>
								</tr>
								<tr data-index="7">
									<td style="">南京市</td>
									<td style="">2016-01-03</td>
									<td style="">72</td>
									<td style="">1</td>
									<td style="">8</td>
									<td style="">26.58秒</td>
									<td style="">25.51秒</td>
									<td style=""><span style="color: red">21.74%</span></td>
									<td style="">-</td>
									<td style="">28</td>
									<td style="">51.43%</td>
									<td style="">2.78%</td>
									<td style="">10.00%</td>
									<td style="">57.14%</td>
									<td style="">7.14%</td>
									<td style="">-</td>
								</tr>
								<tr data-index="8">
									<td style="">西安市</td>
									<td style="">2016-01-03</td>
									<td style="">69</td>
									<td style="">1</td>
									<td style="">9</td>
									<td style="">34.14秒</td>
									<td style="">34.38秒</td>
									<td style=""><span style="color: red">16.67%</span></td>
									<td style="">-</td>
									<td style="">28</td>
									<td style="">33.66%</td>
									<td style="">33.33%</td>
									<td style="">4.39%</td>
									<td style="">35.44%</td>
									<td style="">25.00%</td>
									<td style="">3.80%</td>
								</tr>
								<tr data-index="9">
									<td style="">武汉市</td>
									<td style="">2016-01-03</td>
									<td style="">72</td>
									<td style="">1</td>
									<td style="">10</td>
									<td style="">29.91秒</td>
									<td style="">35.05秒</td>
									<td style=""><span style="color: red">8.33%</span></td>
									<td style="">-</td>
									<td style="">26</td>
									<td style="">46.45%</td>
									<td style="">2.78%</td>
									<td style="">7.74%</td>
									<td style="">38.24%</td>
									<td style="">-</td>
									<td style="">5.88%</td>
								</tr>
								<tr data-index="10">
									<td style="">济南市</td>
									<td style="">2016-01-03</td>
									<td style="">68</td>
									<td style="">1</td>
									<td style="">11</td>
									<td style="">26.52秒</td>
									<td style="">27.55秒</td>
									<td style="">-</td>
									<td style="">-</td>
									<td style="">23</td>
									<td style="">65.38%</td>
									<td style="">1.47%</td>
									<td style="">1.92%</td>
									<td style="">57.50%</td>
									<td style="">4.35%</td>
									<td style="">-</td>
								</tr>
								<tr data-index="11">
									<td style="">佛山市</td>
									<td style="">2016-01-03</td>
									<td style="">71</td>
									<td style="">1</td>
									<td style="">12</td>
									<td style="">22.73秒</td>
									<td style="">19.61秒</td>
									<td style=""><span style="color: red">4.55%</span></td>
									<td style="">-</td>
									<td style="">23</td>
									<td style="">52.99%</td>
									<td style="">9.86%</td>
									<td style="">15.67%</td>
									<td style="">56.10%</td>
									<td style="">8.70%</td>
									<td style="">17.07%</td>
								</tr>
								<tr data-index="12">
									<td style="">成都市</td>
									<td style="">2016-01-03</td>
									<td style="">76</td>
									<td style="">1</td>
									<td style="">13</td>
									<td style="">29.07秒</td>
									<td style="">32.06秒</td>
									<td style=""><span style="color: green">-17.86%</span></td>
									<td style="">-</td>
									<td style="">23</td>
									<td style="">37.81%</td>
									<td style="">34.21%</td>
									<td style="">10.95%</td>
									<td style="">38.98%</td>
									<td style="">26.09%</td>
									<td style="">5.08%</td>
								</tr>
								<tr data-index="13">
									<td style="">中山市</td>
									<td style="">2016-01-03</td>
									<td style="">52</td>
									<td style="">1</td>
									<td style="">14</td>
									<td style="">24.85秒</td>
									<td style="">28.04秒</td>
									<td style=""><span style="color: red">15.79%</span></td>
									<td style="">-</td>
									<td style="">22</td>
									<td style="">55.91%</td>
									<td style="">11.54%</td>
									<td style="">8.60%</td>
									<td style="">55.00%</td>
									<td style="">13.64%</td>
									<td style="">5.00%</td>
								</tr>
								<tr data-index="14">
									<td style="">宁波市</td>
									<td style="">2016-01-03</td>
									<td style="">36</td>
									<td style="">1</td>
									<td style="">15</td>
									<td style="">36.04秒</td>
									<td style="">28.11秒</td>
									<td style=""><span style="color: green">-14.29%</span></td>
									<td style="">-</td>
									<td style="">12</td>
									<td style="">33.96%</td>
									<td style="">19.44%</td>
									<td style="">12.26%</td>
									<td style="">31.58%</td>
									<td style="">33.33%</td>
									<td style="">23.68%</td>
								</tr>
								<tr data-index="15">
									<td style="">郑州市</td>
									<td style="">2016-01-03</td>
									<td style="">30</td>
									<td style="">1</td>
									<td style="">16</td>
									<td style="">26.79秒</td>
									<td style="">36.74秒</td>
									<td style=""><span style="color: red">80.00%</span></td>
									<td style="">-</td>
									<td style="">9</td>
									<td style="">44.12%</td>
									<td style="">6.67%</td>
									<td style="">8.82%</td>
									<td style="">40.91%</td>
									<td style="">11.11%</td>
									<td style="">-</td>
								</tr>
								<tr data-index="16">
									<td style="">苏州市</td>
									<td style="">2016-01-03</td>
									<td style="">15</td>
									<td style="">1</td>
									<td style="">17</td>
									<td style="">37.35秒</td>
									<td style="">49.25秒</td>
									<td style=""><span style="color: green">-25.00%</span></td>
									<td style="">-</td>
									<td style="">3</td>
									<td style="">41.67%</td>
									<td style="">33.33%</td>
									<td style="">2.78%</td>
									<td style="">27.27%</td>
									<td style="">33.33%</td>
									<td style="">9.09%</td>
								</tr>
								<tr data-index="17">
									<td style="">其他</td>
									<td style="">2016-01-03</td>
									<td style="">6</td>
									<td style="">1</td>
									<td style="">18</td>
									<td style="">44.08秒</td>
									<td style="">58.84秒</td>
									<td style="">-</td>
									<td style="">-</td>
									<td style="">2</td>
									<td style="">20.00%</td>
									<td style="">83.33%</td>
									<td style="">26.67%</td>
									<td style="">18.18%</td>
									<td style="">50.00%</td>
									<td style="">18.18%</td>
								</tr>
							</tbody>
						</table>
					</div>
					<div class="fixed-table-footer" style="display: none;">
						<table>
							<tbody>
								<tr></tr>
							</tbody>
						</table>
					</div>
					<div class="fixed-table-pagination" style="display: none;"></div>
				</div>
			</div>
			<div class="clearfix"></div>
		</div>
	</div>

</body>
</html>