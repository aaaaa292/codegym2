<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="contextRoot" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>顧客反饋</title>
<!-- DataTable -->
<!-- dataTable CSS -->
<link rel="stylesheet" href="${contextRoot}/css/common/jquery.dataTables.min.css" />

<style type="text/css">
span.status{
	border-radius: 8px; 
	padding: 3px 10px; 
	color: white;
	font-size: 13px;
}
</style>
</head>
<body>
<!-- 導覽列 -->
	<jsp:include page="../backstage/backstageNavbar.jsp" />
	
<div class="container" style="height: 119%">	
	<div class="row justify-content-center">
		<div>
			<h1>顧客反饋</h1>
		</div>
	</div>
			
	<div class="row justify-content-center">
		<table id="receiptTable" class="display">
			<thead>
				<tr>
					<th scope="col">使用者編號</th>
					<th scope="col">留言時間</th>
					<th scope="col">種類</th>
					<th scope="col">標題</th>
					<th scope="col">內容</th>
					<th scope="col">狀態</th>
					<th scope="col">回覆</th>
					<th scope="col">刪除</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="receiptMsg" items="${ReceiptMessages}">
					<tr>
						<td>${receiptMsg.userId}</td>
						<td style="width: 10%;"><fmt:formatDate pattern="yyyy/MM/dd HH:mm:ss" value="${receiptMsg.time}" /></td>
						<td style="width: 8%;">${receiptMsg.receiptMessageTypes.type}</td>
						<td style="width: 12%;">${receiptMsg.title}</td>
						<td>${receiptMsg.message}</td>
						
						<td style="width: 8%;">
							<c:if test="${receiptMsg.status == '已回覆'}">
									<span class="status" style="background-color: green;">${receiptMsg.status}</span>
							</c:if>
							<c:if test="${receiptMsg.status == '尚未回覆'}">
									<span class="status" style="background-color: red;">${receiptMsg.status}</span>
							</c:if>
						</td>
						<td>
							<a href="${contextRoot}/customerservice/viewOneMessage/${receiptMsg.id}" class="ms-2">
								<button class="btn btn-warning btn-sm me-3">回覆</button>
							</a>
						</td>
						<td>
							<a href="${contextRoot}/customerservice/deleteReceipt/${receiptMsg.id}" class="ms-2">
								<button class="btn btn-danger btn-sm me-3" onclick="return confirm('確認刪除?')">刪除</button>
							</a>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
</div> <!-- container div -->
<jsp:include page="../common/footer.jsp" />

<!-- dataTable JS -->
<script src="${contextRoot}/js/common/jquery.dataTables.min.js"></script>

<script type="text/javascript">
/*Datatable*/
$(document).ready( function () {
    $('#receiptTable').DataTable({
    	order : [ 1, "desc" ],
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
} );
</script>
</body>
</body>
</html>