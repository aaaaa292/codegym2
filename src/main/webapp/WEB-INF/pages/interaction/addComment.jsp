<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<c:set var="contextRoot" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>回覆發文</title>
</head>
<jsp:include page="layout/navbarPostView.jsp" />
<body>

	
	
	<div class="container">

		<div class="row justify-content-center">
			<div class="col-8">
				<h1>回覆發文頁面</h1>
				<div class="card">
					<div class="card-header">回覆發文</div>
					<div class="card-body">
						<form class="form" method="post"
							action="${contextRoot}/comment/insertComment">
							<input name="postId" type="hidden" value="${post.id}" /> 
							回覆內容
							<textarea name="comment" class="form-control"></textarea>

							<button type="submit" class="btn btn-primary">送出發文</button>
						</form>
					</div>
				</div>
			</div>
		</div>

		<!-- 		<div class="row justify-content-center"> -->
		<!-- 			<div class="col-8"> -->
		<!-- 				<div class="card"> -->
		<!-- 					<div class="card-header"> -->
		<!-- 						<div class="card-header"> -->
		<%-- 							上個回文時間 <span><fmt:formatDate --%>
		<%-- 									pattern="yyyy/MM/dd HH:mm:ss EEEE" value="${lastestPost.time}" /></span> --%>
		<!-- 						</div> -->
		<%-- 						<div class="card-body">上個回文標題:${lastestComment.comment}</div> --%>
		<!-- 					</div> -->
		<!-- 				</div> -->
		<!-- 			</div> -->

		<!-- 		</div> -->

	</div>

</body>
</html>