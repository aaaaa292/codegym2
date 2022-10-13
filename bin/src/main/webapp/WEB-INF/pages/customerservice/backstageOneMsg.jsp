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
<style type="text/css">
#wrapper {
	width: 100% !important;
	min-height: calc(100% - 219px) !important;
	padding-bottom: 0 !important;
}
</style>
</head>
<body>

	<!-- 導覽列 -->
	<jsp:include page="../backstage/backstageNavbar.jsp" />

	<div class="container" style="height: 117%">
		
		<div class="row justify-content-center mt-5 mb-3">
			<div class="col-8"
				style="display: flex; justify-content: space-between;">
				<div>
					<a href="${contextRoot}/customerservice/viewMessages">
						<button class="btn btn-warning">回上一頁</button>
					</a>
				</div>
			</div>
		</div>
		
		<div class="row justify-content-center mt-2 mb-3">
			<div class="col-8">
				<div class="w3-card w3-white py-2 px-4" style="border-radius: 15px;">
					<div class="w3-container">
						<h3 class="w3-opacity pt-4">
							<b>${receiptMessages.title}</b>
						</h3>
						<h6 class="w3-text-teal">
							<span class="w3-tag w3-teal"> <fmt:formatDate
									pattern="yyyy-MM-dd HH:mm:ss" value="${receiptMessages.time}" />
							</span>
						</h6>
						<br>
						<div class="d-flex"
							style="justify-content: space-between; align-items: center;">
							<p style="width: 85%">${receiptMessages.message}</p>
							<div style="text-align: right; display: block;">
								<button id="replyBTN" onclick="replyContent()"
									class="btn btn-warning" style="display:;">回覆留言</button>
							</div>
						</div>
						<hr>
						<!-- 新增回復訊息 -->
						<div id="replyInputContent" style="display:;">
							<form class="form" method="post"
								action="${contextRoot}/customerservice/postReMessage2">
								<input name="replyMsgId" type="hidden" value="${id}" /> <input
									name="userName" type="hidden" value="${userInformation.name }" />
								<input name="userEmail" type="hidden"
									value="${userInformation.email }" /> <input
									name="receiptTitle" type="hidden"
									value="${receiptMessages.title}" /> <input name="receiptMsg"
									type="hidden" value="${receiptMessages.message}" /> <input
									name="status" type="hidden" value="已回覆" />
								<textarea name="message" id="reMessageInput"
									class="form-control" style="height: 120px;" required></textarea>
								<button id="submitBTN" onclick="replyMsg()" type="submit"
									class="btn btn-primary mt-2">送出</button>
								<button id="cancelBTN" onclick="cancelReply()" type="button"
									class="btn btn-secondary mt-2">取消</button>
								<button type="button" class="btn btn-outline-info mt-2"
									id="oneInputMsgBTN">一鍵輸入</button>
							</form>
						</div>
						<!-- 新增回復訊息 end-->

						<!-- 顯示回復訊息 -->
						<div id="resultContent" style="display:;" class="mb-5">
							<div class="d-flex" style="justify-content: space-between;">
								<p class="w3-opacity mt-2" id="reMsg">${receiptMessages.replyMessages.message }</p>
								<a href="#">
									<button id="editReplyBTN" onclick="editContent()"
										class="btn btn-warning" style="display: none;">編輯</button>
								</a>
							</div>
							<p class="w3-opacity">
								<fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss"
									value="${receiptMessages.replyMessages.time}" />
							</p>
						</div>
						<!-- 顯示回復訊息 end -->

						<!-- 修改已回復訊息 -->
						<div id="editInputContent" style="display: none;">
							<form class="form" method="post"
								action="${contextRoot}/customerservice/editReMessage">
								<input name="receiptId" type="hidden" value="${id}" /> <input
									name="replyMsgId" type="hidden"
									value="${receiptMessages.replyMessages.id}" /> <input
									name="userName" type="hidden" value="${userInformation.name }" />
								<input name="userEmail" type="hidden"
									value="${userInformation.email }" /> <input
									name="receiptTitle" type="hidden"
									value="${receiptMessages.title}" /> <input name="receiptMsg"
									type="hidden" value="${receiptMessages.message}" />
								<textarea name="message" id="editMessageInput"
									class="form-control" style="height: 120px;" required>
								${receiptMessages.replyMessages.message }
							</textarea>
								<button type="submit" class="btn btn-primary mt-2 mb-5">修改</button>
								<button id="cancelEditBTN" onclick="cancelEdit()" type="button"
									class="btn btn-secondary mt-2 mb-5">取消</button>
								<button id="oneInputEditReBTN" type="button"
									class="btn btn-outline-info mt-2 mb-5">一鍵輸入</button>
							</form>
						</div>
						<!-- 修改已回復訊息 end -->
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- container div -->
	<jsp:include page="../common/footer.jsp" />

	<script type="text/javascript">
		// 網頁載入判斷"回復訊息"是否存在
		window.onload = function() {
			var getText = document.getElementById('reMsg').textContent;

			if (getText != "") {
				document.getElementById('replyBTN').style.display = 'none';
				document.getElementById('replyInputContent').style.display = 'none';
				document.getElementById('editReplyBTN').style.display = 'inline';
			} else {
				document.getElementById('replyInputContent').style.display = 'none';
				document.getElementById('replyBTN').style.display = 'inline';
			}
		}
		// 點擊"回覆留言"按鈕，顯示回復區塊
		function replyContent() {
			document.getElementById('replyBTN').style.display = 'none';
			document.getElementById('replyInputContent').style.display = 'inline';
		}
		// 點擊"取消"按鈕，收起回復區塊
		function cancelReply() {
			document.getElementById('replyInputContent').style.display = 'none';
			document.getElementById('replyBTN').style.display = 'inline';
		}
		// 點擊"送出"按鈕，隱藏回復
		function replyMsg() {
			document.getElementById('replyInputContent').style.display = 'none';
			document.getElementById('replyBTN').style.display = 'none';
		}
		// 點擊"編輯"按鈕，顯示編輯區塊
		function editContent() {
			document.getElementById('editInputContent').style.display = 'inline';
			document.getElementById('resultContent').style.display = 'none';
			document.getElementById('editReplyBTN').style.display = 'none';
		}
		// 點擊"取消"按鈕，收起編輯區塊
		function cancelEdit() {
			document.getElementById('editInputContent').style.display = 'none';
			document.getElementById('resultContent').style.display = 'inline';
			document.getElementById('editReplyBTN').style.display = 'inline';
		}
		//一鍵輸入NewType
		$("#oneInputMsgBTN").click(function() {
			$("#reMessageInput").val("很高興能夠收到您的訊息，我們會立即請專人協助你！");
		});
		$("#oneInputEditReBTN").click(function() {
			$("#editMessageInput").val("我們會協助你！(內容更新)");
		});
	</script>
</body>
</html>