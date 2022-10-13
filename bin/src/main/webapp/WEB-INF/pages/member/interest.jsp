<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <!-- 開啟新的一頁。這些東西都要複製，不能功能會失效 起始 -->
	<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!-- 開啟新的一頁。這些東西都要複製，不能功能會失效 結束-->
    
	<jsp:include page="../common/navigate.jsp" />
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- 開啟新的一頁。這些東西都要複製，不能功能會失效 起始 -->
<c:set var="contextRoot" value="${pageContext.request.contextPath}" />
<!-- 開啟新的一頁。這些東西都要複製，不能功能會失效 結束-->

<link rel="stylesheet" href="${contextRoot}/css/learning/addCourse.css">
</head>
<body>
	<h1>喜好填寫</h1>


	<!-- 表單開始 -->
	<hr class="divider">

<div class="container text-center">
	<form id="create_customer" class="border-style:groove;" method="post"
		action="${contextRoot}/member/addInterest" enctype="multipart/form-data">
		<div class="form-row">
				<div class="col mb-3">
				    <label for="checkbox">請勾選您所想要學習的課程</label>
				    <input type="checkbox" name="Interestcourses" value="HTML">HTML 
				 	<input type="checkbox"	name="Interestcourses" value="CSS">CSS 
					<input type="checkbox"	name="Interestcourses" value="JavaScript">JavaScript 
					<input type="checkbox" name="Interestcourses" value="JQuery">JQuery 
					<input type="checkbox" name="Interestcourses" value="Java">Java
					<input	type="checkbox" name="Interestcourses" value="Servlet">Servlet
					<input	type="checkbox" name="Interestcourses" value="Python">Python 
					<input type="checkbox" name="Interestcourses" value="PHP">PHP 
					<input type="checkbox" name="Interestcourses" value="MySQL">MySQL 
					<input type="checkbox" name="Interestcourses" value="sqlServer">SQL server
					<p>
				</div>
			</div>
			<div class="form-row">
				<div class="col mb-3">
					<label for="role">學程式時間?</label> 
					<input type="radio" name="learningexperience" value="1">1年以下 
					<input type="radio" name="learningexperience" value="2">1～3年
					<input type="radio" name="learningexperience" value="3">3年以上
					<p>
				</div>
			</div>
			<button type="submit" class="btn btn-primary">送出</button>
	</form>
	<a class="NavLink" href="${contextRoot}/member/interest"></a>
</div>


</body>

</html>
