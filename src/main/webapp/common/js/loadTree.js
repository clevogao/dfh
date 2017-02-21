function loadMenuView() {
	$.ajax({
		type : "POST",
		url : root + "/auth/getallmenu2",
		async : true,
		data : {},
		dataType : 'text',
		contentType : 'application/x-www-form-urlencoded;charset=utf-8',
		success : function(data) {
			$('#tree').treeview({
				data : data
			});
		}
	});
}


/**
 * 注:接收返回数据名为treefun
 * 
 * @param id
 * @param url
 * @param settings {onCheckForName:true 取值按名称,all:false 不显示全选}
 * @returns
 */

function loadSelectTree(id, url, settings) {
	var setting = {
		check : {
			enable : true,
			chkboxType : {
				"Y" : "",
				"N" : ""
			}
		},
		callback:{
			onCheck:function(){
				
			}
		},
		all:true
		};
	setting = $.extend(setting, settings);
	var onCheck = setting.callback.onCheck;
	setting.callback.onCheck = function(event, treeid, treeNode) {
		var treeObj = $.fn.zTree.getZTreeObj(treeid);
		var nodes = treeObj.getCheckedNodes(true);
		var ids = '';
		var titles = "";
		if (setting.onCheckForName) {
			$.each(nodes, function(i, node) {
				if (!nodes[i].isParent) {
					if(node.ID!="0"||node.ID!=0)
					{
					ids += node.NAME + ',';
					titles += node.NAME + ',';
					}
				}
			});
		}
		else {
			$.each(nodes, function(i, node) {
				if (!nodes[i].isParent) {
					if(node.ID!="0"||node.ID!=0)
					{
						ids += node.ID + ',';
						titles += node.NAME + ',';
					}
				}
			});
		}
		if (ids.length > 0) {
			ids = ids.substring(0, ids.length - 1);
			titles = titles.substring(0, titles.length - 1);
		}
		$("#" + id).val(ids);
		$("#" + id+"_name").val(titles);
		$("#" + id + "_span").text(titles);
		$("#" + id + "_title").attr("title", titles);
		onCheck(event, treeid, treeNode);
	};
	var html = '<div class="btn-group bootstrap-select form-control ">' + '<button id="' + id
			+ '_title" title="" type="button" class="btn dropdown-toggle  btn-default" data-toggle="dropdown">' + '<span id="' + id
			+ '_span" class="filter-option pull-left"></span>&nbsp;<span class="caret"></span>' + '</button>'
			+ '<div style="max-height:320px; overflow: hidden; min-height: 92px; " class="dropdown-menu tree-menu">' + '<ul id="' + id
			+ '_tree" class="ztree" style="margin-top:0;height:310px;overflow: auto;"></ul>' + '</div></div>';
	$("#" + id).parent().append(html);
	$("#" + id).hide();
	$('.tree-menu').click(function(e) {
		e.stopPropagation();
	});
	var objtree = loadTree(url, id + "_tree", setting);
	return objtree;
}

/**
 * 注:接收返回数据名为treefun
 * 
 * @param url
 *            访问连接
 * @param treeid
 *            treeid
 * @param settings
 */
function loadTree(url, treeid, settings) {
	var setting = {
		check : {
			enable : false
		},
		view : {
			dblClickExpand : false,
			showLine : true,
			selectedMulti : false
		},
		data : {
			simpleData : {
				enable : true,
				idKey : "ID",
				pIdKey : "PID",

			},
			key : {
				name : "NAME",
				url : "url",
				title : "NAME"
			}
		},
		all:true
	};
	setting = $.extend(setting, settings);
	if(typeof(url)== "string" ){
		var tree;
		$.ajax({
			type : "POST",
			url : root + url,
			async : false,
			data : {},
			dataType : 'text',
			contentType : 'application/x-www-form-urlencoded;charset=utf-8',
			success : function(data) {
				var zNodes = eval('(' + data + ')');
				if(setting.all){
					zNodes = new Array().concat({"id" : 0,"name" : "全选","pid" : 99999999}, zNodes)
				}
				tree = $.fn.zTree.init($("#" + treeid), setting, zNodes);
			}
		});
	}else{
		if(setting.all){
			url.push({
				"ID":0,
				"NAME":"全选",
				"PID":9999999
				})
		}
		tree=$.fn.zTree.init($("#" + treeid), setting, url);
	}
	if(setting.expandAll){
		tree.expandAll(true);
	}
	return tree;
}

function loadFunTree() {
	$.ajax({
		type : "POST",
		url : root + "/indexs/getmenu",
		async : true,
		data : {},
		dataType : 'text',
		contentType : 'application/x-www-form-urlencoded;charset=utf-8',
		success : function(data) {
			var zNodes = eval('(' + data + ')').treefun;
			$.fn.zTree.init($("#trees"), setting, zNodes);
		}
	});
}
/**
 * 选中data中的数据
 * @param treeid,data[] 
 * 数据（treeid字段对应,或者tree对象
 *  data为数组对象 列：[{ID:对比的id}]）
 *  checkTypeFlag :是否级联 省略为true 传0为false
 *  callbackFlag 是否回调 省略为true 传0为false
 *  setting {name:true按name选中}
 */
function checkAllTree(treeid, data,checkTypeFlag,callbackFlag,setting) {
	var set={
			checkType:true,
			callBack:true
	}
	set=$.extend(set, setting);
	var parm1=true;
	if(checkTypeFlag==0){
		parm1=false;
	}
	var parm2=true;
	if(callbackFlag==0){
		parm2=false;
	}
	var treeObj;
	//if(typeof(treeid)=='string'){
		treeObj = $.fn.zTree.getZTreeObj(treeid);
	//}else{
	//	treeObj=treeid;
	//}
	treeObj.checkAllNodes(false);
	var nodes = treeObj.transformToArray(treeObj.getNodes());
	if(set.name){
		var idKey = treeObj.setting.data.key.name;
		$.each(nodes, function(i, node) {
			$.each(data, function(j, d) {
				if (eval("node." + idKey) == eval("d." + idKey)) {
					treeObj.checkNode(node, true,parm1,parm2);
				}
			});
		});
	}else{
		var idKey = treeObj.setting.data.simpleData.idKey;
		$.each(nodes, function(i, node) {
			$.each(eval(data), function(j, d) {
				if (eval("node." + idKey) == eval("d." + idKey)) {
					treeObj.checkNode(node, true,false,false);
				}
			});
		});
	}
}
