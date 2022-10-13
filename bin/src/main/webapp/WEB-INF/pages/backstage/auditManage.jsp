<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<title>審核課程</title>

<c:set var="contextRoot" value="${pageContext.request.contextPath}" />

<!-- web icon -->
<link rel="icon" href="${contextRoot}/img/icon.png" />
<!-- dataTable CSS -->
<link rel="stylesheet"
	href="${contextRoot}/css/common/jquery.dataTables.min.css" />
</head>
<jsp:include page="../backstage/backstageNavbar.jsp" />

<body>
	<form id="updateForm"
		action="${contextRoot}/backstage/courses/auditSuccess" method="post">
		<input type="hidden" name="checkboxIdList">
		<input type="hidden" name="statusAction">
		<h1>審核管理</h1>
		<button type="button" class="btn btn-warning" id="allBtn"
			name="allBtn">批量全選</button>
		<button type="button" class="btn btn-danger" id="canncelBtn"
			name="canncelBtn" style="display: none">取消全選</button>
		<button type="button" class="btn btn-success" id="updateBtn"
			name="rightlBtn">批量審核</button>
<button type="button" class="btn btn-danger" id="failBTN" >審核未通過</button>
		<br><br>
		<div class="container">
			<table id="uploadCourseTable" class="display">
				<thead>
					<tr>
						<th>勾選</th>
						<th>使用者ID</th>
						<th>上傳時間</th>
						<th>課程名稱</th>
						<th>課程標籤</th>
						<th>章節名稱</th>
						<th>影片名稱</th>
						<th>審核狀態</th>
						<!-- 					<th>刪除課程</th> -->
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${courseDetailList}" var="courseDetail">
						<tr>
							<td>
							<c:if test="${courseDetail.status == 0}">
								<input type="checkbox" name="classCheckbox"
								class="rightck" value="${courseDetail.id}">
								</c:if>
								</td>
							<td>${courseDetail.courseChapter.courseProfile.userInformation.name}</td>
							<td><span class="badge bg-dark">${courseDetail.time}</span></td>
							<td><a
								href="${contextRoot}/course/${courseDetail.courseChapter.courseProfile.id}/show"
								class="d-flex align-items-center mb-2 mb-lg-0 text-dark text-decoration-none">
									<button type="button" class="btn btn-secondary"
										style="width: 100%;">${courseDetail.courseChapter.courseProfile.name}</button>
							</a></td>
							<td><c:forEach
									items="${courseDetail.courseChapter.courseProfile.courseTags}"
									var="t">
									<span class="badge bg-primary">${t.tag}</span>
								</c:forEach></td>
							<td>${courseDetail.courseChapter.name}</td>
							<td>${courseDetail.courseChapter.number}-${courseDetail.section}${courseDetail.name}</td>
							<c:if test="${courseDetail.status == 0}">
								<td>
									<button type="button" class="btn btn-warning">等待審核</button>
								</td>
							</c:if>
							<c:if test="${courseDetail.status == 1}">
								<td>
									<button type="button" class="btn btn-success">通過審核</button>
								</td>
							</c:if>
							<c:if test="${courseDetail.status == 2}">
								<td>
									<button type="button" class="btn btn-secondary">已刪除</button>
								</td>
							</c:if>
							<c:if test="${courseDetail.status == 3}">
								<td>
									<button type="button" class="btn btn-danger">審核失敗</button>
								</td>
							</c:if>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>

		<br>
		<jsp:include page="../common/footer.jsp" />
	</form>
	<!-- dataTable JS -->
	<script src="${contextRoot}/js/common/jquery.dataTables.min.js"></script>
	<script>
		$(document).ready(function() {
			$("#uploadCourseTable").DataTable({
				order : [0, "desc" ],
			});

			$('#allBtn').click(function() {
				$('#allBtn').hide();
				$('#canncelBtn').show();
				$('[name=classCheckbox]').prop('checked', true);
			});

			$('#canncelBtn').click(function() {
				$('#canncelBtn').hide();
				$('#allBtn').show();
				$('[name=classCheckbox]').prop('checked', false);
			});

			//批量過審按鈕
			$("#updateBtn").bind("click", function() {
				//建立塞有勾選的checkbox值物件
				var checkboxIdList = new Array();
				//展開checkbox迴圈
				$("[name=classCheckbox]").each(function(i, obj) {
					//確認判斷有勾選的checkbox
					if ($(this).prop("checked")) {
						//取得勾選checkbox值
						var checkValue = $(this).val();
						//判斷資料不重複
						if (jQuery.inArray(checkValue, checkboxIdList) == -1) {
							//塞進物件
							checkboxIdList.push(checkValue);
						}
					}
				});
				//塞進頁面物件
				$("[name=checkboxIdList]").val(checkboxIdList);
				$("[name=statusAction]").val(1);
				$('#updateForm').submit();
			});
			//批量過審按鈕
			$("#failBTN").bind("click", function() {
				//建立塞有勾選的checkbox值物件
				var checkboxIdList = new Array();
				//展開checkbox迴圈
				$("[name=classCheckbox]").each(function(i, obj) {
					//確認判斷有勾選的checkbox
					if ($(this).prop("checked")) {
						//取得勾選checkbox值
						var checkValue = $(this).val();
						//判斷資料不重複
						if (jQuery.inArray(checkValue, checkboxIdList) == -1) {
							//塞進物件
							checkboxIdList.push(checkValue);
						}
					}
				});
				//塞進頁面物件
				$("[name=checkboxIdList]").val(checkboxIdList);
				$("[name=statusAction]").val(3);
				$('#updateForm').submit();
			});

		});
	</script>
</body>
</html>
