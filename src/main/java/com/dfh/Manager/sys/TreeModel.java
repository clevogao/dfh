package com.dfh.Manager.sys;
import java.io.Serializable;
import java.util.List;

/**
 * ClassName: TreeModel
 * Description: 菜单
 * Author: gaojiawei
 * Date: 2015年11月27日
 */
public class TreeModel implements Serializable{
	
	/**
	 *Created by gaojiawei 2015年12月2日
	 */
	private static final long serialVersionUID = 7919126745884303636L;

	public String text;
	
	public String icon;
	
	public String href;
	public String id;
	
	public List<TreeModel> nodes;

	public TreeModel(){
		
	}
	
	/**
	 * 定义tree格式.
	 *
	 * @param txt the txt
	 * @param type the type
	 * @param id the id
	 */
	public TreeModel(String txt,Integer type,int id,Object url){
		if (type == 2) {
			text=txt+"&nbsp;&nbsp;<span title='编辑' id='editRes"+id+"' onclick='editRes(\""+id+"\")' class='glyphicon glyphicon-edit  iconWhite'></span> &nbsp;</span>";
			text=text+"&nbsp;&nbsp;<span title='删除' id='delRes"+id+"' onclick='delRes(\""+id+"\")' class='glyphicon glyphicon-minus-sign  iconWhite'></span> &nbsp;</span>";
			icon="fa fa-circle";
			this.id=String.valueOf(id);
			this.href=url==null?"":url.toString();
		} else if (type == 1) {
			text=txt+"&nbsp;&nbsp;<span title='添加' id='addRes"+id+"' onclick='addRes(\""+id+"\")' class='glyphicon glyphicon-plus-sign  iconWhite'></span> &nbsp;</span>";
			text=text+"&nbsp;&nbsp;<span title='编辑' id='editRes"+id+"' onclick='editRes(\""+id+"\")' class='glyphicon glyphicon-edit  iconWhite'></span> &nbsp;</span>";
			text=text+"&nbsp;&nbsp;<span title='删除' id='delRes"+id+"' onclick='delRes(\""+id+"\")' class='glyphicon glyphicon-minus-sign  iconWhite'></span> &nbsp;</span>";
			icon="glyphicon glyphicon-th-list";
			this.id=String.valueOf(id);
			this.href=url==null?"":url.toString();
		} else {
			text=txt;
			icon="glyphicon glyphicon-euro";
			this.id=String.valueOf(id);
		}
	}
	
	public String getText() {
		return text;
	}

	public void setText(String text) {
		this.text = text;
	}


	public String getHref() {
		return href;
	}

	public void setHref(String href) {
		this.href = href;
	}

	public List<TreeModel> getNodes() {
		return nodes;
	}

	public void setNodes(List<TreeModel> nodes) {
		this.nodes = nodes;
	}
	
	public String getIcon() {
		return icon;
	}
	public void setIcon(String icon) {
		this.icon = icon;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}
}
