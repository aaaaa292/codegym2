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
<title>查詢發文</title>
</head>
<jsp:include page="layout/navbarPostView.jsp" />
<body>

<c:forEach var="post" items="${postPage}">
			<div class="row justify-content-center">

				<div class="col-10">

					<div class="card border border-dark">

						<div class="card-header">
							<div
								style="display: flex; justify-content: space-between; margin: 10px">

								<div class="justify-content-center">
									<img src="${contextRoot}/img/interaction/cactus.png"
										height="80">
								</div>
								<a href="${contextRoot}/post/showOnePost/${post.id}"
									style="text-align: left"
									class="btn fw-bolder text-success btn-lg active col-7"> <!-- 								<div style="text-align: left" class="col-8"> -->

									<span>發文標題：${post.title}</span> <br /> <span>發文作者：${post.userInformation.name}</span>

								</a>

								<!-- 								</div> -->

								<div style="text-align: right; display: block;"
									class="fw-bolder">
									最後發文時間：
									<fmt:formatDate pattern="yyyy/MM/dd HH:mm:ss EEEE"
										value="${post.time}" />

								</div>

							</div>

						</div>
						<div class="card-body">
							<div
								style="display: flex; justify-content: space-between; margin: 10px">
								<div class="justify-content-center">
									<img src="${contextRoot}/img/interaction/blog.png" height="80">
								</div>
								<a href="${contextRoot}/post/showOnePost/${post.id}"
									style="text-align: left"
									class="btn fw-bolder text-success btn-lg active col-7"> <!-- 								<div style="text-align: left" class="col-8"> -->

									<span id="hutia">文章內容：</span> <br /> <span>&emsp;&emsp;${post.postContent}</span>
									<br />
								</a>
								<div style="text-align: right; display: block;"
									class="fw-bolder">
									&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&nbsp;文章編號：&nbsp;${post.id}</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<br />
		</c:forEach>

</body>
</html>