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
<script>
var userId = "${sessionScope.userId }";
console.log("userId:",userId);
</script>
</head>

<header class="p-3 mb-3">
	<div class="container">
		<div
			class="d-flex flex-wrap align-items-center justify-content-center justify-content-lg-start">
			<a href="/"
				class="d-flex align-items-center mb-2 mb-lg-0 text-dark text-decoration-none">
				<svg class="bi me-2" width="40" height="32" role="img"
					aria-label="Bootstrap">
						<use xlink:href="#bootstrap"></use></svg>
			</a>

			<!-- 導覽選項 -->
			<ul
				class="nav col-12 col-lg-auto me-lg-auto mb-2 justify-content-center mb-md-0">
				<li><a href="${contextRoot}/"
					class="nav-link px-2 link-secondary">線上程式語言課程</a></li>
				<li><a href="${contextRoot}/course/show"
					class="nav-link px-2 link-dark">瀏覽課程</a></li>

				<li><a href="${contextRoot}/course/add"
					class="nav-link px-2 link-dark">上架課程</a></li>

				<li><a href="${contextRoot}/post/showAllPosts"
					class="nav-link px-2 link-dark">文章專區</a></li>
				<li><a href="${contextRoot}/customerservice/addCusMessage"
					class="nav-link px-2 link-dark">客服中心</a></li>
				<li><a href="${contextRoot}/backstage"
					class="nav-link px-2 link-dark">後台管理</a></li>
			</ul>
			<!-- 導覽選項 -->
<!-- 			<ul -->
<!-- 				class="nav col-12 col-lg-auto me-lg-auto mb-2 justify-content-center mb-md-0"> -->

<%-- 				<li><a href="${contextRoot}/" class="nav-link px-2 link-secondary">線上程式語言課程</a></li> --%>
<%-- 				<li><a href="${contextRoot}/post/showAllPosts" class="nav-link px-2 link-dark">文章專區</a></li> --%>
<%-- 				<li><a href="${contextRoot}/post/addPost" class="nav-link px-2 link-dark">投稿文章</a></li> --%>
<%-- 				<li><a href="${contextRoot}/comment/showAllComments" class="nav-link px-2 link-dark">回文檢視區</a></li>				 --%>
<%-- 				<li><a href="${contextRoot}/post/showAllPostsTest" class="nav-link px-2 link-dark">發文版改</a></li> --%>
<%-- 				<li><a href="${contextRoot}/post/ckEditDemo" class="nav-link px-2 link-dark">CkEdit</a></li> --%>
<!-- 			</ul> -->
			

			<!-- 會員登入/登入成功圖案 -->
			<a class="NavLink" href="">
					<button class="btn signUpBTN">購物車</button>
				</a>
			<div class="dropdown text-end">
				
				<c:if test="${empty userInformation}">
					<a class="NavLink" href="${contextRoot}/member/login">
						<button class="btn btn-primary ">登入</button>
					</a>
					<a class="NavLink" href="${contextRoot}/member/add">
						<button class="btn signUpBTN" >註冊</button>
					</a>
				</c:if>
				<c:if test="${!empty userInformation}">
					<a href="#"
						class="nav d-block link-dark text-decoration-none dropdown-toggle"
						id="dropdownUser1" data-bs-toggle="dropdown" aria-expanded="false">
						<img src="data:image/jpeg;base64,${base64String}" width="45"
						height="45" class="rounded-circle">
						<span>${userInformation.name}</span>
					</a>
					<ul class="dropdown-menu text-small"
						aria-labelledby="dropdownUser1">
						<li><a class="dropdown-item" href="#">會員資訊(建置中)</a></li>
						<li><hr class="dropdown-divider"></li>
						<li><a class="dropdown-item"
							href="${contextRoot}/member/logout">登出</a></li>
					</ul>
				</c:if>
			</div>
			<!-- 會員登入/登入成功圖案 -->

		</div>
	</div>
</header>