<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<c:set var="contextRoot" value="${pageContext.request.contextPath}" />
<meta charset="UTF-8">
<title>站內訊息</title>
<!-- 自定義CSS -->
<link rel="stylesheet"
	href="${contextRoot}/css/backstage/jquery.dataTables.min.css">
<script src="https://code.jquery.com/jquery-2.1.3.min.js"></script>
</head>
<body>
	<jsp:include page="../backstage/backstageNavbar.jsp" />

	<h1>站內訊息</h1>
	<div class="container">
		<table id="example" class="display">
			<thead>
				<tr>
					<th>用戶編號</th>
					<th>訊息編號</th>
					<th>使用者名字</th>
					<th>訊息</th>
			</thead>
			<tbody>
				<c:forEach items="${Messages}" var="ms">
					<tr>
						<td>${ms.userId}</td>
						<td>${ms.id}</td>
						<td>${ms.name}</td>
						<td>${ms.message}</td>
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