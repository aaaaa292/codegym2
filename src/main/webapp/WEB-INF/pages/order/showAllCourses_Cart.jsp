<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>

<head>
	<meta charset="UTF-8">
	<title>瀏覽課程</title>

	<c:set var="contextRoot" value="${pageContext.request.contextPath}" />

	<!-- web icon -->
	<link rel="icon" href="${contextRoot}/img/icon.png">

</head>

<body>
	<jsp:include page="../common/navigate.jsp" />
	<main>
		<div class="album py-5 bg-light">
			<div class="container">
				<div class="text-center">搜尋課程: <input type="text"></div>
				<div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-3">
					<c:forEach items="${courseProfiles}" var="courseProfile">
						<div class="col">
							<div class="card border border-5">
								<!-- 隱藏的課程資訊 -->
								<span hidden="hidden" class="quantity">1</span>
								<span hidden="hidden" class="courseId">${courseProfile.id}</span>
								<span hidden="hidden" class="courseName">${courseProfile.name}</span>

								<a href="${contextRoot}/course/${courseProfile.id}/show">
									<img src="${contextRoot}/course/getImg?courseId=${courseProfile.id}"
										class="card-img-top">
								</a>
								<div class="card-body text-center fs-4">
									<a href="${contextRoot}/course/${courseProfile.id}/show"
										class="text-decoration-none">
										<button type="button"
											class="btn btn-outline-success btn-lg">${courseProfile.name}</button>
									</a>
								</div>
								<div class="card-footer text-center">
									<c:forEach items="${courseProfile.courseTags}" var="t">
										<span class="badge bg-primary text-white">#${t.tag}</span>
									</c:forEach>
								</div>
								<div class="card-footer text-center">
									<span
										class="badge rounded-pill bg-secondary">${courseProfile.userInformation.name}</span>
									<span class="badge rounded-pill bg-dark">${courseProfile.time}</span>
								</div>
								<div class="card-footer text-center">
									<button class="badge bg-warning text-dark addCart" data-price="${courseProfile.price}">加入購物車</button>
									<span class="me-5">$${courseProfile.price}</span>
								</div>
							</div>
						</div>
					</c:forEach>

				</div>
			</div>
		</div>
	</main>
	<jsp:include page="../common/footer.jsp" />
	<script>
		// 存入localstorage
		$(".addCart").click(function (e) {
			// 判斷使用者是否登入，未登入就把userId設為0
			let userId = '<c:if test="${empty userInformation}">0</c:if><c:if test="${!empty userInformation}">${userInformation.id}</c:if>';
			console.log(userId);


			if (localStorage.getItem("cart") === null) { //localStorage沒有購物車物件就創一個
				var cart = [];
			} 
			else { //已經存在 就抓出來
				cart = JSON.parse(localStorage.getItem("cart"));
			}

			let course = $(e.target).closest(".card");

			var count = 0;
			for (let i = 0; i < cart.length; i++) { //檢查存在與否
				if (cart[i].courseId === course.find(".courseId").text() && cart[i].userId === userId) {
					count++;
				}
			}

			if (count === 1) { //已存在 不進購物車
				alert("已放入購物車!");
			} 
			else { //不存在 進購物車
				let newItem = {
					userId: userId,
					price: $(e.target).data("price"),
					courseId: course.find(".courseId").text(),
					courseName: course.find(".courseName").text(),
					amount: course.find(".quantity").text()
				};
				console.log(newItem);
				cart.push(newItem);
				localStorage.setItem("cart", JSON.stringify(cart));
			}
		});
	</script>
</body>

</html>