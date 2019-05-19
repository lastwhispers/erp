$(function(){
	$('#grid').datagrid({
		url:'storeoper_listByPage',
		columns:[[
		  		    {field:'uuid',title:'编号',width:100},
		  		    {field:'empName',title:'操作员工编号',width:100},
		  		    {field:'opertime',title:'操作日期',width:100,formatter:formatDate},
		  		    {field:'storeName',title:'仓库编号',width:100},
		  		    {field:'goodsName',title:'商品编号',width:100},
		  		    {field:'num',title:'数量',width:100},
		  		    {field:'type',title:'类型',width:100,formatter:function(value){
		  		    	//1：入库 2：出库
		  		    	if(value * 1 == 1){
		  		    		return "入库";
		  		    	}
		  		    	if(value * 1 == 2){
		  		    		return "出库";
		  		    	}
		  		    }}
			]],
			singleSelect:true,
			pagination:true,
			fitColumns:true,
	});
	//点击查询按钮
	$('#btnSearch').bind('click',function(){
		//把表单数据转换成json对象
		var formData = $('#searchForm').serializeJSON();
		$('#grid').datagrid('load',formData);
	});
})

function formatDate(value){
	return new Date(value).Format('yyyy-MM-dd hh:mm:ss');
}