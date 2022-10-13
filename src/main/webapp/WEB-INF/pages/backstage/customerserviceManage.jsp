<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<c:set var="contextRoot" value="${pageContext.request.contextPath}" />
<meta charset="UTF-8">
<title>常見問題</title>
<!-- 自定義CSS -->

<link rel="stylesheet"
	href="${contextRoot}/css/backstage/jquery.dataTables.min.css">
<script src="https://code.jquery.com/jquery-2.1.3.min.js"></script>
</head>
<body>
<jsp:include page="../backstage/backstageNavbar.jsp" />
<!-- QA後台 -->
<div>
	<h1>常見問題分類</h1>
	<button type="button" class="btn btn-success mb-3" data-toggle="modal" data-target="#exampleModal" data-whatever="@getbootstrap">+ 新增分類</button>
</div>

<div class="container">
	<div class="row justify-content-left">
		<div class="col-6" style="display: flex;">

			<!-- 新增分類 彈跳視窗 -->
<!-- 			<div class="mt-1"> -->
<!-- 				<button type="button" class="btn btn-success" data-toggle="modal" data-target="#exampleModal" -->
<!-- 					data-whatever="@getbootstrap">+ 新增分類</button> -->
<%-- 				<a href="${contextRoot}/backstage" class="ms-3"> --%>
<!-- 					<button type="button" class="btn btn-outline-primary">回上一頁</button> -->
<!-- 				</a> -->
<!-- 			</div> -->

			<div class="modal fade " id="exampleModal" tabindex="-1"
				role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
				<div class="modal-dialog" role="document">
					<div class="modal-content">
						<div class="modal-header">
							<h5 class="modal-title" id="exampleModalLabel">新增分類</h5>
							<button type="button" class="close" data-dismiss="modal"
								aria-label="Close">
								<span aria-hidden="true">&times;</span>
							</button>
						</div>
					<!-- 彈跳執行新增動作編輯視窗 -->
						<div class="modal-body">
							<form action="${contextRoot}/addQuestionTypeEX" method="post"
								enctype="multipart/form-data">
								<div class="form-group">
									<label for="recipient-name" class="col-form-label">分類名稱</label>
									<input type="text" name="type" class="form-control"
										id="questionTypeInput">
								</div>
								<div>
									<label for="recipient-name" class="col-form-label">圖片</label>
								</div>
								<div class="form-group">
									<input type="file" name="imageData" class="form-control"
										required>
								</div>
								<div class="modal-footer">
									<button type="button" class="btn btn-outline-info" id="inputOneQATypeBTN">一鍵輸入</button>
						       		<button type="submit" class="btn btn-success">新增</button>
						       		<button type="button" class="btn btn-secondary" data-dismiss="modal">取消</button>
								</div>
							</form>
						</div>
						<!-- div .modal-body end -->

					</div>
				</div>
			</div>
			<!-- 新增分類 彈跳視窗 end-->
		</div>
	</div>
	</div>
	
<div class="container" style="height: 91%">
		<table id="example">
			<thead>
				<tr>
					<th>圖片</th>
					<th>分類</th>
					<th>常見Question Answer</th>
					<th>編輯</th>
					<th>刪除</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="questionTypes" items="${page.content}">
					<tr>
						<td><img
							src="${contextRoot}/customerservice/getImg?typeId=${questionTypes.id}"
							style="width: 30px; height: 30px;"></td>
						<td>${questionTypes.type}</td>
						<td><a
							href="${contextRoot}/customerservice/QAType/${questionTypes.id}">
							<button class="btn btn-info">查看QA</button></a></td>
						<td><a
							href="${contextRoot}/backstage/editCS/${questionTypes.id}">
								<button class="btn btn-warning">修改</button>
						</a></td>
						<td><a
							href="${contextRoot}/backstage/deleteCS/${questionTypes.id}">
								<button type="submit" class="btn btn-secondary btn-danger"
									onclick="return confirm('確認刪除?')">刪除</button>
						</a></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>

	<jsp:include page="../common/footer.jsp" />
	<!-- bootstrap -->
	<script
		src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"
		integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN"
		crossorigin="anonymous"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.min.js"
		integrity="sha384-+sLIOodYLS7CIrQpBjl+C7nPvqq+FbNUBDunl/OZv93DB7Ln/533i8e/mZXLi/P+"
		crossorigin="anonymous"></script>

	<script type="text/javascript">
		var myModal = document.getElementById('myModal')
		var myInput = document.getElementById('myInput')

		myModal.addEventListener('shown.bs.modal', function() {
			myInput.focus()
		})
	</script>
	<!-- dataTable JS -->
	<script src="${contextRoot}/js/common/jquery.dataTables.min.js"></script>
	<script>
	//一鍵輸入NewType
	$("#inputOneQATypeBTN").click(function() {
		$("#questionTypeInput").val("建立課程");
	});

	$(document).ready(function() {
		$('#example').DataTable({
			"order" : [ 0, 'asc' ],
			language : {
			      "processing":   "處理中...",
			      "loadingRecords": "載入中...",
			      "lengthMenu":   "顯示 MENU 項結果",
			      "zeroRecords":  "沒有符合的結果",
			      "info":         "顯示第 START 至 END 項結果，共 TOTAL 項",
			      "infoEmpty":    "顯示第 0 至 0 項結果，共 0 項",
			      "infoFiltered": "(從 MAX 項結果中過濾)",
			      "infoPostFix":  "",
			      "search":       "搜尋:",
			      "paginate": {
			       "first":    "第一頁",
			       "previous": "上一頁",
			       "next":     "下一頁",
			       "last":     "最後一頁"
			      },
			      "aria": {
			       "sortAscending":  ": 升冪排列",
			       "sortDescending": ": 降冪排列"
			      }
			 },
		});
	});
	</script>
</body>
</html>