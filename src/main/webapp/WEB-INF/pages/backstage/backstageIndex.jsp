<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<c:set var="contextRoot" value="${pageContext.request.contextPath}" />
<style>
#flotcontainer {
	width: 500px;
	height: 400px;
}

#flotcontainer {
	width: 600px;
	height: 400px;
	text-align: left;
}
</style>
<meta charset="UTF-8">

<title>數據圖表</title>
</head>

<body>
	<jsp:include page="../backstage/backstageNavbar.jsp" />
	<h1>營業圖表</h1>
	<div>
		<button type="submit" class="btn btn-warning">課程營業數據圖表</button>
	</div>
	當日數據色別 : <button type="submit" class="btn btn-Info" id="showInteractive"> </button>
	<br>
	<div id="legendPlaceholder"></div>
	<div id="flotcontainer"></div>
	
</body>
	<jsp:include page="../common/footer.jsp" />
<script
	src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
<script src="http://static.pureexample.com/js/flot/excanvas.min.js"></script>
<script src="http://static.pureexample.com/js/flot/jquery.flot.min.js"></script>
<script
	src="http://static.pureexample.com/js/flot/jquery.flot.pie.min.js"></script>
<script type="text/javascript">
let urlString = '${contextRoot}/backstage/orderAjax';
$.ajax({type : "GET",
		url : urlString,
		success : function(result) {
			console.log(result);
			// Data
			var data = [];
			$(result).each(function(i, e){
				let course = {
						"label": e.courseProfileName,
						"data" : e.totalPrice
				}
				data.push(course);
			});
			console.log(data);
			
			// Options
			var options = {
				series : {
					pie : {
						show : true,
						radius : 1,
						tilt : 0.5,
						label : {
							radius : 3 / 4,
							formatter : function(label, series) {
								return '<div style="border:1px solid gray;font-size:8pt;text-align:center;padding:5px;color:white;">'
										+ label
										+ '<br/>'
										+ Math.round(series.percent)
										+ '%</div>';
							},
							background : {
								opacity : 0.5,
								color : '#000'
							}
						}
					}
				},
				legend : {
					show : false
				},
				grid : {
					hoverable : true,
					clickable : true
				}
			};

			$.plot($("#flotcontainer"), data, options);

			$("#flotcontainer").bind("plothover",
				function(event, pos, obj) {
					if (!obj) {
						return;
					}
					percent = parseFloat(obj.series.percent).toFixed(2);
					
					var html = [];
					html.push(
						"<div style=\"flot:left;width:105px;height:20px;text-align:center;border:1px solid black;background-color:", obj.series.color, "\">",
						"<span style=\"font-weight:bold;color:white\">",
						obj.series.label, " (",
						percent, "%)</span>",
						"</div>");

					$("#showInteractive").html(
						html.join(''));
			});
		}
});
					
	
</script>

</html>