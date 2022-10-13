<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<c:set var="contextRoot" value="${pageContext.request.contextPath }" />

<link href="${contextRoot}/css/interaction/bootstrap.min.css" rel="stylesheet" />
</head>
<body>	

<nav class="navbar navbar-expand-lg navbar-light bg-light">
  <a class="navbar-brand" href="${contextRoot}/">首頁</a>
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNavDropdown" aria-controls="navbarNavDropdown" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>
  <div class="collapse navbar-collapse" id="navbarNavDropdown">
    <ul class="navbar-nav">
      <li class="nav-item active">
        <a class="nav-link" href="${contextRoot}/post/postIndex">新發文首頁<span class="sr-only">(current)</span></a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="${contextRoot}/post/showAllPosts">發文討論區</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="${contextRoot}/post/addPost">發文投稿</a>
      </li>
      <li class="nav-item">						
        <a class="nav-link" href="${contextRoot}/comment/showAllComments">回文檢視區</a>
      </li>																
      <li class="nav-item">
        <a class="nav-link" href="${contextRoot}/post/addComment">回覆發文</a>
      </li>

      
      
      
<!--       <li class="nav-item dropdown"> -->
<!--         <a class="nav-link dropdown-toggle" href="#" role="button" data-toggle="dropdown" aria-expanded="false"> -->
<!--           Dropdown link -->
<!--         </a> -->
<!--         <div class="dropdown-menu"> -->
<!--           <a class="dropdown-item" href="#">Action</a> -->
<!--           <a class="dropdown-item" href="#">Another action</a> -->
<!--           <a class="dropdown-item" href="#">Something else here</a> -->
<!--         </div> -->
      </li>
    </ul>
  </div>
</nav>

<script src="${contextRoot}/js/jquery-3.6.0.min.js"></script>
<script src="${contextRoot}/js/bootstrap.bundle.min.js"></script>

</body>
</html>