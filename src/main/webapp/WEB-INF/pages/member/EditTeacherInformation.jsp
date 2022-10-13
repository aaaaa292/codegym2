<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%-- <%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%> --%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%-- <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%> --%>

<%-- <c:set var="contextRoot" value="${pageContext.request.contextPath}" /> --%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>老師資訊</title>
<c:set var="contextRoot" value="${pageContext.request.contextPath}" />
<!-- web icon -->
<link rel="icon" href="${contextRoot}/img/member/icon.png">

<!-- ~~~抓這裡~~~-->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-gH2yIJqKdNHPEq0n4Mqa/HGKIhSkIHeL5AyhkYV8i59U5AR6csBvApHHNl/vI1Bx"
	crossorigin="anonymous">


<!-- !!!!!Font Awesome -->
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"
	rel="stylesheet" />
<link href="${contextRoot}/css/member/bootstrap.min.css"
	rel="stylesheet">


<!-- Google Fonts -->
<link
	href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700&display=swap"
	rel="stylesheet" />
<!-- MDB -->
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/4.4.0/mdb.min.css"
	rel="stylesheet" />
<!-- ~~~抓這裡~~~-->

<style>
body {
	font-family: "Helvetica Neue", Helvetica, Arial, sans-serif;
	font-size: 13px;
	color: #555;
	background: #ececec;
	margin-top: 20px;
}

.nav.nav-tabs-custom-colored>li.active>a, .nav.nav-tabs-custom-colored>li.active>a:hover,
	.nav.nav-tabs-custom-colored>li.active>a:focus {
	background-color: #296EAA;
	color: #fff;
	cursor: pointer;
}

.tab-content.profile-page {
	padding: 35px 15px;
}

.profile .user-info-left {
	text-align: center;
}

.profile .user-info-left, .profile .user-info-right {
	padding: 10px 0;
}

.profile .user-info-left img {
	border: 3px solid #fff;
	width: 100%;
}

.profile .user-info-left h2 {
	font-family: "Helvetica Neue", Helvetica, Arial, sans-serif;
	font-size: 1.3em;
	margin-bottom: 20px;
}

.user-info-left .btn {
	border-radius: 0px;
}

.profile .user-info-left ul.social a {
	font-size: 20px;
	color: #b9b9b9;
}

.profile .user-info-right {
	border-left: 1px solid #ddd;
	padding-left: 30px;
}

.profile h3, .activity h3, .settings h3 {
	font-family: "Helvetica Neue", Helvetica, Arial, sans-serif;
	font-size: 1.2em;
	margin-top: 0;
	margin-bottom: 20px;
}

.data-row .data-name, .data-row .data-value {
	display: inline-block;
	vertical-align: middle;
	padding: 5px;
}

.data-row .data-name {
	width: 14em;
	color: #FFFFFF;
	background-color: #4F4F4F;
	border-color: 	#4F4F4F;
	font-size: 1em;
	vertical-align: top;
}

ul.activity-list>li:not(:last-child) {
	border-bottom: 1px solid #ddd;
}

ul.activity-list>li {
	padding: 15px;
}

ul.activity-list>li .activity-icon {
	display: inline-block;
	vertical-align: middle;
	-moz-border-radius: 30px;
	-webkit-border-radius: 30px;
	border-radius: 30px;
	width: 34px;
	height: 34px;
	background-color: #e4e4e4;
	font-size: 16px;
	color: #656565;
	line-height: 34px;
	text-align: center;
	margin-right: 10px;
}

fieldset {
	margin-bottom: 40px;
}

hr {
	border-top-color: #ddd;
}

.form-horizontal .control-label {
	text-align: left;
}

.form-control, .input-group .form-control {
	-moz-border-radius: 0;
	-webkit-border-radius: 0;
	border-radius: 0;
	-moz-box-shadow: none;
	-webkit-box-shadow: none;
	box-shadow: none;
}
.center {
    padding: 70px 0;
    border: 3px ;
}
</style>
</head>

<body>

<!-- 導覽列 -->
<jsp:include page="../common/navigate.jsp" />
<!-- main -->
<div class="container-fluid pt-3 pb-5">
	<div class="d-flex justify-content-center">
	
		<div class="col-2 mx-3">		
			<div class="user-info-left text-center">
				<img src="data:image/jpeg;base64,${userInformation.base64Photo}">
				<h2>
					${userInformation.name}<i class=""></i>
				</h2>
				<div class="mx-auto">
					<h6>專長</h6>
					<input type="hidden" value="${teacherExpertise.expertise}"
						id="aaa" />
					<div id="add"></div>
					<a href="javascript:void();" class="badge badge-dark badge-pill"></a>
					<hr>
				</div>
			</div>
			
			<div class="nav justify-content-center">
				<div class="row">
					<div class="col-3 mx-2 text-center">
						<h4>154</h4>
						<small>Projects</small>
					</div>
				</div>
				<div class="col-3 mx-2 text-center">
					<h4>2.2k</h4>
					<small>Followers</small>
				</div>
				<div class="col-3 mx-2 text-center">
					<h4>9.1k</h4>
					<small>Views</small>
				</div>
			</div>
		</div><!-- end col -->
		
		<form id="create_customer" method="post" action="${contextRoot}/member/edit/editTeacherInfo" enctype="multipart/form-data">
		<div class="w-100 mx-3">
			<div class="user-info-right">
				<h3><i class="fa fa-square"></i>老師資訊</h3>
				
				<div class="">
					<div class="form-outline mb-4">
						<input type="text" id="userId" class="form-control" name="userId"
							   value="${userInformation.id}" hidden/>							   
						<p class="data-row">
							<lable class="data-name">老師名稱:</lable>
							<span class="data-value">
								<input type="text" id="name" class="form-control" name="name"
									   value="${userInformation.name}" style="width: 140%"/>
							</span>
						</p>
					</div>
				</div>

				<div class="col-auto">
					<div class="form-outline mb-4">
						<p class="data-row">
							<lable class="data-name">電子郵件:</lable>
							<span class="data-value">
								<input type="text" id="name" class="form-control" name="email"
									   value="${userInformation.email}" style="width: 140%"/>
							</span>
						</p>
					</div>
				</div>
				
				<div class="col-auto">
					<div class="form-outline mb-4">
						<p class="data-row">
							<lable class="data-name">密碼:</lable>
							<span class="data-value">
								<input type="password" id="password" class="form-control" name="password"
									   value="${userInformation.password}" style="width: 140%"/>
							</span>
						</p>
					</div>
				</div>
				
				<div class="col-auto">
					<div class="form-outline mb-4">
						<p class="data-row">
							<lable class="data-name">電話號碼:</lable>
							<span class="data-value">
								<input type="text" id="name" class="form-control" name="phone"
								  	   value="${userInformation.phone}" style="width: 140%"/>
							</span>
						</p>
					</div>
				</div>
				
				<div class="col-auto">
					<div class="form-outline mb-4">
						<p class="data-row">
							<lable class="data-name">專長:</lable>
							<span class="data-value">
								<input type="text" id="expertise" class="form-control" name="expertise"
									   value="${teacherExpertise.expertise}" style="width: 140%"/>
							</span>
						</p>
					</div>
				</div>
				
				<div class="col-auto">
					<div class="form-outline mb-4">
						<p class="data-row">
							<lable class="data-name">學經歷</lable>
							<span class="data-value">
								<input type="text" id="experience" class="form-control" name="experience"
									   value="${teacherExpertise.experience}" style="width: 140%"/>
							</span>
						</p>
					</div>
				</div>
				
				<div class="col-auto">
					<div class="form-outline mb-4">
						<p class="data-row">
							<lable class="data-name">教學特色</lable>
							<span class="data-value">
								<input type="text" id=" teaching" class="form-control" name=teaching
									   value="${teacherExpertise.teaching}" style="width: 140%"/>
							</span>
						</p>
					</div>
				</div>

				<div>
					<button type="submit" id="modifyBTN" class="btn btn-primary">修改</button>
				</div>
			</div><!-- end div.user-info-right -->
		</div><!-- end col -->
		</form>
	</div><!-- end row -->
</div><!-- end container-fluid -->

	<jsp:include page="../common/footer.jsp" />
	<script type="text/javascript">
		// 		function splitWord(){
		// 			var split =  ${teacherExpertise.expertise};
		// 			colsole.log(split);
		// 		}
		$(document)
				.ready(
						function() {
							let aaa = $("#aaa").val(); // '1,2,3,4' str
							let b = aaa.split(",") //[1,2,3,4] arr
							let str = "";
							for (let i = 0; i < b.length; i++) {
								str += '<a href="javascript:void();" class="badge badge-dark badge-pill">'
										+ b[i] + '</a>&nbsp'
							}
							$("#add").append(str);
						});
	</script>

</body>

</html>