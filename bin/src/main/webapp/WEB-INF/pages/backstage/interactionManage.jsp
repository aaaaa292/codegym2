<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<c:set var="contextRoot" value="${pageContext.request.contextPath}" />
<meta charset="UTF-8">
<title>討論管理</title>
<!-- 自定義CSS -->
<link rel="stylesheet" href="${contextRoot}/css/backstage/jquery.dataTables.min.css">
</head>
<body>
<jsp:include page="../backstage/backstageNavbar.jsp" />

<h1>討論管理</h1>
<div class="container">	
<table id="example" class="display">
			<thead>
				<tr>
					<th>文章編號</th>
					<th>發文時間</th>
					<th>標題</th>
					<th>最新回覆時間</th>
					<th>回覆</th>
			</thead>
			<tbody>
				<c:forEach items="${Result}" var="intmanage">
					<tr>
						<td>${intmanage.id}</td>
						<td>${intmanage.time}</td>
						<td>${intmanage.title}</td>
						<td>${intmanage.replyTime}</td>
						<td>${intmanage.comment}</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
	<jsp:include page="../common/footer.jsp" />
	<!-- dataTable JS -->
	<script src="${contextRoot}/js/common/jquery.dataTables.min.js"></script>
	<script>
		$(document).ready(function() {
			$('#example').DataTable({
				"order" : [ 0, 'asc' ]
			});
		});
	</script>
</body>

</html>