<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="contextRoot" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<!-- 導覽列 -->
<jsp:include page="../common/navigate.jsp" />

<div class="container">
	<div class="row justify-content-center">
		<div class="col-5">
			<h1 class="mt-5 mb-5">修改類別名稱</h1>
			
			<form:form class="form" method="post" enctype="multipart/form-data" action="${contextRoot}/customerservice/editType">
			
				<input type="hidden" name="id" value="${questionTypes.id }">
			
				<div class="form-group">
					<label for="recipient-name" class="col-form-label">分類名稱</label>
					<input type="text" name="type" class="form-control" id="recipient-name" value="${questionTypes.type }">
				</div>
				<div>
					<label for="recipient-name" class="col-form-label">圖片</label>
				</div>
				<div class="form-group">
					<input type="file" name="imageData" value="${questionTypes.imagePath }" class="form-control">
				</div>
				
				<div class="mt-4">
					<button type="submit" class="btn btn-warning me-2">修改</button>
					<a href="${contextRoot}/customerservice/showAllTypes">
						<button type="button" class="btn btn-secondary">取消</button>
					</a>
				</div>	
			</form:form>
			
		</div><!-- end col -->
	</div><!-- end row -->
</div><!-- end container -->
	
</body>
</html>