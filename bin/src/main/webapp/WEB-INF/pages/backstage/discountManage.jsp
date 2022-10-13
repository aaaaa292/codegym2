<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html>
<head>
<c:set var="contextRoot" value="${pageContext.request.contextPath}" />
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
<link rel="stylesheet" href="/resources/demos/style.css">
<meta charset="UTF-8">
<title>折扣代碼</title>
<!-- 自定義CSS -->

<link rel="stylesheet"
	href="${contextRoot}/css/backstage/jquery.dataTables.min.css">
<style>
.fstyle {
	width: 105px;
}

.label {
	float: left;
	width: 80px;
}

#addDC {
	text-align: right;
	margin-bottom: 10px;
}

#deleteBtn {
	text-align: center;
	margin-bottom: 10px;
}
</style>
</head>
<body>
	<%-- 	<script src="${contextRoot}/js/common/jquery-3.6.0.min.js"></script> --%>
	<%-- 	<script src="${contextRoot}/js/common/bootstrap.bundle.min.js"></script> --%>
	<jsp:include page="../backstage/backstageNavbar.jsp" />
	<h1>折扣代碼</h1>

	<div class="container">
		<div id="addDC">
			<button type="button" class="btn btn-outline-success ms-4 "
				data-toggle="modal" data-target="#DiscountModal">新增折扣碼</button>
		</div>
		<div id="DiscountModal" class="modal fade">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title">新增折扣碼</h5>
					</div>
					<div class="modal-body">
						<!-- 互動視窗表單 -->
						<form id="codeForm" method="post"
							action="${contextRoot}/backstage/insertDiscountCode">
							<div class="form-control">
								<p>
									<label class="label">折扣碼:</label> <input style="width: 185px"
										name="discountCode" required="required"><br>
								</p>

								<p>
									<label class="label">折扣額:</label> <select style="width: 185px"
										name="discount">
										<option selected>請選擇</option>
										<option value="9">9折</option>
										<option value="89">89折</option>
										<option value="85">85折</option>
										<option value="8">8折</option>
										<option value="79">79折</option>
										<option value="75">75折</option>
										<option value="7">7折</option>
										<option value="6">6折</option>
										<option value="5">5折</option>
										<option value="150">折抵150</option>
										<option value="300">折抵300</option>
										<option value="500">折抵500</option>
										<option value="1000">折抵1000</option>
									</select><br>
								</p>

								<p>
									<label class="label">數量:</label> <input style="width: 185px"
										name="quantity" type="number" required="required" min="1" max="5000"><br>
								</p>

								<p>
									<label class="label">開始時間:</label> <input style="width: 185px"
										name="startTime" class="datepicker" required="required"><br>
								</p>

								<p>
									<label class="label">結束時間:</label> <input style="width: 185px"
										name="endTime" class="datepicker" required="required"><br>
								</p>

								<p>
									<label class="label">註:</label> <input style="width: 185px"
										name="note"><br>
								</p>

								<div style="text-align: right">
									<button type="submit" class="btn btn-outline-success">新增</button>
									<button type="button" class="btn btn-secondary"
										data-dismiss="modal">取消</button>
								</div>

							</div>


						</form>
					</div>
				</div>
			</div>
		</div>
		<table id="discountCode" class="display">
			<thead>
				<tr>
					<th>折扣編號</th>
					<th>折扣代碼</th>
					<th>折扣額度</th>
					<th>數量</th>
					<th>開始時間</th>
					<th>結束時間</th>
					<th>註</th>
					<th>刪除</th>
					<th>編輯</th>
			</thead>
			<tbody>
				<c:forEach items="${codeList}" var="codes">

					<tr>

						<td>${codes.id}</td>
						<td>${codes.discountCode}</td>
						<td><c:if test="${codes.discount < 99}">${codes.discount}折</c:if>
							<c:if test="${codes.discount > 99}">折抵${codes.discount}</c:if></td>
						<td>${codes.quantity}</td>
						<td>${codes.startTime}</td>
						<td>${codes.endTime}</td>
						<td>${codes.note}</td>
						<td><a href="${contextRoot}/deleteDiscount/${codes.id}">
								<button type="submit" class="btn btn-secondary btn-danger"
									onclick="return confirm('確認刪除?')">刪除</button>
						</a></td>

						<td>
							<!-- 							<div id="addDC"> -->
							<button type="button" class="btn btn-success ms-4 "
								data-toggle="modal" data-target="#editModal">編輯</button> <!-- 							</div> -->
							<div id="editModal" class="modal fade">
								<div class="modal-dialog" role="document">
									<div class="modal-content">
										<div class="modal-header">
											<h5 class="modal-title">編輯</h5>
										</div>
										<div class="modal-body">
											<!-- 互動視窗表單 -->
											<form id="editForm" method="post"
												action="${contextRoot}/updateDiscount/${codes.id}">
												<div>
													<p>
														<label class="label">折扣碼:</label> <input
															style="width: 185px" name="discountCode"
															required="required" value="${codes.discountCode}"><br>
													</p>

													<p>
														<label class="label">折扣額:</label> <select
															style="width: 185px" name="discount" required="required">
															
															<option value="9">9折</option>
															<option value="89">89折</option>
															<option value="85">85折</option>
															<option value="8">8折</option>
															<option value="79">79折</option>
															<option value="75">75折</option>
															<option value="7">7折</option>
															<option value="6">6折</option>
															<option value="5">5折</option>
															<option value="150">折抵150</option>
															<option value="300">折抵300</option>
															<option value="500">折抵500</option>
															<option value="1000">折抵1000</option>
														</select><br>
													</p>

													<p>
														<label class="label">數量:</label> <input
															style="width: 185px" name="quantity" type="number"
															required="required" value="${codes.quantity}"><br>
													</p>

													<p>
														<label class="label">開始時間:</label> <input
															style="width: 185px" name="startTime" class="datepicker"
															required="required" value="${codes.startTime}"><br>
													</p>

													<p>
														<label class="label">結束時間:</label> <input
															style="width: 185px" name="endTime" class="datepicker"
															required="required" value="${codes.endTime}"><br>
													</p>

													<p>
														<label class="label">註:</label> <input
															style="width: 185px" name="note" value="${codes.note}"><br>
													</p>


													<div style="text-align: right">
														<button type="submit" class="btn btn-outline-success">編輯</button>
														<button type="button" class="btn btn-secondary"
															data-dismiss="modal">取消</button>
													</div>
												</div>
											</form>
										</div>
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
		// 	$('#exampleModalLabel').click(function() {
		// 		var orderuse;
		// 		$('').

		// 	});
	</script>

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
			$('#discountCode').DataTable({
				"order" : [ 0, 'des' ]
			});
		});
	</script>
	<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
	<!-- 選日期的 -->
	<script>
		$(function() {
			$(".datepicker").datepicker();
		});
	</script>

</body>

</html>