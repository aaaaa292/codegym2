<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%-- <jsp:include page="layout/navbarPostView.jsp" /> --%>

<c:set var="contextRoot" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${post.title}</title>

<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css"
	integrity="sha384-GJzZqFGwb1QTTN6wy59ffF1BuGJpLSa9DkKMp0DgiMDm4iYMj70gZWKYbI706tWS"
	crossorigin="anonymous">
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/js/bootstrap.min.js"
	integrity="sha384-B0UglyR+jN6CkvvICOB2joaf5I4l3gm9GU6Hc1og6Ls7i6U/mkkaduKaBhlAXv9k"
	crossorigin="anonymous"></script>

<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js"
	integrity="sha384-wHAiFfRlMFy6i5SRaxvfOCifBUQy1xHdJ/yoi7FRNXMRBu5WHdZYu1hA6ZOblgut"
	crossorigin="anonymous"></script>


<style type="text/css">
.postContent img {
	width: 30%;
}

.imgPreview {
	display: none;
	top: 0;
	left: 0;
	width: 100%; /*容器佔滿整個螢幕*/
	height: 100%;
	position: fixed;
	background: rgba(0, 0, 0, 0.5);
	z-index: 999;
}

.imgPreview img {
	z-index: 100;
	width: 60%;
	position: fixed;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
}
/*新增滑鼠移入圖片效果*/
.img {
	cursor: url("ico/放大鏡.png"), auto;
}

body.onePost {
	background-color: #eee;
}

div.onePost {
	background-color: #fff;
}

div.post-content {
	border: 2px solid #000000;
	padding: 20px 20px;
	box-shadow: 10px 10px 10px rgba(220, 220, 220, 0.3);
	border-radius: 5px;
	margin-top: 30px;
	z-index:999;
}

span.tag {
	font-size: 13px;
	color: white;
	background-color: #4F4F4F;
	border-radius: 15px;
	padding: 3px 8px;
	margin: 0 2px;
}
</style>

</head>

<body class="onePost">
	<jsp:include page="../common/navigate.jsp" />
	
	<div class="container-fluid border onePost">
		
			<img src="${contextRoot}/img/interaction/posts.png">

		
		<div class="row" style="background-color: #FFFFB9; padding: 40px 0 0 0;">
			<!-- 00 -->
			<div class="col-1" style="margin: 5% 1% 0 5%">
				<a href="${contextRoot}/post/showAllPosts"
								style="text-decoration: none;"> <img
								src="${contextRoot}/img/interaction/back2.png" height="60"
								title="回討論區"></a> 
			</div>
			<!-- 00 -->
			<div class="col-7" style="background-color: #FFED97">
				<div style="text-align: right;"
					class="mt-4 edit-link d-flex justify-content-between  align-items-end">
					<div class="d-flex align-items-center">
						<h2 class="me-3">標題：${post.title}</h2>
						<span style="color: #aaa;"><fmt:formatDate
								pattern="yyyy/MM/dd HH:mm:ss" value="${post.time}" /></span>
					</div>
					<c:if test="${post.userInformation.id == userInformation.id}">
						<div class="me-2">
							<a href="${contextRoot}/post/editPost/${post.id}"
								style="text-decoration: none;"> <img
								src="${contextRoot}/img/interaction/edit.png" height="30"
								title="編輯文章">
							</a> <a onclick="return confirm('確認刪除?')"
								href="${contextRoot}/post/deletePost/${post.id}"> <img
								src="${contextRoot}/img/interaction/delete.png" height="30"
								title="刪除文章">
							</a>
						</div>
					</c:if>
				</div>
				<div>
					<c:forEach var="t" items="${post.postTags}">
						<span class="tag bmb-4">${t.tag}</span>
					</c:forEach>
				</div>
				<br/>
				<input type="hidden" name="id" value="${post.id}">

				<%-- 				<img class="img img-fluid" alt="未上傳圖片" src="${contextRoot}/post/getImg?id=${post.id}"> --%>

				<!-- 				<img class="img img-fluid" alt="未上傳圖片" -->
				<%-- 					src="data:image/jpeg;base64,${base64String}"> --%>

				<div class="imgPreview">
					<img src="#" alt="" id="imgPreview">
				</div>
				<div class="mt-2">
					<div class="d-flex align-items-center">
						<img
							src="data:image/jpeg;base64,${post.userInformation.base64Photo}"
							class="me-3" height="33" width="33"> <span
							style="font-size: 20px; face: monospace"><strong>發文用戶：${post.userInformation.name}&emsp;</strong></span>

					</div>

				</div>
				<div class="post-content">
					<!-- 					<ul class="post-meta list-inline"> -->
					<!-- 						<li class="list-inline-item"><i class="fa fa-calendar-o"></i> -->
					<%-- 							<fmt:formatDate pattern="yyyy/MM/dd HH:mm:ss" --%>
					<%-- 								value="${post.time}" /></li> --%>
					<!-- 					</ul> -->

					<div class="postContent">${post.postContent}</div>
				</div>



				<br />

				<div class="card mt-3 pb-4" style="background-color: #FFBB77;">
					<div class="card-header"><strong>回覆發文</strong></div>
					<div class="card-body">
						<form class="form" method="post"
							action="${contextRoot}/comment/insertComment">
							<input name="postId" type="hidden" value="${post.id}" /> <strong>回覆內容</strong>
							<textarea name="comment" class="form-control"></textarea>
							<button type="submit" class="btn btn-dark mt-2 mb-3">對此文章留言</button>
						</form>
					</div>

					<c:forEach var="c" items="${post.postComments}">
						<div class="card mx-3 mb-1" style="background-color:#FFAF60">
							<div class="card-header d-flex justify-content-between ">
								<div class="d-flex align-items-center">
									<img
										src="data:image/jpeg;base64,${post.userInformation.base64Photo}"
										class="rounded-circle me-3" height="30" width="30"> <span><strong>留言者：${c.userInformation.name}
										</strong></span>
								</div>
								<div>
									<fmt:formatDate pattern="yyyy/MM/dd HH:mm:ss"
										value="${c.time}" />
								</div>
							</div>
							<div class="card-body">
								<p class="card-text">${c.comment}</p>
							</div>
						</div>
					</c:forEach>

				</div>
			</div>
				<div class="col-2" style="margin: 4% 0 0 4%">
				
				<div class="w3-card-2 w3-khaki w3-center">
					<p style="padding-top: 15px;"><strong>程式人徵才</strong></p>
					<img src="${contextRoot}/img/interaction/adPP.png" style="width: 100%">
				</div>
				<br>
				<br>
				<br>
				<div class="w3-card-2 w3-khaki w3-center">
					<p style="padding-top: 15px;"><strong>CodeGym學習網</strong></p>
					<img src="${contextRoot}/img/interaction/advertise.png" style="width: 100%">
				</div>
				<br>
				<br>
				<br>
				<div class="w3-card-2 w3-khaki w3-center">
					<p style="padding-top: 15px;"><strong>校園徵才</strong></p>
					<img src="${contextRoot}/img/interaction/adSchool.jpg" style="width: 100%">
				</div>
			</div>
		</div>
		<!-- container col -->
	</div>
	<!-- container row -->

	<jsp:include page="../common/footer.jsp" />


	<script type="text/javascript">
	$(function() {

	    $('.postContent img').on('click', function() {

		var src = $(this).attr('src');
		$('.imgPreview img').attr('src', src);
		$('.imgPreview').show()
	    });
	    $('.imgPreview').on('click', function() {

		$('.imgPreview').hide()
	    });
	})
    </script>
</body>
</html>