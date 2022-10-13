<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>瀏覽課程</title>

<c:set var="contextRoot" value="${pageContext.request.contextPath}" />

<!-- web icon -->
<link rel="icon" href="${contextRoot}/img/icon.png">
<style>
.card {
	box-shadow:-1px 5px 18px rgb(222 217 217 / 70%);
	border-radius: 15px !important;
    overflow: hidden;
}

.card-img-top {
	width: 100%;
	height: 15vw;
	object-fit: cover;
}

.imgContainer {
	position: relative;
	text-align: center;
	color: white;
}

img {
	opacity: 0.8;
}

.centeredBTN {
	position: absolute;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
}
</style>
</head>

<body>
	<jsp:include page="../common/navigate.jsp" />
	<main id="wrapper">
		<div class="album py-5 bg-light">
			<div class="container">
				<div class="text-center">
					<div class="row align-items-center justify-content-md-center">
						<!-- 點擊特定標籤時顯示 -->
						<c:if test="${!empty tag}">
							<div class="col col-lg-1">
								<a href="${contextRoot}/course/show"> <span
									class="badge bg-info text-white">#${tag} <span
										id="cancelTagBTN" class="badge rounded-pill bg-danger">x</span>
								</span></a>
							</div>
						</c:if>
						<!-- 關鍵字搜尋時顯示 -->
						<c:if test="${!empty keyword}">
							<div id="cancelTagBTN" class="col col-lg-2">
								<a href="${contextRoot}/course/show"><span
									class="badge bg-info text-white">Keyword: ${keyword} <span class="badge rounded-pill bg-danger">x</span>
								</span></a>
							</div>
						</c:if>

						<div class="col col-lg-1">
							<label for="ketword" class="col-form-label">搜尋課程:</label>
						</div>
						<div class="col col-lg-2">
							<form id="ketwordSearch" action="${contextRoot}/course/search"
								method="get">
								<input type="text" name="keyword" id="ketword"
									class="form-control">
							</form>
						</div>
						<div class="col col-lg-1">
							<button type="button" id="ketwordSearchBTN"
								class="btn btn-primary">送出</button>
						</div>

						<div class="col col-lg-2">
							<select id="sortSelect" class="form-select"
								aria-label="Default select example">
								<option value="" selected>選擇排序方式</option>
								<option value="priceASC">價錢低到高</option>
								<option value="priceDESC">價錢高到低</option>
								<option value="dateDESC">新到舊</option>
								<option value="dateASC">舊到新</option>
							</select>
						</div>
					</div>
				</div>
				<br>
				<div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-3"
					id="itemsCard">
					<c:forEach items="${courseProfiles}" var="courseProfile">
						<!-- 取得課程評分 -->
						<c:set var="scoreTimes" value="${0}" />
						<c:set var="scoreTotal" value="${0}" />
						<c:forEach items="${courseProfile.courseScores}" var="courseScore">
							<c:set var="scoreTimes" value="${scoreTimes + 1}" />
							<c:set var="scoreTotal" value="${scoreTotal + courseScore.score}" />
						</c:forEach>
						<!-- 計算平均評分 -->
						<c:if test="${scoreTimes != 0}">
							<c:set var="scoreAvg" value="${scoreTotal / scoreTimes}" />
						</c:if>
						<!-- 還沒有人評分的情況 -->
						<c:if test="${scoreTimes == 0}">
							<c:set var="scoreAvg" value="${0}" />
						</c:if>

						<div class="col">
							<div class="card">
								<!-- 隱藏的課程資訊 -->
								<span hidden="hidden" class="quantity">1</span> <span
									hidden="hidden" class="courseId">${courseProfile.id}</span> <span
									hidden="hidden" class="courseName">${courseProfile.name}</span>

								<div class="imgContainer">
									<a href="${contextRoot}/course/${courseProfile.id}/show"> <img
										src="${contextRoot}/course/getImg?courseId=${courseProfile.id}"
										class="card-img-top">
									</a>
									<div class="centeredBTN">
										<a href="${contextRoot}/course/${courseProfile.id}/show"
											class="text-decoration-none">
											<button type="button" class="btn btn-success btn-lg">${courseProfile.name}</button>
										</a>
									</div>
								</div>
								<div class="card-body text-center fs-4">
									<p class="h6">
										<a href="${contextRoot}/course/${courseProfile.id}/show"
											class="text-decoration-none text-dark"> <c:set
												var="shortIntroduction"
												value="${fn:substring(courseProfile.introduction, 0, 10)}" />
											<em>${shortIntroduction}...</em>
										</a>
									</p>
								</div>
								<div class="card-footer text-center">
									<c:forEach items="${courseProfile.courseTags}" var="t">
										<a href="${contextRoot}/course/tag/${t.tag}/show"><span
											class="badge bg-primary text-white">#${t.tag}</span></a>
									</c:forEach>
								</div>
								<div class="card-footer text-center">
									<span class="badge rounded-pill bg-secondary">${courseProfile.userInformation.name}</span>
									<span class="badge rounded-pill bg-dark courseTime">
										<fmt:formatDate pattern="yyyy/MM/dd HH:mm:ss" value="${courseProfile.time}" />
									</span>
								</div>
								<div class="card-footer text-center">
									<!-- 課程評價分數 -->
									<img src="${contextRoot}/img/starIcon.png" height="20"> <a
										type="button" class="scoreAvg text-decoration-none text-dark"
										data-bs-toggle="modal" data-bs-target="#scoreAvgBox">${scoreAvg}
										(${scoreTimes})</a>
									<c:if test="${empty orders}">
										<button class="badge bg-warning text-dark addCart"
											data-price="${courseProfile.price}">加入購物車</button>
										<span class="me-5 coursePrice">$${courseProfile.price}</span>
									</c:if>
									<c:if test="${!empty orders}">
										<c:set var="buyCourse" value="${0}" />
										<c:forEach items="${orders}" var="order">
											<c:forEach items="${order.orderItems}" var="item">
												<c:if test="${item.courseProfile.id == courseProfile.id}">
													<c:set var="buyCourse" value="${1}" />
													<button class="badge bg-light text-dark">已購買</button>
												</c:if>
											</c:forEach>
										</c:forEach>
										<c:if test="${buyCourse == 0}">
											<button class="badge bg-warning text-dark addCart"
												data-price="${courseProfile.price}">加入購物車</button>
											<span class="me-5">$${courseProfile.price}</span>
										</c:if>
									</c:if>
								</div>
							</div>
						</div>
					</c:forEach>

				</div>
			</div>
		</div>
	</main>
	<!-- 觀看課程評價細項彈跳視窗 -->
	<div class="modal fade" id="scoreAvgBox" tabindex="-1"
		aria-labelledby="scoreAvgBoxLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="scoreAvgBoxLabel">課程評價</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="row modal-body" id="scoresContent"></div>
			</div>
		</div>
	</div>
	<jsp:include page="../common/footer.jsp" />
	<script>
		// 排序功能
		// 依照價格小到大排序
		var priceASC = function(a, b) {
			let x = $(a).find('.coursePrice').text();
			let y = $(b).find('.coursePrice').text();

			return parseInt(x.substring(1)) > parseInt(y.substring(1)) ? 1 : -1;
		}
		// 依照價格大到小排序
		var priceDESC = function(a, b) {
			let x = $(a).find('.coursePrice').text();
			let y = $(b).find('.coursePrice').text();

			return parseInt(x.substring(1)) > parseInt(y.substring(1)) ? -1 : 1;
		}
		// 依照日期小到大排序
		var dateASC = function(a, b) {
			let x = $(a).find('.courseTime').text();
			let y = $(b).find('.courseTime').text();

			return new Date(x) > new Date(y) ? 1 : -1;
		}
		// 依照日期大到小排序
		var dateDESC = function(a, b) {
			let x = $(a).find('.courseTime').text();
			let y = $(b).find('.courseTime').text();

			return new Date(x) > new Date(y) ? -1 : 1;
		}
		// 排序
		function sortByInput(sortBy) {
			var sortEle = $('#itemsCard>div').sort(sortBy);
			$('#itemsCard').empty().append(sortEle);
		}
		// 判斷排序方式
		$("#sortSelect").change(function() {
			let sortMethod = $("#sortSelect option:selected").val();
			if (sortMethod == "priceASC") {
				sortByInput(priceASC);
			} else if (sortMethod == "priceDESC") {
				sortByInput(priceDESC);
			} else if (sortMethod == "dateASC") {
				sortByInput(dateASC);
			} else if (sortMethod == "dateDESC") {
				sortByInput(dateDESC);
			}

		});
		// 關鍵字搜尋
		$("#ketwordSearchBTN").click(function() {
			$("#ketwordSearch").submit();
		});
		
		// 載入課程評價
		$(".scoreAvg").on("click", (e) => {
		 	// 用ajax取得此課程評價
		 	let courseId = $(e.target).closest(".card").find(".courseId").text();
	 	  	let urlString = '${contextRoot}/course/score/show/' + courseId;
	 	  	console.log(urlString);
			$.ajax({
			    type : "GET",
			    url : urlString,
			    success : function(result) {
			    	
					let content = "";
					$(result).each(function (index, element) {
					    content += "<p>["+ element.time + "]" + element.score + "分-" + element.userName + ":" + element.comment + "</p>";
					});
					$("#scoresContent").html("");
					$("#scoresContent").append(content);
			    }
			});
		});
		
		// 購物車功能
		// 把購買項目存入localstorage
		$(".addCart").click(function(e) {
			// 判斷使用者是否登入，未登入就把userId設為0
			let userId = '<c:if test="${empty userInformation}">0</c:if><c:if test="${!empty userInformation}">${userInformation.id}</c:if>';
			console.log(userId);

			if (localStorage.getItem("cart") === null) { //localStorage沒有購物車物件就創一個
				var cart = [];
			} else { //已經存在 就抓出來
				cart = JSON.parse(localStorage.getItem("cart"));
			}

			let course = $(e.target).closest(".card");

			var count = 0;
			for (let i = 0; i < cart.length; i++) { //檢查存在與否
				if (cart[i].courseId === course.find(".courseId").text()
						&& cart[i].userId === userId) {
					count++;
				}
			}

			    if (count === 1) { //已存在 不進購物車
				alert("該課程已經加入購物車!");
			    } else { //不存在 進購物車
				let newItem = {
					userId : userId,
					price : $(e.target).data("price"),
					courseId : course.find(".courseId").text(),
					courseName : course.find(".courseName")
							.text(),
					amount : course.find(".quantity").text()
				};
				console.log(newItem);
				cart.push(newItem);
				localStorage.setItem("cart", JSON
					.stringify(cart));
				
				alert("成功加入購物車!");
			    }
			});
    </script>
>>>>>>> Poyu
</body>

</html>