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
<title>發文討論區</title>

<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css"
	integrity="sha384-GJzZqFGwb1QTTN6wy59ffF1BuGJpLSa9DkKMp0DgiMDm4iYMj70gZWKYbI706tWS"
	crossorigin="anonymous">


<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css?family=Oswald">
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css?family=Open Sans">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

<link
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css"
	rel="stylesheet">

<style>
div.postRow {
	border: 2px solid #000000;
}

div.row {
	margin: 0 auto;
}

div.titleContent {
	overflow: hidden;
}

div.imgContent {
	width: 100%;
	height: 380px;
	overflow: hidden;
}

div.imgContent>img {
	width: 100%;
}

div.postContent {
	width: 80%;
	height: 50px;
	overflow: hidden;
}

h1, h2, h3, h4, h5, h6 {
	font-family: Arial, Helvetica, sans-serif;
}

body.post {
	font-family: Arial, Helvetica, sans-serif;
	background-color: #FFFFB9;
}

div.postarea {
	background-color: #FFED97;
}

header.post {
	width: 100%;
	height: 200px;
	background-color: #eee;
	background-image: url("${contextRoot}/img/interaction/posts.png");
}

.addContainer {
	position: absolute;
	left: 110px;
	top: 80px;
}

.addContainer a {
	display: block;
	width: 100%;
	height: 100%;
}

.addContainer .icon_plus {
	position: absolute;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
	margin: 0 auto;
	font-size: 36px;
	light-height: 1;
	font-size: 36px;
	
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
<body class="post">
	<!-- 導覽列 -->
	<jsp:include page="../common/navigate.jsp" />

	<header class="w3-display-container post">
		<div class="w3-display-middle w3-center">
			<%-- 			<img src="${contextRoot}/img/interaction/posts.jpg"> --%>
		</div>
	</header>

	<!-- 新增按鈕 -->
	<div style="position: relative;">
		<div class="addContainer" style="">
			<a href="${contextRoot}/post/addPost">
				<button class="w3-button w3-circle w3-amber p-0"
					style="width: 60px; height: 60px">
					<div class="icon_plus">+</div>
				</button>
			</a>
		</div>


	</div>

	<!-- -------文章------- -->
	<div class="postContainer mt-5" style="width: 77%; margin: 0 auto;">
		<div class="row justify-content-center">

			<div class="postarea"
				style="width: 60%; padding: 40px; margin: 0 0 0 10px" id="itemsCard">
				<c:forEach var="post" items="${postPage.content}" varStatus="status">
					<div class="postRow mb-2" style="border-style: solid">
						<div class="imgContent">
							<a href="${contextRoot}/post/showOnePost/${post.id}"> <img
								class="img img-fluid"
								src="${contextRoot}/post/getImg?id=${post.id}" width="100%">
							</a>

						</div>

						<div class="p-4">
							<h2>標題：${post.title}</h2>
							<div class="mb-4">
								<ul class="post-meta list-inline">
									<li class="mb-2 mt-3">
										<!-- 使用者頭貼 --> <img
										src="data:image/jpeg;base64,${post.userInformation.base64Photo}"
										class="rounded-circle me-2" height="30"> 作者
										${post.userInformation.name}&ensp;
										<c:forEach var="t" items="${post.postTags}">
											<span class="tag bmb-4">${t.tag}</span>
										</c:forEach>
									</li>
									<li class="ms-2"><i class="fa fa-clock-o"></i> 發文時間 
									<span class="postTime"><fmt:formatDate
											pattern="yyyy/MM/dd HH:mm:ss" value="${post.time}" /></span></li>
								</ul>
							</div>

							<!-- Read More按鈕 -->
							<div class="titleContent d-flex justify-content-between">
								<div class="d-flex align-items-center">
									<a href="${contextRoot}/post/showOnePost/${post.id}"
										class="btn btn-outline-dark"><strong>閱讀文章</strong></a>
								</div>
							</div>
						</div>
					</div>
					<br />
					<br />
				</c:forEach>
			</div>

			<!-- -------right------- -->
			<div class="rightContainer" style="width: 30%; margin: 0 0 0 10px">

				<!-- search -->
				<div class="mb-4 mt-2 ms-3">
					<form name="input" action="${contextRoot}/post/search" method="get"
						class="d-flex">
						<input type="search" name="keyword" value="標題關鍵字查詢"> <input
							id="keywordSearch" type="submit" value="查詢">
					</form>
				</div>
				
				<!-- 下拉式查詢 -->
				<div>
							<select id="sortSelect" class="form-select"
								aria-label="Default select example">
								<option value="" selected>選擇排序方式</option>
								<option value="dateDESC">新到舊</option>
								<option value="dateASC">舊到新</option>
							</select>
						</div>

				<!-- Tags -->
				<div class="w3-white w3-margin">
					<div class="w3-container w3-padding w3-amber">
						<h3>標籤</h3>
					</div>
					<div class="w3-container w3-khaki w3-padding-16">
						<a href="${contextRoot}/post/search?keyword=HTML"><span class="badge badge-dark">&ensp;HTML&ensp;</span></a>
						<a href="${contextRoot}/post/search?keyword=CSS"><span class="badge badge-dark">&ensp;CSS&ensp;</span></a>
						<a href="${contextRoot}/post/search?keyword=JavaScript"><span class="badge badge-dark">&ensp;JavaScript&ensp;</span></a>
						<a href="${contextRoot}/post/search?keyword=JQuery"><span class="badge badge-dark">&ensp;JQuery&ensp;</span></a>
						<a href="${contextRoot}/post/search?keyword=Java"><span class="badge badge-dark">&ensp;Java&ensp;</span></a>
						<a href="${contextRoot}/post/search?keyword=Servlet"><span class="badge badge-dark">&ensp;Servlet&ensp;</span></a>
						<a href="${contextRoot}/post/search?keyword=Python"><span class="badge badge-dark">&ensp;Python&ensp;</span></a>
						<a href="${contextRoot}/post/search?keyword=PHP"><span class="badge badge-dark">&ensp;PHP&ensp;</span></a> 
						<a href="${contextRoot}/post/search?keyword=MySQL"><span class="badge badge-dark">&ensp;MySQL&ensp;</span></a>
						<a href="${contextRoot}/post/search?keyword=sqlServer"><span class="badge badge-dark">&ensp;SqlServer&ensp;</span></a> 			 
					</div>
				</div>
				<hr>

				<!-- Posts -->
				<div class="w3-white w3-margin">
					<div class="w3-container w3-padding w3-amber">
						<h3>熱門文章</h3>
					</div>
					<c:forEach var="post" items="${postPage.content}"
						varStatus="status" begin="1" end="4">
						<ul class="w3-ul w3-hoverable w3-khaki">
							<li class="w3-padding"><a
								href="${contextRoot}/post/showOnePost/${post.id}" class="btn">
									<img
									src="data:image/jpeg;base64,${post.userInformation.base64Photo}"
									class="me-3" height="30"> <span class="w3-large">${post.title}</span>
							</a></li>

						</ul>

					</c:forEach>
				</div>
				<hr>

				<!-- Advertising -->
				<div class="w3-white w3-margin">
					<div class="w3-container w3-padding w3-amber">
						<h3>廣告</h3>
					</div>
					<div class="w3-container w3-khaki w3-padding-16">
						<div class="mt-3 mb-3">
							<img src="${contextRoot}/img/interaction/advertise.png"
								style="width: 100%; border: solid;">
							<!-- 					<img src="https://picsum.photos/600/400/?random=4" style="width: 100%;" > -->
						</div>
					</div>
				</div>
				<hr>

				<!-- Follow Me -->
				<div class="w3-white w3-margin">
					<div class="w3-container w3-amber">
						<h3>關注</h3>
					</div>
					<div class="w3-container w3-khaki w3-padding-16">
						<i class="fa fa-facebook-official w3-hover-opacity"></i> <i
							class="fa fa-instagram w3-hover-opacity"></i> <i
							class="fa fa-snapchat w3-hover-opacity"></i> <i
							class="fa fa-pinterest-p w3-hover-opacity"></i> <i
							class="fa fa-twitter w3-hover-opacity"></i> <i
							class="fa fa-linkedin w3-hover-opacity"></i>
					</div>
				</div>
				<hr>
			</div>
		</div>

		<!-- 分頁 -->
		<div class="row justify-content-center">
			<div class="col-8 text-primary btn-lg">
				<c:forEach var="pageNumber" begin="1" end="${postPage.totalPages}">
					<c:choose>
						<c:when test="${postPage.number != pageNumber -1}">
							<a href="${contextRoot}/post/showAllPosts?p=${pageNumber}">${pageNumber}
							</a>
						</c:when>
						<c:otherwise>
			       ${pageNumber}
			    </c:otherwise>
					</c:choose>
				</c:forEach>
			</div>
		</div>
	</div>

	<jsp:include page="../common/footer.jsp" />

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
	<script>
	// 排序功能
	// 依照日期小到大排序
	var dateASC = function(a, b) {
		let x = $(a).find('.postTime').text();
		let y = $(b).find('.postTime').text();
		console.log("測試1");
		return new Date(x) > new Date(y) ? 1 : -1;
	}
	// 依照日期大到小排序
	var dateDESC = function(a, b) {
		let x = $(a).find('.postTime').text();
		let y = $(b).find('.postTime').text();
		console.log("測試2");
		return new Date(x) > new Date(y) ? -1 : 1;
	}
	// 排序
	function sortByInput(sortBy) {
		var sortEle = $('#itemsCard>div').sort(sortBy);
		$('#itemsCard').empty().append(sortEle);
	}
	// 判斷排序方式
	$("#sortSelect").change(function() {
		let sortMethod = $("#sortSelect option:selected").val();
		if (sortMethod == "dateASC") {
			sortByInput(dateASC);
		} else if (sortMethod == "dateDESC") {
			sortByInput(dateDESC);
		}

	});
	</script>

</body>
</html>