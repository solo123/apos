function show_diagram(canvas_id, data_id, label_index, data_index){
	var cvs = $('#' + canvas_id);
	cvs[0].width = cvs.parent().width() * .95;
  var ctx = $('#' + canvas_id).get(0).getContext("2d");
	var tb = $('#' + data_id + ' table');
	var data_lb = get_table_data(tb, label_index);
	var data_dt = get_table_num(tb, data_index+1);
  var data = {
  	labels : data_lb,
	  datasets : [
		{
			fillColor : "rgba(220,220,220,0.5)",
			strokeColor : "rgba(220,220,220,1)",
			pointColor : "rgba(220,220,220,1)",
			pointStrokeColor : "#fff",
			data : data_dt
		}
	]
  }

	tt = data;
  var options = {
	  scaleOverride : true,
	  scaleSteps : 11,
	  scaleStepWidth : parseFloat(Math.max.apply(Math, data_dt).toExponential(1)) / 10,
    scaleStartValue : 0,
	};

	switch ($('#diagram_type').val()){
		case 'bar': 
    	new Chart(ctx).Bar(data, options);
			break;
	  case 'line':
			new Chart(ctx).Line(data, options);
			break;
	  case 'radar':
			new Chart(ctx).Radar(data, options);
			break;
	  case 'polar':
			new Chart(ctx).PolarArea(data, options);
			break;
	  case 'pie':
			new Chart(ctx).Pie(data, options);
			break;
		case 'doughnut':
			new Chart(ctx).Doughnut(data, options);
			break;
	}
}

function get_table_data(tb, column_num){
	return tb.find('tbody tr td:nth-child(' + column_num + ')').map(function(){return $(this).text()});
}
function get_table_num(tb, column_num){
	return tb.find('tbody tr td:nth-child(' + column_num + ')').map(function(){return parseFloat($(this).text().replace(/,/g, ''))});
}

function myshow_diagram(lnk){
	show_diagram('chart_canvas', 'report_content', 1, $(lnk).parent().index());
}
function show2_diagram(lnk){
	show_diagram('chart_canvas', 'report_content', 2, $(lnk).parent().index());
}
