<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<jsp:include page="../common/navigate.jsp" />
<!DOCTYPE html>
<html>
<head>
<c:set var="contextRoot" value="${pageContext.request.contextPath}" />
<meta charset="UTF-8">
<title>付款成功</title>
</head>
<body>
	<div class="col d-flex justify-content-center" style="padding-top:100px">
		<div class="card text-center" style="width: 35rem; padding-top: 30px;">
			
			<div class="col justify-content-center d-flex" style="width: 100px; object-fit: contain; margin: auto; padding-bottom:20px;">
				<img src="${contextRoot}/img/order/check.png" class="card-img">
			</div>
			<div class="card-body" style="background-color: #EAC100">
					<ul class="list-group list-group-flush">
						<li class="list-group-item"><h5 class="card-title">感謝您的購買!</h5></li>
						<li class="list-group-item"><p class="card-text">付款成功，祝您學習愉快!</p></li>
					</ul>
					<div class="card-footer justify-content-between d-flex" style="padding-top: 20px">
						<a href="${contextRoot}/course/show" class="btn btn-success">看看其他課程</a>
                        <a href="${contextRoot}/order/show" class="btn btn-success">查看明細</a>
					</div>
				</div>
			</div>
		</div>



</body>
</html>