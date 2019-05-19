/**
 * 
 */
$(function() {
	$('#empRole_grid').datagrid({    
	    url:'emp_list',    
	    columns:[[    
	        {field:'uuid',title:'编号',width:100},    
	        {field:'name',title:'名称',width:100} 
	    ]],
	    singleSelect:true,
	    onClickRow:function(rowIndex, rowData){
	    	$('#tree').tree({    
	    	    url:'emp_readEmpRoles?id=' + rowData.uuid,
	    	    animate:true,
	    	    checkbox:true
	    	}); 
	    }
	});  
	$('#btnSave').bind("click",function(){
		//角色id
		var uuid = $('#empRole_grid').datagrid("getSelected").uuid;
		
		var nodes = $('#tree').tree('getChecked');
		var checkedIds = new Array();
		$.each(nodes,function(i,node){
			checkedIds.push(node.id);
		})
		//权限菜单对应id
		checkedIds = checkedIds.join(",");
		var formData = {'id':uuid,'checkedIds':checkedIds};
		$.ajax({
			url: 'emp_updateEmpRoles',
			data: formData,
			dataType: 'json',
			type: 'post',
			success:function(data){
				$.messager.alert("提示",data.message,'info',function(){
				});
			}
		});
	});
})
