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
<title>回文檢視區</title>

<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css"
	integrity="sha384-GJzZqFGwb1QTTN6wy59ffF1BuGJpLSa9DkKMp0DgiMDm4iYMj70gZWKYbI706tWS"
	crossorigin="anonymous">
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/js/bootstrap.min.js"
	integrity="sha384-B0UglyR+jN6CkvvICOB2joaf5I4l3gm9GU6Hc1og6Ls7i6U/mkkaduKaBhlAXv9k"
	crossorigin="anonymous"></script>

<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
	integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
	crossorigin="anonymous"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js"
	integrity="sha384-wHAiFfRlMFy6i5SRaxvfOCifBUQy1xHdJ/yoi7FRNXMRBu5WHdZYu1hA6ZOblgut"
	crossorigin="anonymous"></script>
</head>
<jsp:include page="layout/navbarPostView.jsp" />
<body>

<div id="fb-root"></div>
	<!-- 跑馬燈 -->
	<marquee DIRECTION="" VSPACE="30" HSPACE="30" BGCOLOR="#000000"
		SCROLLAMOUNT="15">
		<font size="6" color="orange"> 最新回文:${lastestComment.comment}
			</font>
	</marquee>
						<!-- content為JPA的BEAN -->	
	<div class="container">
	<%-- 		<c:forEach var="comment" items="${post.postComments}"> --%>
<%-- 				${comment.id} --%>
		<c:forEach var="postComment" items="${commentPage.content}">
			<div class="row justify-content-center">
				<div class="col-10">
					<div class="card">

						<div class="card-header">
							<div
								style="display: flex; justify-content: space-between; margin-bottom: 10px;">
							
								<div>
<!-- 									<a href="${contextRoot}/comment/showAllComments/${postComment.id}" 
										class="btn text-primary btn-lg active">  </a> -->
										發文ID:${postComment.post.id}
										<br />
										發文內容:${postComment.post.title}
										<br />
										發文內容:${postComment.post.postContent}
										<br />
										<br />
										回文ID:${postComment.id}
										<br />
										回覆: ${postComment.comment}
										
										
									<%-- 									內容:${post.postContent} --%>
								</div>

								<div style="text-align: right; display: block;">
									最後回文時間:
									<fmt:formatDate pattern="yyyy/MM/dd HH:mm:ss EEEE"
										value="${postComment.time}" />
								</div>

							</div>

						</div>

					</div>
				</div>
			</div>
			<br />
		</c:forEach>

		<div class="row justify-content-center">
			<div class="col-8 text-primary btn-lg">
				<c:forEach var="pageNumber" begin="1" end="${postPage.totalPages}">

					<c:choose>

						<c:when test="${postPage.number != pageNumber -1}">
							<a href="${contextRoot}/post/showAllPosts?p=${pageNumber}">
								${pageNumber} </a>

						</c:when>

						<c:otherwise>
				       ${pageNumber}
				    </c:otherwise>

					</c:choose>

				</c:forEach>
			</div>
		</div>


	</div>

</body>
</html>