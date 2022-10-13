<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>

<head>
	<meta charset="UTF-8" />
	<title>已上傳課程</title>

	<c:set var="contextRoot" value="${pageContext.request.contextPath}" />

	<!-- web icon -->
	<link rel="icon" href="${contextRoot}/img/icon.png" />
	<!-- dataTable CSS -->
	<link rel="stylesheet" href="${contextRoot}/css/common/jquery.dataTables.min.css" />
</head>

<body>
	<jsp:include page="../common/navigate.jsp" />
	<div class="container" id="wrapper">
		<div class="text-start">
			<a href="${contextRoot}/course/uploaded/profile"
				class="d-flex align-items-center mb-2 mb-lg-0 text-dark text-decoration-none">
				<button type="button" class="btn btn-outline-primary" style="margin-bottom: 5px;">返回</button>
			</a>
		</div>
		<table id="uploadCourseTable" class="display">
			<thead>
				<tr>
					<th>上傳時間</th>
					<th>課程名稱</th>
					<th>課程標籤</th>
					<th>章節名稱</th>
					<th>影片名稱</th>
					<th>觀看次數</th>
					<!-- <th>修改課程</th> -->
					<th>審核狀態</th>
					<th>刪除課程</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${courseProfile.courseChapters}" var="courseChapter">
					<c:forEach items="${courseChapter.courseDetails}" var="courseDetail">
						<tr>
							<c:if test="${courseDetail.status == 2}"></c:if>
							<td><span class="badge bg-dark">${courseDetail.time}</span></td>
							<td><a href="${contextRoot}/course/${courseProfile.id}/show"
									class="d-flex align-items-center mb-2 mb-lg-0 text-dark text-decoration-none">
									<button type="button" class="btn btn-secondary"
										style="width: 100%;">${courseProfile.name}</button>
								</a></td>

							<td>
								<c:forEach items="${courseProfile.courseTags}" var="t">
									<span class="badge bg-primary">${t.tag}</span>
								</c:forEach>
							</td>

							<td>${courseChapter.name}</td>
							<td>${courseChapter.number}-${courseDetail.section}
								${courseDetail.name}</td>
							<!-- 觀看次數 --> 
							<c:set var="views" value="${0}" />
							<c:forEach items="${courseDetail.userCourseViews}" var="view">
								<c:set var="views" value="${views + 1}" />
							</c:forEach>
							<td>${views}</td>
							<!-- <td><a href="${contextRoot}/course/edit/detail/${courseDetail.id}"
									class="d-flex align-items-center mb-2 mb-lg-0 text-dark text-decoration-none">
									<button type="button" class="btn btn-info">編輯</button>
								</a></td> -->
							<c:if test="${courseDetail.status == 0}">
								<td>
									<button type="button" class="btn btn-warning statusBTN">等待審核</button>
								</td>
							</c:if>
							<c:if test="${courseDetail.status == 1}">
								<td>
									<button type="button" class="btn btn-success statusBTN">通過審核</button>
								</td>
							</c:if>
							<c:if test="${courseDetail.status == 2}">
								<td>
									<button type="button" class="btn btn-secondary statusBTN">已刪除</button>
								</td>
							</c:if>
							<c:if test="${courseDetail.status == 0 || courseDetail.status == 1}">
								<td>
									<button type="button" class="btn btn-danger changeStatusBTN"
										data-id="${courseDetail.id}" data-status="${courseDetail.status}">刪除</button>
								</td>
							</c:if>
							<c:if test="${courseDetail.status == 2}">
								<td>
									<button type="button" class="btn btn-secondary changeStatusBTN"
										data-id="${courseDetail.id}" data-status="${courseDetail.status}">復原</button>
								</td>
							</c:if>
						</tr>
					</c:forEach>
				</c:forEach>


			</tbody>
		</table>
	</div>
	<jsp:include page="../common/footer.jsp" />
	<!-- dataTable JS -->
	<script src="${contextRoot}/js/common/jquery.dataTables.min.js"></script>
	<script>
		// DataTable表格設定
		$(document).ready(function () {
			$("#uploadCourseTable").DataTable({
				order: [0, "asc"],
			});
		});

		// 用ajax改變課程小節狀態(復原/刪除)
		$(".changeStatusBTN").click(function (e) {
			let courseDetailId = $(e.target).data("id");
			let status = $(e.target).data("status");

			// 審核通過的課程刪除變成可復原
			if ($(e.target).text() == "刪除" && status != 0) {
				$(e.target).text("復原");
				$(e.target).removeClass("btn-danger");
				$(e.target).addClass("btn-secondary");

				$(e.target).parent().parent().find(".statusBTN").text("已刪除");
				$(e.target).parent().parent().find(".statusBTN").removeClass("btn-success");
				$(e.target).parent().parent().find(".statusBTN").addClass("btn-secondary");
			}
			// 待審核的課程直接刪除
			else if (status == 0) {
				$(e.target).parent().parent().remove();
			}
			// 把審核通過的課程復原
			else if ($(e.target).text() == "復原") {
				$(e.target).text("刪除");
				$(e.target).addClass("btn-danger");
				$(e.target).removeClass("btn-secondary");

				$(e.target).parent().parent().find(".statusBTN").text("通過審核");
				$(e.target).parent().parent().find(".statusBTN").addClass("btn-success");
				$(e.target).parent().parent().find(".statusBTN").removeClass("btn-secondary");
			}

			let urlString = '${contextRoot}/course/changeStatus/detail/' + courseDetailId;
			$.ajax({
				type: "GET",
				url: urlString,
				dataType: "json",
				success: function (result) {

				},
				error: function (thrownError) {
					console.log(thrownError);
				}
			});
		});
	</script>
</body>

</html>