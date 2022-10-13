<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="contextRoot" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${receiptMessages.title}</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel='stylesheet' href='https://fonts.googleapis.com/css?family=Roboto'>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<style type="text/css">
#wrapper{
	width: 100% !important;
	min-height: calc(100% - 219px) !important;
	padding-bottom: 0 !important;
}
</style>
</head>
<body>

<!-- 導覽列 -->
<jsp:include page="../common/navigate.jsp" />
	
<div class="container">	
	<div class="row justify-content-center mt-5 mb-3">
		<div class="col-8" style="display: flex; justify-content: space-between;">
			<div>
			<a href="${contextRoot}/customerservice/allMessages">
				<button class="btn btn-warning">回上一頁</button>
			</a>	
			</div>
		</div>
	</div>
</div>	
	    
<div class="container" id="wrapper">	
	<div class="row justify-content-center mt-2 mb-3">
    	<div class="col-8">
	      	<div class="w3-card w3-white py-2 px-4" style="border-radius: 15px;">
		        <div class="w3-container">
					<h3 class="w3-opacity pt-4"><b>${receiptMessages.title}</b></h3>
					<h6 class="w3-text-teal">
						<span class="w3-tag w3-teal">
							<fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${receiptMessages.time}" />
						</span>
					</h6>
					<br>
					<div class="d-flex" style="justify-content: space-between; align-items: center;">
						<p>${receiptMessages.message}</p>
					</div>
					<hr>
					<!-- //////////////////////////////////// -->
					<div class="pb-4">
   						<p class="w3-opacity mt-2" id="reMsg">${receiptMessages.replyMessages.message }</p>   						
						<p class="w3-opacity"><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" 
						   	   value="${receiptMessages.replyMessages.time}"/></p>						   
					</div>					
		        </div>
	        </div>
		</div>
	</div>		
</div> <!-- container div -->
<jsp:include page="../common/footer.jsp" />

</body>
</html>