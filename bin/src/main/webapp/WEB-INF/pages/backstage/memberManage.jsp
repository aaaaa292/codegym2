<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>會員管理</title>

<c:set var="contextRoot" value="${pageContext.request.contextPath}" />

<!-- web icon -->
<link rel="icon" href="${contextRoot}/img/icon.png">
<!-- dataTable CSS -->
<link rel="stylesheet"
	href="${contextRoot}/css/common/jquery.dataTables.min.css">

</head>

<body>
	<jsp:include page="../backstage/backstageNavbar.jsp" />

	<h1>會員管理</h1>
	<div class="container">
		<table id="example" class="display">
			<thead>
				<tr>
					<th>頭像</th>
					<th>使用者編號</th>
					<th>名字</th>
					<th>電子信箱</th>
					<th>性別</th>
					<th>密碼</th>
					<th>生日</th>
					<th>電話</th>
					<th>身分</th>
					<th>訊息</th>
			</thead>
			<tbody>
				<c:forEach items="${userInformations}" var="member">
					<tr>
						<td><img src="data:image/jpeg;base64,${member.base64Photo}" width="45" height="45" class="rounded-circle"></td>
						<td>${member.id}</td>
						<td>${member.name}</td>
						<td>${member.email}</td>
						<td>${member.gender}</td>
						<td>*******</td>
<%-- 						<td>${member.password}</td> --%>
						<td>${member.birthday}</td>
						<td>${member.phone}</td>
<%-- 						<td>${member.role}</td> --%>
						<c:if test="${member.role == 1}">
							<td>老師</td>
						</c:if>
						<c:if test="${member.role == 2}">
							<td>學生</td>
						</c:if>
						<c:if test="${member.role == 3}">
							<td>管理員</td>
						</c:if>
						<td><a href="${contextRoot}/backstage/message/send?id=${member.id}&name=${member.name}"><button
									type="button" class="btn btn-warning">訊息發送</button></a></td>
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