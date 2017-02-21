var tableWin = new Object();
+function($) {
	$.fn.extend(tableWin,{
					loadTable : function(tableId, url, columns, propertys) {
							if(!propertys.smallFild){
								$.each(columns,function(i,o) {   
									o.formatter=function(val){
										if(val){
											if(val.length>7){
												return '<span title="'+val+'">'+val.substring(0,5)+'..</span>';
											}else{
												return '<span title="'+val+'">'+val+'</span>';
											}
										}else{
											return val;
										}
									}
								});
							}
							tableWin.resField(columns);//字段格式化
							var property = {
								method : 'post',
								url : root + "/" + url,
								cache : false,
								//height : 440,
								striped : true,
								pagination : false,
								contentType: "application/x-www-form-urlencoded;charset=utf-8",
								dataType: "json",
								sidePagination: "client",
								//sidePagination: "server",
								pageSize : 10,
								pageList : [10,20,30,40,50],
								showColumns : false,
								showRefresh : false,
								minimumCountColumns : 2,
								showToggle : false,
								clickToSelect : true,
								silentSort:true,
								hover : true,
								idField : "_id",
								columns : columns,
								toolbarAlign : "right",
								queryParams:function(p){
									$.each($("#myForme").serializeArray(),function(i,o) {   //表单参数自动提交查询
										eval("p."+o.name+" = "+"'"+o.value+"'");
									});
									if(tableWin.search){//查询方法额外触发方法
										tableWin.search();
									}
									//console.log($.extend(p, eval($("#myForme").serialize())));
									return p;
								}
							};
							property = $.extend(property, propertys);
							var myTable=$('#' + tableId).bootstrapTable(property)
							$(window).resize(function() {
								$('#' + tableId).bootstrapTable('resetView');
							});
						 return myTable;
						},
						loadTool : function(columns) {
							var tooldiv=$(".columns");
							$.each(columns,function(i,o) {
								tooldiv.append('<button onclick="'+o.funName+'()" class="btn btn-default" type="button"  title="'+o.title+'">'+
										'<i class="'+o.icon+'"></i></button>');
							});
						},
						loadSearch : function(columns,propertys) {//size只能 : 2,3,4  必须在table之前
							var showtime = false;
							var labelClass="col-sm-1";
							var inputClass="col-sm-2";
							var property={
									tableId:'myTable',
									formId:'myForme',
									size:4
							}
							property = $.extend(property, propertys);
							var $group = $('<div class="form-group" style="font-size: 12px;"></div>');
							var botton ='<div style="float: right;margin-right: 9px"><div onclick="table_search(\''+property.tableId + '\',\''
							+ property.formId + '\')" class="btn btn-default"><i class="glyphicon glyphicon-search"></i> 查询</div></div>';
							if(property.dataExport){
								//botton+='<div style="float: right;margin-right: 9px"><div onclick="'+property.dataExport.onclick+'" class="btn btn-default"><i class=" icon-upload-alt"></i> 导出</div></div>';
								botton+='<div style="float: right;margin-right: 9px"><div onclick="data_export(\''+property.dataExport.url + '\',\''
								+ property.formId + '\')" class="btn btn-default"><i class=" icon-upload-alt"></i> 导出</div></div>';
							}
							if(!property.reset){//重置
								//botton+='<div style="float: right;margin-right: 9px"><div onclick="'+property.dataExport.onclick+'" class="btn btn-default"><i class=" icon-upload-alt"></i> 导出</div></div>';
								botton+='<div style="float: right;margin-right: 9px"><div onclick="tableWin.reset(\''
								+ property.formId + '\')" class="btn btn-default"><i class="icon-circle-blank"></i> 重置</div></div>';
							}
							var size =property.size;
							if(size==2){
								labelClass="col-sm-1";
								inputClass="col-sm-3";
							}else if(size==3){
								labelClass="col-sm-1";
								inputClass="col-sm-3";
							}
							$.each(columns,function(i, o) {
								if (o.type == 'time') {
									$group.append('<label  class="'+labelClass+' control-label" readonly>' + o.title
													+ '</label>');
									var div = '<div class="'+inputClass+'"><div class="input-group">'
											+ '<input id="search_'
											+ o.field
											+ '" name="'
											+ o.field
											+ '"  type="text" class="form-control input-sm showtime" readonly onclick="" pplaceholder="选择时间..." aria-describedby="basic-addon1">'
											+ '<span class="input-group-addon" id="basic-addon1"><li class="icon-calendar" for="search_'+o.field+'"></li></span></div></div>';
									$group.append(div);
									showtime = true;
								}
								else if (o.type == 'select') {
									$group.append('<label  class="'+labelClass+' control-label">' + o.title + '</label>');
									$group.append('<div class="'+inputClass+'"><select  id="search_' + o.field + '" name="'
											+ o.field + '"  class="form-control input-sm selectpicker" ></select></div>');
								}else if(o.type == 'timedb'){//
									$group.append('<label  class="'+labelClass+' control-label" readonly>' + o.title
													+ '</label>');
									var div = '<div class="'+inputClass+'"><div class="input-group">'
											+ '<input id="search_'
											+ o.field+'_str'
											+ '" name="'
											+ o.field+'_str'
											+ '"  type="text" class="form-control input-sm showtime" readonly onclick="" pplaceholder="选择时间..." aria-describedby="basic-addon1">'
											+ '<span class="input-group-addon" id="basic-addon1">至</span>'
											+ '<input id="search_'
											+ o.field+'_end'
											+ '" name="'
											+ o.field+'_end'
											+ '"  type="text" class="form-control input-sm showtime" readonly onclick="" pplaceholder="选择时间..." aria-describedby="basic-addon1">'
											+'</div></div>';
									$group.append(div);
									showtime = true;
								}
								else {
									$group.append('<label  class="'+labelClass+' control-label">' + o.title + '</label>');
									$group.append('<div class="'+inputClass+'"><input type="text"  id="search_' + o.field + '" name="'
											+ o.field + '"  class="form-control input-sm"  placeholder="请输入..."></div>');
								}
								if(i%property.size==property.size-1){
									$("#" + property.formId).append($group);
									$group=$('<div class="form-group" style="font-size: 12px;"></div>');
								}
							});
							$group.append(botton);
							$("#" + property.formId).append($group);
							if (showtime) {
								$(".showtime").datetimepicker({
									format : 'yyyy-mm-dd hh:ii',
									//format : 'yyyy-mm-dd hh:ii:ss',
									autoclose : true,
									todayBtn : true,
									minuteStep: 5
								});
							}
							tableWin.loadSearchMaping(columns);
						},
						loadSearchValue:function(values){//下拉框获取值 [{filed:字段名称,url:true后台取值，返回参数为id和name,type:tree为树形选择,data:[{选择的值id,name}]}]
							$.each(values,function(i,o) {
								if(o.type=='tree'){
									
								}else{
									if(o.url){
										tableWin.ajaxHtmlToSelect(o.url,{},"search_"+o.filed);
									}else{
										var html="";
										$.each(o.data,function(j,d) {  
											if(d.id){
												if(d.id=="null"){
													html+=' <option  value="">'+d.name+'</option> ';
												}else{
													html+=' <option  value="'+d.id+'">'+d.name+'</option> ';
												}
											}else{
												html+=' <option  value="'+d.name+'">'+d.name+'</option> ';
											}
										});
										$("#search_"+o.filed).html(html);
									}
								}
							});
						},
						loadSearchMaping:function(columns){//下拉框获取值 [{filed:字段名称,url:true后台取值，返回参数为id和name,type:tree为树形选择,data:[{选择的值id,name}]}]
							$.each(columns,function(i,o) {
								if(o.data){
									var html="";
									$.each(eval(o.data.value),function(j,d) {
										if(d.id){
											if(d.id=="null"){
												html+=' <option  value="">'+d.name+'</option> ';
											}else{
												html+=' <option  value="'+d.id+'">'+d.name+'</option> ';
											}
										}else{
											html+=' <option  value="'+d.name+'">'+d.name+'</option> ';
										}
									});
									$("#search_"+o.field).html(html);
								}
							});
						},
						ajaxHtmlToSelect:function(url,data,selectid,all){//all false：没有不限
							$.ajax({
								type : "POST",
								url :getval("root")+"/"+url,
								async:false,
								data :data,
								contentType : 'application/x-www-form-urlencoded;charset=utf-8',
								success : function(data) {
									var html="";
									if(all){
										html+=' <option  value="">不限</option> ';
									}
									$.each(data,function(i,o) { 
										html+=' <option  value="'+o.id+'">'+o.name+'</option> ';
									});
									$("#"+selectid).html(html);
								}
							});

						},
						alert:function(msg){
							tableModel.alert("信息",msg);
						},
						parmToForm:function (tableId){//获取table的一行数据放入表单
							var id=tableId||'myTable';
							var data=$("#"+id).bootstrapTable('getSelections')[0];
								for(var name in data){
									if(eval('$("#'+name+'")').is('.selectpicker')){
										var ids=eval("data." + name)+'';
											$("#" + name).val(ids.split(','));  
									}else{
										$("#" + name).val(eval("data." + name));
									}
								}
								$('.selectpicker').selectpicker('render');
						},
						dataToForm:function(data){
								for(var name in data){
									$("#" + name).val(eval("data." + name));
									if(eval('$("#'+name+'")').is('.selectpicker')){
										var ids=eval("data." + name)+'';
											$("#" + name).val(ids.split(','));  
									}else{
										$("#" + name).val(eval("data." + name));
									}
							    }  
								$('.selectpicker').selectpicker('render');
						},
						reset:function(fromid){
							$("#"+fromid)[0].reset();
						},
						resField:function(columns){
							$.each(columns,function(i,o) {
								if(o){
								if(o.formatter){
									if(o.formatter=='percent:order'){
										o.formatter=function(val){
											if(val>0) return '<span style="color:red">'+(val*100).toFixed(2)+'%</span>';
											else if (val<0) return '<span style="color:green">'+(val*100).toFixed(2)+'%</span>';
										}
									}else if(o.formatter=='percent'){
										o.formatter=function(val){
											if(val>0) return (val*100).toFixed(2)+'%';
											else if (val<0) return (val*100).toFixed(2)+'%';
										}
									}else if(o.formatter=='second'){
										o.formatter=function(val){
											if(val){ 
												val=val.substring(6,11);
//												val='2016-01-01 '+val;
//												val = val.replace(/-/g,'/'); 
//												var timestamp = new Date(val).getTime();
//												return (timestamp-new Date('2016-01-01 00:00:00').getTime())/1000+'秒';
												return val+'秒';
											} else{
												return '-';
											}
										}
									}
								}else{
									o.formatter=function(val){
										return val;
									}
								}
								}
							});
						}
					})
}(jQuery);

function table_search(tableId, formId) {
	var tid=tableId||'myTable';
	var fid=formId||'myForme';
	//$('#'+tid).bootstrapTable('refresh',{url:$('#'+tid).bootstrapTable('geturl')+"?"+$("#" + fid).serialize()});
	$('#'+tid).bootstrapTable('refresh');
}
function data_export(url,formId){
	$("#" + formId).serialize();
	//alert(root+url+"?"+$("#" + formId).serialize());
	goUrl(root+"/"+url+"?"+$("#" + formId).serialize());
}


function toBreadcrumb(text1,text2,url){
	$("#breadcrumb1").show();
	$("#breadcrumb2").show();
	$("#breadcrumb1").html('<a  href="#">'+text1+'</a>');
	$("#breadcrumb2").text(text2);
	goiframe(root+url);
}



function loadmenu(menu, note) {
	$.each(note, function(i, o) {
		o.icon = o.icon || "glyphicon glyphicon-cog";
		if (o.notes == null) {
			menu.append('<li><a href="#" onclick="toBreadcrumb(\'' + o.text + '\',\'' + o.text + '\',\'' + o.url + '\')" ><i class="' + o.icon + '"></i><span class="menu-text">'
					+ o.text + '</span></a></li>')
		}
		else {
			var $li = $('<li ><a href="#" class="dropdown-toggle"><i class=\'' + o.icon + '\'></i><span class="menu-text">' + o.text
					+ '</span><b class="arrow icon-angle-down"></b></a>');
			var $ul = $('<ul class="submenu"></ul>');
			$.each(o.notes, function(j, n) {
				n.icon = n.icon || "glyphicon glyphicon-cog";
				$ul.append('<li><a href="#" onclick="toBreadcrumb(\'' + o.text + '\',\'' + n.text + '\',\'' + n.url + '\')" ><i class="icon-double-angle-right"></i>' + n.text
						+ '</a></li>');
			});
			$li.append($ul);
			menu.append($li);
		}
	});
}

/**
 * @param formObj 中间内容dom对象
 * @param property {funName:点击事件名称,btnName:按钮名称,parm:参数 ,class:样式(默认),id:myModal(默认),size:(modal-lg:大,默认:中,modal-sm 小)}
 */
function showModal(formObj,property){
	var myModal={id:'myModal',clas:'modal fade',btnName:'保存',parm:''};
	myModal = $.extend(myModal, property);
	var buttons = [
	              '<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>',
	              '<button id="'+myModal.id+'_btn" type="button" onclick="'+myModal.funName+'(\''+myModal.parm+'\')" class="btn btn-primary">'+myModal.btnName+'</button>'
	               ];
	if(property.appendBtn){
		buttons = buttons.concat(property.buttons);
	} else if(property.buttons){
		buttons = property.buttons
	}
	var btn_ele = "";
	for(var o in buttons){
		btn_ele += buttons[o];
	}
	var $modal=$('<div class="'+myModal.clas+'" id="'+myModal.id+'" tabindex="-1" role="dialog"> '+
			sprintf('<div class="modal-dialog %s">',myModal.size||'')+
			'	<div class="modal-content">                                                             '+
			'		<div class="modal-header">                                                          '+
			'			<button type="button" class="close" data-dismiss="modal"                        '+
			'				aria-label="Close">                                                         '+
			'				<span aria-hidden="true">&times;</span>                                     '+
			'			</button>                                                                       '+
			'			<h4 id="title_'+myModal.id+'" class="modal-title">'+myModal.title+'</h4>                     '+
			'		</div>                                                                              '+
			'		<div class="modal-body">                                                            '+
			'			                                                                                '+
			'		</div>                                                                              '+
			'		<div class="modal-footer">                                                          '+
			btn_ele + 
			'		</div>                                                                              '+
			'	</div>                                                                                  '+
			'</div>  </div>');        
	$modal.find(".modal-body").append(formObj);
	$("body").append($modal);
	return $modal;
}

var tableModel=new Object();

tableModel.html=' <div class="modal fade" tabindex="-1" ><div class="modal-dialog" style="height: 20px"> <div class="modal-content modal-sm %s"><div class="modal-header"> <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>'+
     '<h4 class="modal-title" ><i class="fa fa-info-circle"></i>  %s</h4>'+
     '</div> <div class="modal-body" style="font-size: 14px;text-align: center;">%s </div>'+
     '<div class="panel-footer" style="height: 40px">'+
     '<button type="button" class="btn btn-default pull-right" data-dismiss="modal" > 关  闭 </button> '+
     '<button type="button" class="btn btn-primary pull-right" data-dismiss="modal" onclick="tableModel.yes()" style="margin-right: 10px;%s"> 确  定 </button>'+
     '</div></div></div></div>';

$.fn.extend(tableModel,{
	yes:function(){
		
	},
	alert:function(title,msg,fun){
		var show=sprintf(tableModel.html,'modal-info',msg,title||'<li class=""></li>','');
		$("body").append(show);
		$(show).modal('show');
		tableModel.yes=fun;
	},
	error:function(title,msg){
		if(!title){
			title="提示";
		}
		var show=sprintf(tableModel.html,'modal-error',msg,title||'<li class=""></li>','display:none');
		$("body").append(show);
		$(show).modal('show');
	}
});

