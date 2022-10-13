<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>已購買課程</title>
<c:set var="contextRoot" value="${pageContext.request.contextPath}" />

<!-- web icon -->
<link rel="icon" href="${contextRoot}/img/icon.png" />
<!-- dataTable CSS -->
<link rel="stylesheet"
	href="${contextRoot}/css/common/jquery.dataTables.min.css" />
</head>
<body>
	<jsp:include page="../common/navigate.jsp" />
	<div class="container-fluid" id="wrapper">
		<table id="orderTable" class="display">
			<thead>
				<tr>
					<th>下單時間</th>
					<th>總金額</th>
					<th>明細</th>
					<th>註記</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${orders}" var="order">
					<tr>
						<td>${order.time}</td>
						<td>$${order.totalPrice}</td>
						<td>
							<table>
								<thead>
									<tr>
										<th>課程</th>
										<th>老師名字</th>
										<th>課程價錢</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach items="${order.orderItems}" var="item">
										<tr>
											<td><a
												href="${contextRoot}/course/${item.courseProfile.id}/show"
												class="d-flex align-items-center mb-2 mb-lg-0 text-dark text-decoration-none">
													<button type="button" class="btn btn-secondary"
														style="width: 100%;">${item.courseProfile.name}</button>
											</a></td>
											<td>${item.courseProfile.userInformation.name}</td>
											<td>$${item.courseProfile.price}</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</td>
						<td>${order.note}</td>
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
	    $("#orderTable").DataTable({
		order : [ 0, "asc" ],
	    });
	});
    </script>
</body>
</html>