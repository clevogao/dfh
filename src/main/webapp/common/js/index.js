$(function(){
	Expand.init();
});

function a(){
	if(re){
		chart=kpi();
	}
}
var chart;//heightcharts对象
var re=true;//图标开关

function kpi(){
	var c;
	setTimeout(function(){
		c=$('#report_kpi').highcharts({
			chart:{
				reflow:true
			},
	        title: {
	            text: '成本统计',
	            x: -20 //center
	        },
	        subtitle: {
	            text: '大区',
	            x: -20
	        },
	        xAxis: {
	            categories: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
	                'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec']
	        },
	        yAxis: {
	            title: {
	                text: 'Temperature (°C)'
	            },
	            plotLines: [{
	                value: 0,
	                width: 1,
	                color: '#808080'
	            }]
	        },
	        tooltip: {
	            valueSuffix: '°C'
	        },
	        legend: {
	            layout: 'vertical',
	            align: 'right',
	            verticalAlign: 'middle',
	            borderWidth: 0
	        },
	        series: [{
	            name: 'Tokyo',
	            data: [7.0, 6.9, 9.5, 14.5, 18.2, 21.5, 25.2, 26.5, 23.3, 18.3, 13.9, 9.6]
	        }, {
	            name: 'New York',
	            data: [-0.2, 0.8, 5.7, 11.3, 17.0, 22.0, 24.8, 24.1, 20.1, 14.1, 8.6, 2.5]
	        }, {
	            name: 'Berlin',
	            data: [-0.9, 0.6, 3.5, 8.4, 13.5, 17.0, 18.6, 17.9, 14.3, 9.0, 3.9, 1.0]
	        }, {
	            name: 'London',
	            data: [3.9, 4.2, 5.7, 8.5, 11.9, 15.2, 17.0, 16.6, 14.2, 10.3, 6.6, 4.8]
	        }]
	    });
	}, 500);
	return c;
}
var Expand = function () {
	var tile = $('.strips__strip');
	var tileLink = $('.strips__strip > .strip__content');
	var tileText = tileLink.find('.strip__inner-text');
	var stripClose = $('.strip__close');
	var expanded = false;
	var open = function () {
		var tile = $(this).parent();
		if (!expanded) {
			tile.addClass('strips__strip--expanded');
			tileText.css('transition', 'all .6s 1s cubic-bezier(0.23, 1, 0.32, 1)');
			stripClose.addClass('strip__close--show');
			stripClose.css('transition', 'all .6s 1s cubic-bezier(0.23, 1, 0.32, 1)');
			expanded = true;
			re=false;
		}
	};
	var close = function () {
		if (expanded) {
			tile.removeClass('strips__strip--expanded');
			tileText.css('transition', 'all 0.15s 0 cubic-bezier(0.23, 1, 0.32, 1)');
			stripClose.removeClass('strip__close--show');
			stripClose.css('transition', 'all 0.2s 0s cubic-bezier(0.23, 1, 0.32, 1)');
			expanded = false;
			re=true;
		}
	};
	var bindActions = function () {
		tileLink.on('click', open);
		stripClose.on('click', close);
	};
	var init = function () {
		bindActions();
	};
	return { init: init };
}();