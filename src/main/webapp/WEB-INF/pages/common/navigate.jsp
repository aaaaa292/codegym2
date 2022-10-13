<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<head>
<c:set var="contextRoot" value="${pageContext.request.contextPath}" />
<!-- Bootstrap v5.0.2 CSS -->
<link href="${contextRoot}/css/common/bootstrap.min.css"
	rel="stylesheet" />
<!-- 自定義CSS -->
<link rel="stylesheet" href="${contextRoot}/css/common/navigate.css">
<!-- W3 -->
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">

<style type="text/css">
header.nav {
	background-color: #fff;
}
</style>
</head>
<header class="nav p-3">
	<div class="container">
		<div
			class="d-flex flex-wrap align-items-center justify-content-center justify-content-lg-start">
			<a href="/"
				class="d-flex align-items-center mb-2 mb-lg-0 text-dark text-decoration-none">
				<svg class="bi me-2" width="40" height="32" role="img"
					aria-label="Bootstrap">
					<use xlink:href="#bootstrap"></use>
				</svg>
			</a>

			<!-- 導覽選項 -->
			<ul
				class="nav col-12 col-lg-auto me-lg-auto mb-2 justify-content-center mb-md-0">
				<li><a href="${contextRoot}/"
					class="nav-link px-2 link-secondary">CODE GYM 線上程式語言課程</a></li>
				<!-- 學生才顯示瀏覽課程 -->
				<c:if test="${userInformation.role != 1}">
					<li><a href="${contextRoot}/course/show"
						class="nav-link px-2 link-dark">瀏覽課程</a></li>
				</c:if>
				<!-- 老師才顯示上架課程 -->
				<c:if test="${userInformation.role == 1}">
					<li><a href="${contextRoot}/course/add"
						class="nav-link px-2 link-dark">上架課程</a></li>
				</c:if>
				<li><a href="${contextRoot}/post/showAllPosts"
					class="nav-link px-2 link-dark">&ensp;討論區&ensp;</a></li>
				<li><a href="${contextRoot}/customerservice"
					class="nav-link px-2 link-dark">客服中心</a></li>
				<c:if test="${userInformation.role == 3}">
					<li><a href="${contextRoot}/backstage"
						class="nav-link px-2 link-dark">後台管理</a></li>
				</c:if>
			</ul>

			<!-- 學生才顯示購物車 -->
			<c:if test="${userInformation.role != 1}">
				<a class="nav-link text-dark text-decoration-none"
					href="${contextRoot}/shoppingCart"> <img
					src="${contextRoot}/img/cartIcon.png" height="20"> 購物車
				</a>
			</c:if>
			<c:if test="${!empty userInformation}">
				<div class="dropdown">
					<a id="showUserMessageBTN"
						class="text-dark text-decoration-none dropdown-toggle"
						href="${contextRoot}" role="button" id="dropdownMenuLink"
						data-bs-toggle="dropdown" aria-expanded="false"><img
						src="${contextRoot}/img/messageIcon.png" height="20">訊息通知</a>
					<ul id="messageBox" class="dropdown-menu p-4 text-muted"
						style="width: 400px;" aria-labelledby="dropdownMenuLink">
					</ul>
				</div>
			</c:if>
			<!-- 老師才顯示我的課程 -->
			<c:if test="${userInformation.role == 1}">
				<a class="nav-link text-dark text-decoration-none"
					href="${contextRoot}/course/uploaded/profile"> <img
					src="${contextRoot}/img/codingIcon.png" height="20">我的課程
				</a>
			</c:if>
			<!-- 學生才顯示我的學習 -->
			<c:if test="${userInformation.role == 2}">
				<a class="nav-link text-dark text-decoration-none"
					href="${contextRoot}/course/own/show"> <img
					src="${contextRoot}/img/codingIcon.png" height="20">我的學習
				</a>
			</c:if>

			<div class="dropdown text-end">
				<!-- 尚未登入 -->
				<c:if test="${empty userInformation}">
					<a class="NavLink" href="${contextRoot}/member/login">
						<button class="btn btn-primary ">登入</button>
					</a>
					<a class="NavLink" href="${contextRoot}/member/add">
						<button class="btn signUpBTN">註冊</button>
					</a>
				</c:if>
				<!-- 會員登入 -->
				<c:if test="${!empty userInformation}">
					<a href="#"
						class="nav d-block link-dark text-decoration-none dropdown-toggle"
						id="dropdownUser1" data-bs-toggle="dropdown" aria-expanded="false">
						<img src="data:image/jpeg;base64,${userInformation.base64Photo}"
						width="35" height="35" class="rounded-circle me-1"> <span>${userInformation.name}</span>
					</a>

					<ul class="dropdown-menu text-small"
						aria-labelledby="dropdownUser1">
						<li><a class="dropdown-item"
							href="${contextRoot}/member/edit">會員資訊</a></li>
						<!-- 老師才顯示已上傳課程 -->
						<c:if test="${userInformation.role == 1}">
							<li><a class="dropdown-item"
								href="${contextRoot}/course/uploaded/profile">已上傳課程</a></li>
						</c:if>
						<!-- 學生才顯示已收藏課程跟已購買課程 -->
						<c:if test="${userInformation.role == 2}">
							<li><a class="dropdown-item"
								href="${contextRoot}/course/favorite">已收藏課程</a></li>

							<li><a class="dropdown-item"
								href="${contextRoot}/order/show">已購買課程</a></li>
						</c:if>
						<li><a class="dropdown-item"
							href="${contextRoot}/customerservice/allMessages">客服紀錄</a></li>
						<li><a class="dropdown-item"
							href="${contextRoot}/customerservice/chat/${userInformation.name}">線上客服</a></li>
						<li>
							<hr class="dropdown-divider">
						</li>
						<li><a class="dropdown-item"
							href="${contextRoot}/member/logout">登出</a></li>
					</ul>
				</c:if>
			</div>
		</div>
	</div>
</header>
<!-- Bootstrap v4.6.2 JS -->
<script src="${contextRoot}/js/common/bootstrap.bundle.min.js"></script>
<!-- jQuery -->
<script src="${contextRoot}/js/common/jquery-3.6.0.min.js"></script>
<script>
    function messagesAjax() {
	let urlString = '${contextRoot}/member/message/${userInformation.id}/show';
	$
		.ajax({
		    type : "GET",
		    url : urlString,
		    dataType : 'json',
		    success : function(result) {
			$("#messageBox").html("");
			let message = "";
			$
				.each(
					result,
					function(i, item) {
					    message += '<div class="row">';
					    message += '<div class="col-10">'
						    + item.message + '</div>';
					    message += '<div class="col-1 text-start"><button type="button" class="btn btn-outline-danger"><img src="${contextRoot}/img/trashIcon.png" height="20"></button></div>';
					    message += '<div class="col-1"></div>';
					    message += '</div><hr>';
					});
			$("#messageBox").append(message);
		    }
		});
    }
    if ("${userInformation.id}" != "") {
	window.onload = function() {
	    messagesAjax();
	}
    }

    $("#showUserMessageBTN").click(function() {
	messagesAjax();
    });
    function messagesAjax() {
	let urlString = '${contextRoot}/member/message/${userInformation.id}/show';
	$
		.ajax({
		    type : "GET",
		    url : urlString,
		    dataType : 'json',
		    success : function(result) {
			$("#messageBox").html("");
			let message = "";
			$
				.each(
					result,
					function(i, item) {
					    message += '<div class="row">';
					    message += '<div class="col-10">'
						    + item.message + '</div>';
					    message += '<div class="col-1 text-start"><button type="button" class="btn btn-outline-danger"><img src="${contextRoot}/img/trashIcon.png" height="20"></button></div>';
					    message += '<div class="col-1"></div>';
					    message += '</div><hr>';
					});
			$("#messageBox").append(message);
		    }
		});
    }
    if ("${userInformation.id}" != "") {
	window.onload = function() {
	    messagesAjax();
	}
    }

    $("#showUserMessageBTN").click(function() {
	messagesAjax();
    });
</script>
