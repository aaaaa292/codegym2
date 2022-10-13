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
<title>loginError</title>
<link rel="stylesheet" href="${contextRoot}/pages/loginError">

</head>
<body>
<H5>認證失敗</H5>
	<div>請重新輸入</div>


  	<button type="submit" class="btn btn-primary" onclick="window.location.assign('${contextRoot}/member')">會員登入</button> 
</body>

</html>
