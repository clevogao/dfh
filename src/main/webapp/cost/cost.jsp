<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>成本</title>
</head>
<body>
	<div>
		<div></div>

		<div>
			<div>
				<input id="zd" type="radio" name="butype" value="0" />直达 &nbsp; <input
					id="wl" type="radio" name="butype" value="1" />物流
			</div>
			<div>
				<input id="allCost" type="button" value="总成本" /> <input
					id="singleCost" type="button" value="单均成本" /><br> <input
					id="cargoUserCost" type="button" value="货主成本" /> <input
					id="truckUserCost" type="button" value="司机成本" />
			</div>
		</div>

		<div></div>
	</div>
</body>
</html>