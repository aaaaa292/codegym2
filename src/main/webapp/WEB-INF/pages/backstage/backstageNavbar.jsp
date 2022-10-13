<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>

<html>
<head>
<!-- web icon -->
<link rel="icon" href="${contextRoot}/img/icon.png">
<c:set var="contextRoot" value="${pageContext.request.contextPath}" />
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author"
	content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
<meta name="generator" content="Hugo 0.83.1">
<title>導覽列元素</title>

<!-- bootstrap 5.1.3 CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous">


<!-- Bootstrap v4.6.2 JS -->
<script src="${contextRoot}/js/common/bootstrap.bundle.min.js"></script>
<!-- jQuery -->
<script src="${contextRoot}/js/common/jquery-3.6.0.min.js"></script>

<!-- 自定義CSS -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/admin.css">

<style>
</style>


<!-- Custom styles for this template -->
<link href="dashboard.css" rel="stylesheet">
</head>
<body>
	<header
		class="navbar navbar-dark sticky-top bg-secondary flex-md-nowrap p-0 shadow">
		<a class="navbar-brand col-md-3 col-lg-2 me-0 px-3"
			href="${contextRoot}/"><h3>CodeGYM</h3></a>
		<button class="navbar-toggler position-absolute d-md-none collapsed"
			type="button" data-bs-toggle="collapse" data-bs-target="#sidebarMenu"
			aria-controls="sidebarMenu" aria-expanded="false"
			aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>

		<ul class="navbar-nav px-4">
			<li class="nav-item text-nowrap"><a class="nav-link"
				href="${contextRoot}/member/logout"><span data-feather="log-out"></span>登出</a></li>
		</ul>
	</header>
	<!-- 導覽選項 -->
	<div class="container-fluid">
		<div class="row">
			<nav id="sidebarMenu"
				class="col-md-3 col-lg-2 d-md-block bg-light sidebar collapse">
				<div class="position-sticky pt-3">
					<ul class="nav flex-column">
						<li class="nav-item"><a class="nav-link active"
							href="${contextRoot}/backstage" aria-current="page"> <span
								data-feather="home"></span> 回到首頁
						</a></li>

						<li class="nav-item"><a class="nav-link"
							href="${contextRoot}/customerservice/viewMessages"> <span
								data-feather="heart"></span> 顧客反饋
						</a></li>
						<li class="nav-item"><a class="nav-link"
							href="${contextRoot}/backstage/member"> <span
								data-feather="users"></span> 會員資料
						</a></li>
						<li class="nav-item"><a class="nav-link"
							href="${contextRoot}/backstage/interaction"> <span
								data-feather="bar-chart-2"></span> 討論管理
						</a></li>
						<li class="nav-item"><a class="nav-link"
							href="${contextRoot}/backstage/courses/showAll"> <span
								data-feather="check-circle"></span> 審核管理
						</a></li>
						<li class="nav-item"><a class="nav-link"
							href="${contextRoot}/backstage/order"> <span
								data-feather="dollar-sign"></span> 銷售相關
						</a></li>
						<li class="nav-item"><a class="nav-link"
							href="${contextRoot}/backstage/showAllmessage"> <span
								data-feather="message-circle"></span> 站內訊息
						</a></li>
						<li class="nav-item"><a class="nav-link"
							href="${contextRoot}/backstage/showDiscountCode"><span
								data-feather="gift"></span> 折扣代碼 </a></li>
						<li class="nav-item"><a class="nav-link"
							href="${contextRoot}/backstage/customerservice"> <span
								data-feather="file"></span> 常見問題
						</a></li>
						<li class="nav-item"><a class="nav-link"
							href="${contextRoot}/customerservice/chat"> <span
								data-feather="users"></span> 線上客服
						</a></li>
					</ul>

					<h6
						class="sidebar-heading d-flex justify-content-between align-items-center px-3 mt-4 mb-1 text-muted">
					</h6>
					<ul class="nav flex-column mb-2">
					</ul>
				</div>
			</nav>

			<main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
				<div
					class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">

				</div>
</body>
<script src="../assets/dist/js/bootstrap.bundle.min.js"></script>

<script
	src="https://cdn.jsdelivr.net/npm/feather-icons@4.28.0/dist/feather.min.js"
	integrity="sha384-uO3SXW5IuS1ZpFPKugNNWqTZRRglnUJK6UAZ/gxOX80nxEkN9NcGZTftn6RzhGWE"
	crossorigin="anonymous"></script>
<script
	src="https://cdn.jsdelivr.net/npm/chart.js@2.9.4/dist/Chart.min.js"
	integrity="sha384-zNy6FEbO50N+Cg5wap8IKA4M/ZnLJgzc6w2NqACZaK0u0FXfOWRRJOnQtpZun8ha"
	crossorigin="anonymous"></script>
<script src="dashboard.js"></script>

<!-- Bootstrap v4.6.2 JS -->
<script src="${contextRoot}/js/common/bootstrap.bundle.min.js"></script>
<!-- jQuery -->
<script src="${contextRoot}/js/common/jquery-3.6.0.min.js"></script>
</body>

<script type="text/javascript">
	(function() {
		feather.replace()
		// Graphs

		var ctx = document.getElementById('myChart')
		// eslint-disable-next-line no-unused-vars
		var myChart = new Chart(ctx, {
			type : 'line',
			options : {
				scales : {
					yAxes : [ {
						ticks : {
							beginAtZero : false
						}
					} ]
				},
				legend : {
					display : false
				}
			}
		})
	})()
</script>

</html>