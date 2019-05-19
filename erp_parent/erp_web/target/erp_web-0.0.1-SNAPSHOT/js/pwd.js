$(function(){
	//加载表格数据
	$('#grid').datagrid({
		url:'emp_listByPage',
		columns:[[
		  		    {field:'uuid',title:'编号',width:100},
		  		    {field:'username',title:'登陆名',width:100},
		  		    {field:'name',title:'真实姓名',width:100},
		  		    {field:'gender',title:'性别',width:100,formatter:function(value, row, index){
		  		    	value = row.gender;
		  		    	if(1 == value * 1){
		  		    		return '男';
		  		    	}
		  		    	if(0 == value * 1){
		  		    		return '女';
		  		    	}
		  		    }},
		  		    {field:'email',title:'邮件地址',width:100},
		  		    {field:'tele',title:'联系电话',width:100},
		  		    {field:'address',title:'联系地址',width:100},
		  		    {field:'birthday',title:'出生年月日',width:100,formatter:function(value){
		  		    	return new Date(value).Format("yyyy-MM-dd");
		  		    }},
		  		    {field:'dep',title:'部门编号',width:100,formatter:function(value){
		  		    	return value.name;
		  		    }},

					{field:'-',title:'操作',width:200,formatter: function(value,row,index){
						var oper = "<a href=\"javascript:void(0)\" onclick=\"updatePwd_reset(" + row.uuid + ')">重置密码</a>';
						return oper;
					}}
					]],
		singleSelect: true,
		pagination: true
	});
	
	//重置密码的窗口
	$('#editDlg').dialog({
		title: '重置密码',//窗口标题
		width: 260,//窗口宽度
		height: 120,//窗口高度
		closed: true,//窗口是是否为关闭状态, true：表示关闭
		modal: true,//模式窗口
		iconCls: 'icon-save',
		buttons: [
		   {
			   text: '保存',
			   iconCls: 'icon-save',
			   handler:function(){
				   var formdata = $('#editForm').serializeJSON();
				   $.ajax({
					   url: 'emp_updatePwd_reset',
					   data : formdata,
					   dataType: 'json',
					   type: 'post',
					   success:function(rtn){
						   $.messager.alert('提示',rtn.message,'info',function(){
							   if(rtn.success){
								   $('#editDlg').dialog('close');
							   }
						   });
					   }
				   });
			   }
		   }       
		          
		]
	});
});

//打开重置密码窗口
function updatePwd_reset(uuid){
	
	$('#editDlg').dialog('open');
	//清空表单
	 $('#editForm').form('clear');
	 //加载数据
	 $('#editForm').form('load',{id: uuid, newPwd:""});
}