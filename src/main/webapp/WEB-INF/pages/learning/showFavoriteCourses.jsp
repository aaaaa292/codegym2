<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>已收藏課程</title>
<c:set var="contextRoot" value="${pageContext.request.contextPath}" />

<!-- web icon -->
<link rel="icon" href="${contextRoot}/img/icon.png" />
<!-- dataTable CSS -->
<link rel="stylesheet"
	href="${contextRoot}/css/common/jquery.dataTables.min.css" />
</head>

<body>
	<jsp:include page="../common/navigate.jsp" />
	<div class="container-fluid" id="wrapper">
		<table id="favoriteCourseTable" class="display">
			<thead>
				<tr>
					<th>課程連結</th>
					<th>上課老師</th>
					<th>章節名稱</th>
					<th>影片名稱</th>
					<th>課程標籤</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${favoriteCourses}" var="favoriteCourse">
					<tr>
					
					<td><a
							href="${contextRoot}/course/${favoriteCourse.courseDetail.courseChapter.courseProfile.id}/show"
							class="d-flex align-items-center mb-2 mb-lg-0 text-dark text-decoration-none">
								<button type="button" class="btn btn-secondary"
									style="width: 100%;">${favoriteCourse.courseDetail.courseChapter.courseProfile.name}</button>
						</a></td>
						<td>${favoriteCourse.courseDetail.courseChapter.courseProfile.userInformation.name}</td>
						<td>${favoriteCourse.courseDetail.courseChapter.name}</td>
						<td>${favoriteCourse.courseDetail.courseChapter.number}-${favoriteCourse.courseDetail.section}
							${favoriteCourse.courseDetail.name}</td>
						<td><c:forEach
								items="${favoriteCourse.courseDetail.courseChapter.courseProfile.courseTags}"
								var="t">
								<span class="badge bg-primary">${t.tag}</span>
							</c:forEach></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
	<jsp:include page="../common/footer.jsp" />
	<!-- dataTable JS -->
	<script src="${contextRoot}/js/common/jquery.dataTables.min.js"></script>
	<script>
	$(document).ready(function() {
	    $("#favoriteCourseTable").DataTable({
		order : [ 0, "asc" ],
	    });
	});
    </script>
</body>
</html>