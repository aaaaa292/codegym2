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
<title>常見FQA</title>
<!-- DataTable -->
<link rel="stylesheet"
	href="https://cdn.datatables.net/1.11.3/css/jquery.dataTables.min.css">

</head>
<body>
	<!-- 導覽列 -->
	<jsp:include page="../backstage/backstageNavbar.jsp" />

	<div class="container">

		<div class="row justify-content-center mt-5 mb-3">
			<div class="d-flex">
				<h1>常見FQA</h1>
				<div class="d-flex mt-3 ms-4">
					<a href="${contextRoot}/customerservice/showAllTypes">
						<button type="button" class="btn btn-outline-primary">回上一頁</button>
					</a> <a
						href="${contextRoot}/customerservice/${questionType.id}/addQAPage">
						<button type="button" class="btn btn-outline-success ms-3">+
							新增FQA</button>
					</a>
				</div>
			</div>
		</div>

		<div class="row justify-content-center">
			<table id="tableQA" class="display">
				<thead>
					<tr>
						<th>時間</th>
						<th>分類</th>
						<th>問題</th>
						<th>修改</th>
						<th>刪除</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="questionAnswers"
						items="${questionType.questionAnswers}">
						<tr>
							<td style="width: 18%"><fmt:formatDate
									pattern="yyyy-MM-dd HH:mm:ss" value="${questionAnswers.time }"></fmt:formatDate></td>
							<td>${questionAnswers.questionTypeId.type }</td>
							<td>${questionAnswers.question }</td>
							<td><a
								href="${contextRoot}/customerservice/editQAPage/${questionAnswers.id}"
								class="me-3" style="text-decoration: none;">
									<button class="btn btn-warning">修改</button>
							</a></td>
							<td>
								<form
									action="${contextRoot}/customerservice/deleteQA/${questionAnswers.id }"
									method="post">
									<input type="hidden" name="questionTypeId"
										value="${questionAnswers.questionTypeId.id }">
									<button type="submit" class="btn btn-secondary"
										onclick="return confirm('確認刪除?')">刪除</button>
								</form>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
		<!-- row div end -->
	</div>
	<!-- container div end -->

	<div class="row justify-content-center">
		<div class="col-8">
			<!-- 分頁 -->
			<c:forEach var="pageNumber" begin="1" end="${page.totalPages}">
				<c:choose>
					<c:when test="${page.number != pageNumber -1}">
						<a href="${contextRoot}/customerservice/showAllQA?p=${pageNumber}">${pageNumber}</a>
					</c:when>
					<c:otherwise>
			       ${pageNumber}
			    </c:otherwise>
				</c:choose>
			</c:forEach>
			<!-- 分頁 -->
		</div>
	</div>

	<!-- DataTable -->
	<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
	<script
		src="https://cdn.datatables.net/1.11.3/js/jquery.dataTables.min.js"></script>

	<script type="text/javascript">
		/*Datatable*/
		$(document).ready(function() {
			$('#tableQA').DataTable({
				order : [ 0, "desc" ],
			});
		});
	</script>
</body>
</html>