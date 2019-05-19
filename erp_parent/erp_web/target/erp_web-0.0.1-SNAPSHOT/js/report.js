$(function() {
	$('#report_grid').datagrid({    
	    url:'report_ordersReport',    
	    columns:[[    
	        {field:'name',title:'商品类型',width:100},    
	        {field:'y',title:'销售额',width:100}  
	    ]],
	    singleSelect:true,
	    onLoadSuccess:function(data){
	    	//显示图
			showChart(data.rows);
	    }
	});
	
	$('#btnSearch').bind('click',function(){
		var formdata = $('#searchForm').serializeJSON();
		if(formdata.endDate != ''){
			//如果有截止日期，要补上当天的最后时间
			formdata.endDate = formdata.endDate + ' 23:59:59';
		}
		console.log(formdata);
		$('#report_grid').datagrid('load',formdata);
	});
});

//显示图
function showChart(_data){
	$('#pieChart').highcharts({
        chart: {
        	//区域背景颜色
            plotBackgroundColor: null,
            //区域边框宽度
            plotBorderWidth: null,
            //区域阴影
            plotShadow: false,
            //图表类型
            type: 'pie'
        },
        //图表标题
        title: {
        	//标题文本
            text: '销售统计'
        },
        //信用
        credits:{enabled:false},
        //导出
        exporting:{enabled:true},
        //工具提示
        tooltip: {
        	//工具提示显示格式
            pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
        },
        //区域选项
        plotOptions: {
            pie: {
            	//点击区域后选择
                allowPointSelect: true,
                //光标类型
                cursor: 'pointer',
                //数据标签
                dataLabels: {
                    enabled: true
                },
                //是否显示图例
                showInLegend: true
            }
        },
        //数据组
        series: [{
        	//名称
            name: "比例",
            //点的颜色
            colorByPoint: true,
            //数据
            data: _data
        }]
    });
}