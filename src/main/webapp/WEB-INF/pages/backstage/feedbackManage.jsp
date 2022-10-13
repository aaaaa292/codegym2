W<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="contextRoot" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<!-- 自定義CSS -->
<link rel="stylesheet"
	href="${contextRoot}/css/backstage/jquery.dataTables.min.css">
<script src="https://code.jquery.com/jquery-2.1.3.min.js"></script>
<meta charset="UTF-8">
<title>顧客反饋</title>
</head>
<body>

	<!-- 導覽列 -->
	<jsp:include page="../backstage/backstageNavbar.jsp" />
	<div class="d-flex align-items-end">
		<h1>顧客反饋</h1>
	</div>
	<br>
<div class="container">
	<table id="example" class="display">
		<thead>
			<tr>
				<th scope="col">留言時間</th>
				<th scope="col">內容</th>
				<th scope="col">狀態</th>
				<th scope="col">詳細</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="receiptMsg" items="${page.content}">
				<tr>
					<td><fmt:formatDate pattern="yyyy/MM/dd HH:mm:ss"
							value="${receiptMsg.time}" /></td>
					<td>${receiptMsg.message}</td>
					<td>${receiptMsg.status}</td>
					<td><a
						href="${contextRoot}/backstage/feedback/${receiptMsg.id}"
						class="ms-2">
							<button class="btn btn-warning btn-sm me-3">詳細內容</button>
					</a></td>
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