<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<c:set var="contextRoot" value="${pageContext.request.contextPath}" />
<meta charset="UTF-8">
<title>銷售管理</title>
<!-- 自定義CSS -->
<link rel="stylesheet"
	href="${contextRoot}/css/backstage/jquery.dataTables.min.css">
</head>
<body>
	<jsp:include page="../backstage/backstageNavbar.jsp" />
	<h1>銷售管理</h1>
	<div class="container">

		<table id="example" class="display">
			<thead>
				<tr>
					<!-- id -->
					<th>訂單編號</th>
					<!-- name -->
					<th>使用者</th>
					<!-- email -->
					<th>聯絡資訊</th>
					<!-- totalPrice -->
					<th>金額</th>
					<!--time-->
					<th>購買時間</th>
					<th>購買細項</th>
			</thead>
			<tbody>
				<c:forEach items="${orderlist}" var="orders">
					<tr>
						<td>${orders.id}</td>
						<td>${orders.userInformation.name}</td>
						<td>${orders.userInformation.email}</td>
						<td>${orders.totalPrice}</td>
						<td>${orders.time}</td>
						<td>
							<!-- 新增分類 彈跳視窗 -->
							<div class="mt-1">
								<button type="button"
									class="btn btn-outline-success btn btn-outline-success ms-4 "
									data-toggle="modal" data-target="#exampleModal${orders.id}"
									data-whatever="@getbootstrap">購物內容</button>
							</div>

							<div class="modal fade " id="exampleModal${orders.id}" tabindex="-1"
								role="dialog" aria-labelledby="exampleModalLabel"
								aria-hidden="true">
								<div class="modal-dialog" role="document">
									<div class="modal-content">
										<div class="modal-header">
											<h5 class="modal-title" id="exampleModalLabel">詳細清單</h5>
											<button type="button" class="close" data-dismiss="modal"
												aria-label="Close">
												<span aria-hidden="true">&times;</span>
											</button>
										</div>
										<!-- 彈跳執行新增動作編輯視窗 -->
										<div class="container">
											<table id="example">
												<thead>
													<tr>
														<th>課程名稱</th>
														<th>價錢</th>
													</tr>
												</thead>
												<tbody>
													<c:forEach items="${orders.orderItems}" var="oitems" >
														<tr>
															<td>${oitems.courseProfile.name}</td>
															<td>${oitems.courseProfile.price}</td>
														</tr>
													</c:forEach>
												</tbody>
											</table>
										</div>
										<button type="button" class="btn btn-secondary"
											data-dismiss="modal">取消</button>
									</div>
								</div>
							</div>
						</td>
					</tr>

				</c:forEach>
			</tbody>
		</table>
	</div>
	<jsp:include page="../common/footer.jsp" />
	<!-- dataTable JS -->
	<script>
	$('#exampleModalLabel').click(function() {
		var orderuse;
		$('').
		
		
		
	});
	
	
	</script>
	<script
		src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js"
		integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj"
		crossorigin="anonymous"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"
		integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN"
		crossorigin="anonymous"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.min.js"
		integrity="sha384-+sLIOodYLS7CIrQpBjl+C7nPvqq+FbNUBDunl/OZv93DB7Ln/533i8e/mZXLi/P+"
		crossorigin="anonymous"></script>
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