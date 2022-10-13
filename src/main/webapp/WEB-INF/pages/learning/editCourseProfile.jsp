<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>編輯課程</title>

<c:set var="contextRoot" value="${pageContext.request.contextPath}" />

<!-- web icon -->
<link rel="icon" href="${contextRoot}/img/icon.png" />
</head>
<body>
	<jsp:include page="../common/navigate.jsp" />
	<div class="container">
		<main class="form-signin m-5">
			<div style="color: red">${message}</div>
			<h3>編輯[${courseProfile.name}]</h3>

			<form id="mainForm" action="${contextRoot}/course/edit/profile/result/${courseProfile.id}"
				method="post" enctype="multipart/form-data">
				<div class="row">
					<div class="form-floating col-6">
						<img
							src="${contextRoot}/course/getImg?courseId=${courseProfile.id}"
							width="100%">
					</div>
					<div class="form-floating col-6">
						<button type="button" class="btn btn-dark">更新課程封面</button>
					</div>
				</div>
				<br>
				<div class="row">
					<div class="form-floating col-3">
						<input id="courseName" name="courseName" type="text"
							value="${courseProfile.name}" class="form-control" required>
						<label>課程名稱</label>
					</div>
					<div class="form-floating col-1">
						<input id="coursePrice" name="coursePrice" type="number"
							value="${courseProfile.price}" class="form-control" min="0"
							required> <label>課程價格</label>
					</div>

				</div>
				<br>
				<div class="row">
					<div class="form-floating col-12">
						<input id="courseIntroduction" name="courseIntroduction"
							type="text" value="${courseProfile.introduction}"
							class="form-control" required> <label>課程介紹</label>
					</div>
				</div>
				<br>
				<div class="row align-items-center ">
					<div class="col-12 form-floating text-center">
						<a href="${contextRoot}/course/uploaded/profile"
							class="text-decoration-none">
							<button type="button" class="btn btn-secondary">返回</button>
						</a>
						<button type="submit" class="btn btn-info">編輯完成</button>
					</div>
				</div>
			</form>
		</main>
	</div>
</body>
</html>