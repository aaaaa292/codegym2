<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>已上傳課程</title>
<c:set var="contextRoot" value="${pageContext.request.contextPath}" />

<!-- web icon -->
<link rel="icon" href="${contextRoot}/img/icon.png" />
<!-- dataTable CSS -->
<link rel="stylesheet"
	href="${contextRoot}/css/common/jquery.dataTables.min.css" />
</head>
</head>
<body>
	<jsp:include page="../common/navigate.jsp" />
	<div class="container-fluid" id="wrapper">
		<table id="uploadCourseTable" class="display">
			<thead>
				<tr>
					<th>上傳時間</th>
					<th>老師名稱</th>
					<th>課程名稱</th>
					<th>課程標籤</th>
					<th>課程價格</th>
					<th>審核通過</th>
					<th>學生資訊</th>
					<th>收益總額</th>
					<th>修改課程</th>
					<th>課程內容</th>
					<th>刪除課程</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${courseProfileList}" var="courseProfile">
					<tr>
						<td>${courseProfile.time}</td>
						<td>${courseProfile.userInformation.name}</td>
						<td><a href="${contextRoot}/course/${courseProfile.id}/show"
							class="d-flex align-items-center mb-2 mb-lg-0 text-dark text-decoration-none">
								<button type="button" class="btn btn-secondary"
									style="width: 100%;">${courseProfile.name}</button>
						</a></td>
						<td><c:forEach items="${courseProfile.courseTags}" var="t">
								<span class="badge bg-primary">${t.tag}</span>
							</c:forEach></td>
						<td>${courseProfile.price}</td>

						<!-- 判斷通過審核比例 -->
						<c:set var="totalStatus" value="${0}" />
						<c:set var="passStatus" value="${0}" />
						<c:forEach items="${courseProfile.courseChapters}"
							var="courseChapter">
							<c:forEach items="${courseChapter.courseDetails}"
								var="courseDetail">
								<c:if test="${courseDetail.status == 1}">
									<c:set var="passStatus" value="${passStatus + 1}" />
									<c:set var="totalStatus" value="${totalStatus + 1}" />
								</c:if>
								<c:if test="${courseDetail.status == 0}">
									<c:set var="totalStatus" value="${totalStatus + 1}" />
								</c:if>
							</c:forEach>
						</c:forEach>
						<td>${(passStatus/totalStatus) * 100}% (${passStatus}/${totalStatus})</td>
						
						<!-- 學生數量及清單 --> 
						<c:set var="numOfStudents" value="${0}" />
						<c:set var="income" value="${0}" />
						<c:forEach items="${courseProfile.orderItems}" var="item">
							<c:set var="numOfStudents" value="${numOfStudents + 1}" />
						</c:forEach>
						<td><a
							href="${contextRoot}/course/${courseProfile.id}/students/show"
							class="d-flex align-items-center mb-2 mb-lg-0 text-dark text-decoration-none">
								[${numOfStudents}位] <button type="button" class="btn btn-success">名單</button>
						</a></td>
						<!-- 計算收益總額 --> 
						<td>${numOfStudents * courseProfile.price}</td>
						
						<td><a
							href="${contextRoot}/course/edit/profile/${courseProfile.id}"
							class="d-flex align-items-center mb-2 mb-lg-0 text-dark text-decoration-none">
								<button type="button" class="btn btn-info">編輯</button>
						</a></td>
						<td><a
							href="${contextRoot}/course/uploaded/${courseProfile.id}/detail"
							class="d-flex align-items-center mb-2 mb-lg-0 text-dark text-decoration-none">
								<button type="button" class="btn btn-warning">內容</button>
						</a></td>
						<td>
							<button type="button" class="btn btn-danger">刪除</button>
						</td>
					</tr>
				</c:forEach>
		</table>
	</div>
	<jsp:include page="../common/footer.jsp" />
	<!-- dataTable JS -->
	<script src="${contextRoot}/js/common/jquery.dataTables.min.js"></script>
	<script>
	$(document).ready(function() {
	    $("#uploadCourseTable").DataTable({
		order : [ 0, "asc" ],
	    });
	});
    </script>
</body>
</html>