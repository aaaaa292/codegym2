<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="contextRoot" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${questionType.type }</title>
<!-- DataTable -->
<link rel="stylesheet" href="https://cdn.datatables.net/1.11.3/css/jquery.dataTables.min.css">

</head>
<body style="height: 100%;">
<!-- 導覽列 -->
<jsp:include page="../backstage/backstageNavbar.jsp" />

<div style="height: 115%">	

	<div class="row justify-content-center mb-3">
		<div>
			<h1>${questionType.type }</h1>
			<div class="d-flex mb-3">
				<a href="${contextRoot}/backstage/customerservice">
					<button type="button" class="btn btn-primary">回上一頁</button>
				</a>
				<a href="${contextRoot}/customerservice/${questionType.id}/addQAPage">
					<button type="button" class="btn btn-success ms-1">+ 新增FQA</button>
				</a>
			</div>				
		</div>
	</div>
		
	<div class="row justify-content-center mb-4">	
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
				<c:forEach var="questionAnswers" items="${questionType.questionAnswers}">
					<tr>
						<td style="width: 18%"><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${questionAnswers.time }"></fmt:formatDate></td>
						<td>${questionAnswers.questionTypeId.type }</td>
						<td>${questionAnswers.question }</td>
						<td>
							<a href="${contextRoot}/customerservice/editQAPage/${questionAnswers.id}" class="me-3" style="text-decoration: none;">
								<button class="btn btn-warning">修改</button>
							</a>
						</td>
						<td>
							<form action="${contextRoot}/customerservice/deleteQA/${questionAnswers.id }"  method="post">
								<input type="hidden" name="questionTypeId" value="${questionAnswers.questionTypeId.id }">
								<button type="submit" class="btn btn-danger" onclick="return confirm('確認刪除?')">刪除</button>
							</form>
						</td>
					</tr>
				</c:forEach>
				</tbody>
			</table>	
	</div><!-- row div end -->	
</div><!-- container div end -->

<div class="row justify-content-center">
	<div class="col-8">
		<!-- 分頁 -->
		<c:forEach var="pageNumber" begin="1" end="${page.totalPages}">
			<c:choose>
				<c:when  test="${page.number != pageNumber -1}">
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
<jsp:include page="../common/footer.jsp" />

<!-- DataTable -->
<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
<script src="https://cdn.datatables.net/1.11.3/js/jquery.dataTables.min.js"></script>

<script type="text/javascript">
/*Datatable*/
$(document).ready( function () {
    $('#tableQA').DataTable({
    	order : [ 0, "desc" ],
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
</script>
</body>
</html>