<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="contextRoot" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FQA分類</title>
<!-- DataTable -->
<link rel="stylesheet" href="https://cdn.datatables.net/1.11.3/css/jquery.dataTables.min.css">

</head>
<body>

<!-- 導覽列 -->
<jsp:include page="../common/navigate.jsp" />

<!-- QA後台 -->
<div class="container">	
	<div class="row justify-content-center mt-5 mb-3">
		
		<div class="d-flex">
			<h1>FQA分類</h1>
			<!-- 新增分類 彈跳視窗 -->
			<div class="mt-3">
				<button type="button" class="btn btn-outline-success btn btn-outline-success ms-4 " 
						data-toggle="modal" data-target="#exampleModal" data-whatever="@getbootstrap">+ 新增分類
				</button>
			</div>		
		</div>
		
		<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
			<div class="modal-dialog" role="document">
				<div class="modal-content">	    
			      <div class="modal-header">
			        <h5 class="modal-title" id="exampleModalLabel">新增分類</h5>
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
			          <span aria-hidden="true">&times;</span>
			        </button>
			      </div>
			      
			      <div class="modal-body">
					<form action="${contextRoot}/addQuestionType2" method="post" enctype="multipart/form-data">
						<div class="form-group">
							<label for="recipient-name" class="col-form-label">分類名稱</label>
							<input type="text" name="type" class="form-control" id="questionTypeInput">
						</div>
						<div>
							<label for="recipient-name" class="col-form-label">圖片</label>
						</div>
						<div class="form-group">
							<input type="file" name="imageData" class="form-control" required>
						</div>
						<div class="modal-footer">
					       		<button type="submit" class="btn btn-success">新增</button>
					       		<button type="button" class="btn btn-secondary" data-dismiss="modal">取消</button>
					       		<button type="button" class="btn btn-outline-info" id="inputOneQATypeBTN">一鍵輸入</button>
						</div>
					</form>
			      </div><!-- div .modal-body end -->

				</div>
			</div>
		</div>
		<!-- 新增分類 彈跳視窗 end-->
	</div>
		
	<div class="row justify-content-center">	
		<table id="tableAllTypes" class="display">
			<thead>
				<tr>
					<th>圖片</th>
					<th>分類</th>
					<th>常見 Question and Answer</th>
					<th>編輯</th>
					<th>刪除</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="questionTypes" items="${QuestionTypesList}">
					<tr>
						<td><img src="${contextRoot}/customerservice/getImg?typeId=${questionTypes.id}" style="width: 30px; height: 30px;"></td>
						<td>${questionTypes.type}</td>
						<td>
							<a href="${contextRoot}/customerservice/QAType/${questionTypes.id}">
								<button class="btn btn-success btn-sm">查看FQA</button>
							</a>
						</td>
						<td>
							<a href="${contextRoot}/customerservice/editType/${questionTypes.id}">
								<button class="btn btn-warning btn-sm">修改</button>
							</a>
						</td>
						<td>
							<a href="${contextRoot}/customerservice/deleteType/${questionTypes.id}">
							<button type="submit" class="btn btn-secondary btn-sm" onclick="return confirm('確認刪除?')">刪除</button>
							</a>
						</td>		
					</tr>
				</c:forEach>
			</tbody>
		</table>	
	</div><!-- row div end-->		
</div><!-- container div end-->



<!-- bootstrap -->
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.min.js"
	integrity="sha384-+sLIOodYLS7CIrQpBjl+C7nPvqq+FbNUBDunl/OZv93DB7Ln/533i8e/mZXLi/P+"
	crossorigin="anonymous"></script>

<!-- DataTable -->
<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
<script src="https://cdn.datatables.net/1.11.3/js/jquery.dataTables.min.js"></script>
	
<script type="text/javascript">
//一鍵輸入NewType
$("#inputOneQATypeBTN").click(function() {
	$("#questionTypeInput").val("建立課程");
});

/*Datatable*/
$(document).ready( function () {
    $('#tableAllTypes').DataTable({
    	language : {
    		"processing":   "處理中...",
    		"loadingRecords": "載入中...",
    		"lengthMenu":   "顯示 _MENU_ 項結果",
    		"zeroRecords":  "沒有符合的結果",
    		"info":         "顯示第 _START_ 至 _END_ 項結果，共 _TOTAL_ 項",
    		"infoEmpty":    "顯示第 0 至 0 項結果，共 0 項",
    		"infoFiltered": "(從 _MAX_ 項結果中過濾)",
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

/*彈跳視窗*/
var myModal = document.getElementById('myModal')
var myInput = document.getElementById('myInput')

myModal.addEventListener('shown.bs.modal', function () {
  myInput.focus()
})
</script>
</body>
</html>