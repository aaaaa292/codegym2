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
<title>訊息傳送</title>
<!-- 自定義CSS -->
<link rel="stylesheet"
	href="${contextRoot}/css/backstage/jquery.dataTables.min.css">
<script src="https://code.jquery.com/jquery-2.1.3.min.js"></script>
</head>
<body>
	<jsp:include page="../backstage/backstageNavbar.jsp" />

	<h1>站內訊息</h1>

	<form id="" method="post"
		action="${contextRoot}/backstage/message/insertmessage">
		<input type="hidden" name="classify">
		<div>
			請選擇標籤:<img src="${contextRoot}/img/learning/tagIcon.png" height="20">
			<div class="form-control">
				<div class="col-10 text-center">
					<div class="form-check form-check-inline">
						<input type="radio" name="messageType" value="優惠通知"><label>優惠通知</label>
					</div>
					<div class="form-check form-check-inline">
						<input type="radio" name="messageType" value="審核通知"><label>審核訊息</label>
					</div>
					<div class="form-check form-check-inline">
						<input type="radio" name="messageType" value="廣告推送"><label>廣告推送</label>
					</div>
					<div class="form-check form-check-inline">
						<input type="radio" name="messageType" value="課程更新"><label>課程更新上架</label>
					</div>
					<div class="form-check form-check-inline">
						<input type="radio" name="messageType" value="推薦通知"><label>推薦通知</label>
					</div>
				</div>
				<div>
					使用者編號 : <input value="${userId}" disabled>
					<input type="hidden" name="userId" value="${userId}">
				</div>
				<div>
					傳送訊息給 <input type="text" id="name" name="name" value="${name}"
						placeholder="請輸入使用者id" disabled>
					<input type="hidden" id="name" name="name" value="${name}"
						placeholder="請輸入使用者id">
				</div>
			</div>
			<div>
				<textarea name="messageText" id="message" style="display: none"
					placeholder="請輸入欲傳送的訊息" cols="50%" rows="5" maxlength="50" required></textarea>
			</div>
			<div>
				<button type="submit">訊息傳送</button>
			</div>
		</div>
	</form>
</body>
<!-- js code -->
<script src="${contextRoot}/js/backstage/jquery.dataTables.min.js"></script>

<script>
    $('[name=messageType]').click(function() {
	var messageType = $('[name=messageType]:checked').val();
	var messageText = $('[name=messageText]');
	var defaultMessage = "";

	if (messageType == "優惠通知") {
	    defaultMessage = "目前優惠課程     ,詳細內容如下:";
	} else if (messageType == "審核通知") {
	    defaultMessage = "您的課程審核未能通過,詳細原因如下:";
	} else if (messageType == "廣告推送") {
	    defaultMessage = "廣告內容:";
	} else if (messageType == "課程更新") {
	    defaultMessage = "您的課程更新上架了,詳細內容如下:";
	} else if (messageType == "推薦通知") {
	    defaultMessage = "目前推薦課程     ,詳細內容如下:";
	}
	messageText.show();
	messageText.val(defaultMessage);
	$('[name=classify]').val(messageType);
    });
    
</script>
</html>