<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="contextRoot" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>留言紀錄</title>
</head>
<body>
<!-- 導覽列 -->
<jsp:include page="../common/navigate.jsp" />
	
<div class="container" id="wrapper">	

	<div class="row justify-content-center mt-2">
		<div class="col-8 d-flex">
			<h1>留言紀錄</h1>
			<a href="${contextRoot}/customerservice/addCusMessage">
				<button class="btn btn-warning ms-3 mt-3">+ 留言給客服</button>
			</a>
		</div>
	</div>
	<div class="row justify-content-center align-items-center">	
		<c:forEach var="receiptMsg" items="${page.content}">			
			<div class="col-8">	
				<div class="card mb-2">
					<div class="card-header d-flex">
						<span class="flex-grow-1">【${receiptMsg.receiptMessageTypes.type}】${receiptMsg.title}</span>
						<span>留言時間 <fmt:formatDate pattern="yyyy/MM/dd HH:mm:ss EEEE" value="${receiptMsg.time}" /></span>						
					</div>
					<div class="d-flex align-items-center">
						<div class="card-body w-75">${receiptMsg.message}</div>	
						<div>
							<a href="${contextRoot}/customerservice/oneMessage/${receiptMsg.id}" class="ms-2">
								<c:if test="${receiptMsg.status == '已回覆'}">
										<button class="btn btn-success me-3">${receiptMsg.status}</button>
								</c:if>
								<c:if test="${receiptMsg.status == '尚未回覆'}">
										<button class="btn btn-secondary me-3">${receiptMsg.status}</button>
								</c:if>
							</a>						
						</div>
					</div>
				</div>
			</div>				
		</c:forEach>
	</div>
</div>
<jsp:include page="../common/footer.jsp" />
<script type="text/javascript">

</script>
</body>
</html>