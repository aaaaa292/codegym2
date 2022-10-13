<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	<jsp:include page="../common/navigate.jsp" />
<!-- 開啟新的一頁。這些東西都要複製，不能功能會失效 起始 -->
	<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!-- 開啟新的一頁。這些東西都要複製，不能功能會失效 結束-->
<!DOCTYPE html>
<html>
<head>
<!-- 開啟新的一頁。這些東西都要複製，不能功能會失效 起始 -->
	<c:set var="contextRoot" value="${pageContext.request.contextPath}" />
<!-- 開啟新的一頁。這些東西都要複製，不能功能會失效 結束-->


<meta charset="UTF-8">
<title></title>
<link rel="stylesheet" href="${contextRoot}/member/forgotPassword">

</head>
<body>
	<div class="box">
		<div class="container">
			<H5>忘記密碼</H5>
			<form method="post" action="${contextRoot}/member/changepassword">
				<div>
					<label for="email">請輸入您的Email</label> 
					<input type="email" class="form-control" id="email" name="email" placeholder="請輸入您的E-MAIL" required>
					<div class="valid-feedback"></div>
					<div class="invalid-feedback">這不是有效的email</div>
				</div>
				<button type="submit" class="btn btn-primary">確認送出</button>
			</form>
		</div>
	</div>

</body>

</html>
