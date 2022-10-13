<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<title>學生名單</title>

<c:set var="contextRoot" value="${pageContext.request.contextPath}" />

<!-- web icon -->
<link rel="icon" href="${contextRoot}/img/icon.png" />
<!-- dataTable CSS -->
<link rel="stylesheet"
	href="${contextRoot}/css/common/jquery.dataTables.min.css" />
</head>
<body><jsp:include page="../common/navigate.jsp" />
	<div class="container" id="wrapper">
		<div class="text-start">
			<a href="${contextRoot}/course/uploaded/profile"
				class="d-flex align-items-center mb-2 mb-lg-0 text-dark text-decoration-none">
				<button type="button" class="btn btn-outline-primary" style="margin-bottom: 5px;">返回</button>
			</a>
		</div>
		<table id="studentsTable" class="display">
			<thead>
				<tr>
					<th>加入時間</th>
					<th>大頭貼</th>
					<th>學生姓名</th>
					<th>性別</th>
					<th>電子信箱</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${courseProfile.orderItems}" var="item">
					<tr>
						<td>${item.order.time}</td>
						<td><img src="data:image/jpeg;base64,${item.order.userInformation.base64Photo}" width="45" height="45" class="rounded-circle"></td>
						<td>${item.order.userInformation.name}</td>
						<td>${item.order.userInformation.gender}</td>
						<td>${item.order.userInformation.email}</td>
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
	    $("#studentsTable").DataTable({
		order : [ 0, "asc" ],
	    });
	});
    </script>
</body>
</html>