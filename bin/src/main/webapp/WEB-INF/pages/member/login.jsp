<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- 開啟新的一頁。這些東西都要複製，不能功能會失效 起始 -->
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!-- 開啟新的一頁。這些東西都要複製，不能功能會失效 結束-->



<!DOCTYPE html>
<html>
<head>
<!-- 開啟新的一頁。這些東西都要複製，不能功能會失效 起始 -->
<c:set var="contextRoot" value="${pageContext.request.contextPath}" />
<!-- 開啟新的一頁。這些東西都要複製，不能功能會失效 結束-->

<meta charset="UTF-8">
<title>會員登入</title>
<!-- web icon -->
<link rel="icon" href="${contextRoot}/img/member/icon.png">
<style type="text/css">
div.box{
	height: 550px;
}
</style>
</head>

<body>
<jsp:include page="../common/navigate.jsp" />		
<div class="box">
	<div class="container">
		<div class="row justify-content-center d-flex" style="margin-top:200px">
			<div class="col" style="width: 200px; height: 500px;" > 
				<img src="${contextRoot}/img/member/b.jpg"  style="width: 100%;"/>
			</div>
	
	          
			<div class="col">
				<h1>會員登入</h1>
				<form id="customer_UserInformation" class="needs-validation"
					method="post" action="${contextRoot}/member/login/check">
					<div>
						<label for="email">電子郵件</label> <input type="email"
							class="form-control" id="email" name="email"
							placeholder="請輸入您的E-MAIL" required>
						<div class="valid-feedback"></div>
						<div class="invalid-feedback">這不是有效的email</div>
					</div>
					
					<div>
						<label for="password">密碼</label> <input type="password"
							class="form-control" id="password" name="password"
							placeholder="請輸入您的密碼" required>
						<div class="valid-feedback"></div>
						<div class="invalid-feedback">密碼需6位以上</div>
					</div>
					<br>
				
					<div class="row">
						<div class="col">
							<button class="btn btn-primary" type="submit">會員登入</button>
						</div>
					</div>	
					
				</form>
				
				<div class="form_footer d-flex p-3">
					<a class="col" href="${contextRoot}/member/forgotPassword">
						<i class="fa fa-key" aria-hidden="true"></i>忘記密碼
					</a>
					
					<a class="col" href="${contextRoot}/member/add">
						<i class="fa fa-user" aria-hidden="true"></i>註冊新會員
					</a>
					
					
				</div>
				<!-- 一鍵輸入 -->
				<div class="form_footer " style="text-align: right;">
				<button class="btn btn-primary fastLogin" id="administrator">管理員</button>
				<button class="btn btn-primary fastLogin" id="student1">學生:陳俊宇</button>
				<button class="btn btn-primary fastLogin" id="student2">學生:陳同學</button>
				<button class="btn btn-primary fastLogin" id="teacher1">老師:曾老師</button>
				<button class="btn btn-primary fastLogin" id="teacher2">老師:蔡老師</button>
<!-- 				<button class="btn btn-primary fastLogin">Emma</button> -->
<!-- 				<button class="btn btn-primary fastLogin">Jim</button> -->
				</div>
			</div>
			
		</div>
	</div>

</div>

<jsp:include page="../common/footer.jsp" />

<script type="text/javascript">
	
	//快速登入-管理員
	$("#administrator").click(function() {
		$("#email").val("s9jacky@gmail.com");
		$("#password").val("1234");
	});
	//快速登入-學生1
	$("#student1").click(function() {
		$("#email").val("chunyuchen1217@gmail.com");
		$("#password").val("1234");
	});
	//快速登入-學生2
	$("#student2").click(function() {
		$("#email").val("coolchenyen@gmail.com");
		$("#password").val("1234");
	});
// 	快速登入-老師
	$("#teacher1").click(function() {
		$("#email").val("yc557430@gmail.com");
		$("#password").val("1234");
	});	
// 	快速登入-老師
	$("#teacher2").click(function() {
		$("#email").val("jerry@gmail.com");
		$("#password").val("1234");
	});	
</script>
</body>
</html>

