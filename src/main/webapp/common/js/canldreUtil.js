/**
 * 获取传日期的一周数组
 * 
 * @param date
 * @returns {dates{weeks:数组,now:当天}}
 */
function getWeekForDate(date) {
	var dates = {};
	var weeks = new Array([ 8 ]);
	var now = date; // 当前日期
	var nowDayOfWeek = now.getDay(); // 今天本周的第几天
	var nowDay = now.getDate(); // 当前日
	var nowMonth = now.getMonth(); // 当前月
	var nowYear = now.getYear(); // 当前年
	for (var i = 1; i <= 7; i++) {
		var weekStartDate = new Date(nowYear, nowMonth, nowDay - nowDayOfWeek + i);
		weeks[i - 1] = formatDate(weekStartDate);
	}
	dates.weeks = weeks;
	dates.now = nowDayOfWeek;
	return dates;
}

function formatDate(date) {
	var myyear = date.getFullYear();
	var mymonth = date.getMonth() + 1;
	var myweekday = date.getDate();
	if (mymonth < 10) {
		mymonth = "0" + mymonth;
	}
	if (myweekday < 10) {
		myweekday = "0" + myweekday;
	}
	return (myyear + "-" + mymonth + "-" + myweekday);
}