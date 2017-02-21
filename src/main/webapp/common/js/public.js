var root=$("#root").val();//项目根路径

/**
 * @param name
 * @returns url参数值
 */
 function getUrlParam(name) {
         var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)"); //构造一个含有目标参数的正则表达式对象
         var r = window.location.search.substr(1).match(reg);  //匹配目标参数
         if (r != null) return unescape(r[2]); return null; //返回参数值
     }

/**
 * 解决带参数跳转有乱码问题
 * @param url
 *@param type true：转码 
 */
function goUrl(url,type){
	if(type){
		location.href=encodeURI(encodeURI(url));
	}else{
		location.href=url;
	}
}
function fanhui(){
	history.go(-1);
}

/**
 * iframe跳转到指定url
 * @param url
 */
function goiframe(url){
	// $("#page-content").load(url);
	$("#iframe").attr("src",url);
}
/**
 * 
 * @param id
 * @returns 指定id值
 */
function getval(id){
	return $("#"+id).val();
}
/**
 * 触发点击事件
 * @param id
 */
function checkd(id){  
	$("#"+id).prop("checked", true);
}
function cheRadio(id){ 
	$("#che"+id).attr("checked", true);
	$("input[id^=cge]").attr("checked", false);
	
}


function addInfos(id,msg){
	("#"+id).addClass("has-error");
	$("#"+id).append('<label name="infos" class="control-label" >'+msg+'</label>');
}

function removeInfos(){
	$("label[name='infos']").remove();
}
function strToTime(time){
	return time.replace("-","").replace("-","").replace(" ","").replace(":","").replace(":","")*1;
}
/**
 * 字符串替换
 */
var sprintf = function (str) {
    var args = arguments,
        flag = true,
        i = 1;

    str = str.replace(/%s/g, function () {
        var arg = args[i++];

        if (typeof arg === 'undefined') {
            flag = false;
            return '';
        }
        return arg;
    });
    return flag ? str : '';
};


/**
 * 
 * @param url 访问controller
 * @param data 参数
 * @param selectid 下拉框id
 */
function ajaxHtmlToSelect(selectid,url,data){
	$.ajax({
		type : "POST",
		url :getval("root")+"/"+url,
		async:false,
		data :data,
		contentType : 'application/x-www-form-urlencoded;charset=utf-8',
		success : function(data) {
			var html="";
			$.each(data,function(i,o) {   
				html+=' <option  value="'+o.ID+'">'+o.NAME+'</option> ';
			});
			$("#"+selectid).html(html);
		}
	});

}

function ajaxFunction(url,data,func){
	$.ajax({
				type : "POST",
				url :getval("root")+"/"+url,
				async:false,
				data :data,
				dataType : 'text',
				contentType : 'application/x-www-form-urlencoded;charset=utf-8',
				success : func
			});
}
function ajaxFunctionAsyncTrue(url,data,func){
	$.ajax({
				type : "POST",
				url :getval("root")+"/"+url,
				async:true,
				data :data,
				dataType : 'text',
				contentType : 'application/x-www-form-urlencoded;charset=utf-8',
				success : func
			});
}


function newDate(AddDayCount){
	var date = new Date();
	if(AddDayCount){
		date.setDate(date.getDate()+AddDayCount);//获取AddDayCount天后的日期 
	}
	var y = date.getFullYear();
	var m = date.getMonth() + 1;
	var d = date.getDate();
	return y + '-' + (m < 10 ? ('0' + m) : m) + '-' + (d < 10 ? ('0' + d) : d);
}

	function newTime(){
		var date=new Date();
	return date.getHours() + ":" + date.getMinutes() + ":"
	+ date.getSeconds();
	}
	//刷新时间
	function freshAD() {
		var date = new Date();
		var y = date.getFullYear();
		var m = date.getMonth() + 1;
		var d = date.getDate();
		var strDate = y + '-' + (m < 10 ? ('0' + m) : m) + '-' + (d < 10 ? ('0' + d) : d)+ " " + date.getHours() + ":" + date.getMinutes() + ":"
		+ date.getSeconds();
		$("#newdate").html(strDate);
		setTimeout("freshAD()", 500);
	}

	//时间转换为时间戳
	function js_strto_time(str_time){
	    var new_str = str_time.replace(/:/g,'-');
	    new_str = new_str.replace(/ /g,'-');
	    var arr = new_str.split("-");
	    var datum = new Date(Date.UTC(arr[0],arr[1]-1,arr[2],arr[3]-8,arr[4],arr[5]));
	    return strtotime = datum.getTime();
	}
	//时间戳转换为时间
	function js_date_time(unixtime) {
	    var timestr = new Date(parseInt(unixtime) * 1000);
	    var datetime = timestr.toLocaleString().replace(/年|月/g, "-").replace(/日/g, " ");
	    return datetime;
	}

function CheckTime(s,n){
	var b=true;
	var msg="";
	if(s.length<13){
		if(n.length>13){
			s+="000000";
		}
	}
	if(n.length<13){
		if(s.length>13){
			n+="000000";
		}
	}
	if(n!=""&&s!=""){
		if(strToTime(n)<strToTime(s)){
			b=false,msg="结束时间请大于开始时间";
		}
	}else if(n!=""&&s==""){
		b=false,msg="请填写开始时间";
	}
	else if(n==""&&s!=""){
		b=false,msg="请填写结束时间";
	}
	return [b,msg];
}
