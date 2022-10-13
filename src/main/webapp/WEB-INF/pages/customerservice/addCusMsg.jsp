<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="contextRoot" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>意見反饋</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://cdn.ckeditor.com/ckeditor5/35.0.1/classic/ckeditor.js"></script>
<!-- bootstrap -->
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css"
	integrity="sha384-GJzZqFGwb1QTTN6wy59ffF1BuGJpLSa9DkKMp0DgiMDm4iYMj70gZWKYbI706tWS"
	crossorigin="anonymous">

<style type="text/css">
#wrapper{
	
}
</style>
</head>
<body>
<!-- 導覽列 -->
<jsp:include page="../common/navigate.jsp" />

<div class="container-fluid" id="">

	<div class="row justify-content-center" style="margin: 69px auto;">
		<div class="col-4 text-center">
			<img src="${contextRoot}/img/customerservice/cusMsg.jpg" style="width: 80%">
		</div>
		<div class="col-6">
			<div>
				<a href="${contextRoot}/customerservice/allMessages" style="text-decoration: none;">
					<button class="mt-3 mb-4 btn btn-warning">客服紀錄</button>
				</a>		
			</div>
			<div class="w-75">
			<form:form class="form" method="post" modelAttribute="ReceiptMessages" action="${contextRoot}/postMessage" >
			
				<label for="recipient-name" class="col-form-label">請選分類
					<img src="${contextRoot}/img/learning/tagIcon.png" height="15">：
				</label>
				<div class="d-flex mb-3">			
					<div style="width: 100%">
						<select id="typeSelect" name="receiptTypeValue" class="form-select" aria-label="Default select example" required>
							<option value="註冊登入">註冊登入</option>
							<option value="建立課程">建立課程</option>
							<option value="訂單相關">訂單相關</option>
							<option value="折扣碼">折扣碼</option>
							<option value="其他">其他</option>
						</select>		
					</div>
						
					<!-- 新增分類Button觸發Modal
					<button type="button" class="btn btn-outline-info ms-3" data-toggle="modal" data-target="#exampleModal">
					  + 新增
					</button> -->
				</div>
				<!-- 新增分類彈跳視窗Modal -->
				<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
				  <div class="modal-dialog">
				    <div class="modal-content">
				      <div class="modal-header">
				        <h5 class="modal-title" id="exampleModalLabel">新增分類</h5>
				        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
				          <span aria-hidden="true">&times;</span>
				        </button>
				      </div>
				      <div class="modal-body">
				        <input type="text" id="addTypeInput" class="form-control" >
				      </div>
				      <div class="modal-footer">	        
				        <button type="button" class="btn btn-primary" data-dismiss="modal" id="addTypeBTN">新增</button>
				        <button type="button" class="btn btn-secondary" data-dismiss="modal">關閉</button>
				        <button type="button" class="btn btn-outline-info" id="inputOneTypeBTN">一鍵輸入</button>
				      </div>
				    </div>
				  </div>
				</div>
				<!-- end 新增分類彈跳視窗Modal-->
				
				<form:hidden value="${userInformation.id}" path="userId" class="form-control" />
				<form:hidden value="尚未回覆" path="status" class="form-control" />
					<div class="mb-3">
						<label class="form-label">標題</label>
						<form:input path="title" class="form-control" id="msgtitle"/>
					</div>
					<div class="mb-3">
						<label class="form-label">意見</label>
						<form:textarea path="message" class="form-control" style="height: 110px" id="msgQuestion"/>
					</div>
				
					<button type="submit" class="btn btn-success mt-4 mb-5">送出留言</button>
					<button type="button" class="btn btn-outline-info mt-4 mb-5" id="inputOneMsgBTN">一鍵輸入</button>
				</form:form>
			</div>								
		</div>
	</div>
</div><!-- container end -->
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
// 新增ReceiptMessagesType
$(document).ready(function() {
	$("#addTypeBTN").on("click", () => {
		let optionValue = $("#addTypeInput").val();
		let option = document.createElement("option");
		
		$(option).attr("value", optionValue);
		$(option).attr("selected", "selected");
		$(option).text(optionValue);	
		
		$("#typeSelect").append(option);
	});
})
//一鍵輸入NewType
$("#inputOneTypeBTN").click(function() {
	$("#addTypeInput").val("");
});
//一鍵輸入CusMessage
$("#inputOneMsgBTN").click(function() {
	$("#msgtitle").val("請問老師該如何建立課程？");
	$("#msgQuestion").val("我看了常見問題，並沒有找到如何建立課程的相關教學，是否能請客服人員協助我？");
});

</script>
</body>
</html>