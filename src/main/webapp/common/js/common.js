commonJs = {
		treeView:function(options){
			if(!options.elementId){
				throw "elementId undefined!";
			}
			
			var treeObj = $("#" + options.elementId).tree({
				multiSelect:options.multiSelect,//允许多选
				cacheItems:options.cacheItems,//缓存子节点
				folderSelect:options.folderSelect,//允许选择父节点
				dataSource:function(parentData,callback){
						if(options.async){
							$.post(options.url,{id:parentData.attr?parentData.attr.id:0},function(r){
								callback(JSON.parse(r));
							});
						} else {
							var data = options.data;
							if(parentData.attr && parentData.attr.hasChildren){
								data = {data:parentData.attr.childrenItems};
							}
							callback(data);
						}
					}
			});
			treeObj.on('selected.fu.tree',options.onSelected);
			treeObj.on('deselected.fu.tree',options.onDeSelected);
			treeObj.on('loaded.fu.tree',options.onLoaded);
			treeObj.on('updated.fu.tree',options.onUpdate);
			treeObj.on('disclosedFolder.fu.tree',options.onDisclosedFolder);
			treeObj.on('closed.fu.tree',options.onClosed);
			return {
				selectedItems:function(selected){
					return treeObj.tree('selectedItems');
				}
			};
		}
};
//usage
/*commonJs.treeView({
	elementId:"#treeDemo",
	async:false,
	data:{},
	url:"",
	multiSelect:false,
	folderSelect:true,
	onSelected:function(){
		
	},
	onDeSelected:function(){
		
	},
	onLoaded:function(){
		
	},
	onUpdate:function(){
		
	},
	onDisclosedFolder:function(){
		
	},
	onClosed:function(){
		
	}
});*/