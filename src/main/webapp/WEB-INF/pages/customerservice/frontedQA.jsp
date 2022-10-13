<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="contextRoot" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${questionType.type}</title>
<!-- aos動ㄏ -->
<link rel="stylesheet" href="https://unpkg.com/aos@next/dist/aos.css" />
<!-- 自訂義css -->
<link rel="stylesheet" href="${contextRoot}/css/customerservice/frontQA.css">
</head>
<body>
	<!-- 導覽列 -->
<jsp:include page="../common/navigate.jsp" />

<div class="container qaContainer mt-1 mb-3 w-50" id="wrapper">

	<div class="row qaRow">
		<div class="mt-3 mb-2">
			<p>
				<a href="${contextRoot}/customerservice">常見FQA</a>　>　<span>${questionType.type}</span>		
			</p>
		</div>
	</div>
	
	<div class="row">
		<div class="col-4 imgContent">
			<img src="${contextRoot}/customerservice/getImg?typeId=${questionType.id}" class="typeImg">
		</div>
		<div class="col-8 ps-5">
			<h2 class="pt-5">${questionType.type}</h2>
			<p>
				如有任何疑問，歡迎留下訊息與我們聯絡，謝謝。
				<a href="${contextRoot}/customerservice/addCusMessage">
				<button class="btn btn-sm btn-outline-success mb-1">聯絡我們</button></a>
			</p>
		</div>
	</div>
		
	<div class="col" style="overflow: hidden;">
		<c:forEach var="questionAnswers" items="${questionType.questionAnswers}">
			<a class="qaType" href="${contextRoot }/customerservice/OneQA/${questionAnswers.id}">
				<div class="card py-4 px-5">
					<div class="mt-3">
						<h5>
							<b>${questionAnswers.question }</b>
						</h5>
						<p style="font-size: 14px;">
							<fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss"
							value="${questionAnswers.time }"></fmt:formatDate>
						</p>
					</div>		
				</div>
			</a>
		</c:forEach>
	</div>
</div>
<jsp:include page="../common/footer.jsp" />

</body>
</html>