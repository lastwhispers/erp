//提交的方法名称
var method = "";
var listParam = "";
var saveParam = "";
$(function(){
	//加载表格数据
	$('#grid').datagrid({
		url:name + '_listByPage' + listParam,
		columns:columns,
		singleSelect: true,
		pagination: true,
		toolbar: [
			{
			text: '新增',
			iconCls: 'icon-add',
			handler: function(){
				// 打开前清空表单
				$('#editForm').form('clear');
				//设置保存按钮提交的方法为add
				method = "add";
				//关闭编辑窗口
				$('#editDlg').dialog('open');
			}
		},'-',{
			text: '导出',
			iconCls: 'icon-excel',
			handler: function(){
				var formData = $('#searchForm').serializeJSON();
				//下载文件
				$.download(name + "_export" + listParam,formData);
			}
		},'-',{
			text: '导入',
			iconCls: 'icon-save',
			handler: function(){
				$('#importDlg').dialog('open');
			}
		}]
	});

	//点击查询按钮
	$('#btnSearch').bind('click',function(){
		//把表单数据转换成json对象
		var formData = $('#searchForm').serializeJSON();
		$('#grid').datagrid('load',formData);
	});

	var h = 300;
	var w = 400;
	if(typeof(height) != "undefined"){
		h = height;
	}
	if(typeof(width) != "undefined"){
		w = width;
	}
	//初始化编辑窗口
	$('#editDlg').dialog({
		title: '编辑',//窗口标题
		width: w,//窗口宽度
		height: h,//窗口高度
		closed: true,//窗口是是否为关闭状态, true：表示关闭
		modal: true//模式窗口
	});

	//点击保存按钮
	$('#btnSave').bind('click',function(){
		//做表单字段验证，当所有字段都有效的时候返回true。该方法使用validatebox(验证框)插件。
		var isValid = $('#editForm').form('validate');
		if(isValid == false){
			return;
		}
		var formData = $('#editForm').serializeJSON();
		
		//name来自于每个界面的定义
		switch(name)
		{
		//如果是商品界面进行价格验证
		case 'goods':
			var inprice = $('#inprice').val();
			var outprice = $('#outprice').val();
			if (inprice > outprice) {
				$.messager.confirm("警告", "当前售价大于进价，确认保存吗？", function (yes) {
					if(yes){
						$.ajax({
							url: name + '_' + method + saveParam,
							data: formData,
							dataType: 'json',
							type: 'post',
							success:function(rtn){
								$.messager.alert("提示",rtn.message,'info',function(){
									// 成功的话，我们要关闭窗口
									$('#editDlg').dialog('close');
									// 刷新表格数据
									$('#grid').datagrid('reload');
									
								});
							}
						});
					}
				})
				}
		  break;
		//其他界面提交
		default:

			$.ajax({
				url: name + '_' + method + saveParam,
				data: formData,
				dataType: 'json',
				type: 'post',
				success:function(rtn){
					$.messager.alert("提示",rtn.message,'info',function(){
						// 成功的话，我们要关闭窗口
						$('#editDlg').dialog('close');
						// 刷新表格数据
						$('#grid').datagrid('reload');
						
					});
				}
			});
			break;
		}
		
/*		
		$.ajax({
			url: name + '_' + method + saveParam,
			data: formData,
			dataType: 'json',
			type: 'post',
			success:function(rtn){
				$.messager.alert("提示",rtn.message,'info',function(){
					//成功的话，我们要关闭窗口
					$('#editDlg').dialog('close');
					//刷新表格数据
					$('#grid').datagrid('reload');
				});
			}
		});*/
		
		
		
	});
	
	//判断是否有导入的功能
	var importForm = document.getElementById('importForm');
	if(importForm){
		$('#importDlg').dialog({
			title:'导入数据',
			width:330,
			height:106,
			modal:true,
			closed:true,
			buttons:[
			    {
			    	text: '导入',
			    	handler:function(){
			    		$.ajax({
			    			url: name + '_doImport',
			    			data:new FormData($('#importForm')[0]),
			    			type:'post',
			    			processData:false,
			    			contentType:false,
			    			dataType:'json',
			    			success:function(data){
			    				$.messager.alert('提示',data.message,'info',function(){
			    					if(data.success){
			    						$('#importDlg').dialog('close');
			    						$('#importForm').form('clear');
			    						$('#grid').datagrid('reload');
			    					}
			    				});
			    			}
			    		});
			    	}
			    }
			]
		});
	}
	
});


/**
 * 删除
 */
function del(uuid){
	$.messager.confirm("确认","确认要删除吗？",function(yes){
		if(yes){
			$.ajax({
				url: name + '_delete?id=' + uuid,
				dataType: 'json',
				type: 'post',
				success:function(rtn){
					$.messager.alert("提示",rtn.message,'info',function(){
						//刷新表格数据
						$('#grid').datagrid('reload');
					});
				}
			});
		}
	});
}

/**
 * 修改
 */
function edit(uuid){
	//弹出窗口
	$('#editDlg').dialog('open');
	//清空表单内容
	$('#editForm').form('clear');
	//设置保存按钮提交的方法为update
	method = "update";
	//加载数据
	$('#editForm').form('load',name + '_get?id=' + uuid);
}