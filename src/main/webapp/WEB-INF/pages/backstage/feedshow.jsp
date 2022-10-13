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
<title>查看留言</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel='stylesheet'
	href='https://fonts.googleapis.com/css?family=Roboto'>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
</head>
<body>

	<!-- 導覽列 -->
	<jsp:include page="../backstage/backstageNavbar.jsp" />
	<div class="d-flex align-items-end">
		<h1>客戶服務</h1>
		<h2>-反饋紀錄</h2>
		<h3>-內容編輯</h3>
	</div>
	<div>
		<a href="${contextRoot}/backstage/feedback">
			<button class="btn btn-outline-primary">回上一頁</button>
		</a>
	</div>
	<div class="w3-container">
		<h5 class="w3-opacity pt-4">
			<b>詳細內容</b>
		</h5>
		<h6 class="w3-text-teal">
			<span class="w3-tag w3-teal"> <fmt:formatDate
					pattern="yyyy-MM-dd HH:mm:ss" value="${receiptMessages.time}" />
			</span>
		</h6>
		<br>
		<div class="d-flex"
			style="justify-content: space-between; align-items: center;">
			<p>${receiptMessages.message}</p>
			<div style="text-align: right; display: block;">
				<a
					href="${contextRoot}/customerservice/reMessage/${receiptMessages.id}">
					<button id="reBTN" class="btn btn-warning" style="display:;">回覆留言</button>
				</a>
			</div>
		</div>
		<hr>
		<!-- 回復訊息 -->
		<div>
			<div class="d-flex" style="justify-content: space-between;">
				<p class="w3-opacity mt-2" id="reMsg">${receiptMessages.replyMessages.message }</p>
				<a href="#">
					<button id="editReplyBTN" class="btn btn-warning"
						style="display: none;">編輯</button>
				</a>
			</div>
			<p class="w3-opacity">
				<fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss"
					value="${receiptMessages.replyMessages.time}" />
			</p>
		</div>
	</div>
	</div>
	</div>
	</div>
	<!-- container div -->
	<jsp:include page="../common/footer.jsp" />
	<script type="text/javascript">
// 回覆
var getText = document.getElementById('reMsg').textContent;
if ( ${receiptMessages.replyMessages.id} != null) {
	document.getElementById('reBTN').style.display = 'none'; // 回覆按鈕印藏
	document.getElementById('editReplyBTN').style.display = ''; // 顯示編輯回覆BTN	
}
</script>
</body>
</html>