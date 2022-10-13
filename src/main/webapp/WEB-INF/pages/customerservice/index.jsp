<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="contextRoot" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>線上客服</title>
<link href="${contextRoot}/css/customerservice/main.css" rel="stylesheet" >
</head>
<body>
	<!-- 導覽列 -->
	<jsp:include page="../common/navigate.jsp" />
    
    <noscript>
        <h2>Sorry! Your browser doesn't support Javascript</h2>
    </noscript>

    <!-- 進入頁面 -->
    <div id="username-page">
        <div class="username-page-container">
            <h1 class="title">輸入名稱</h1>
            
            <form id="usernameForm" name="usernameForm">
                <div class="form-group popup">
                    <input type="text" name="userName" id="name" value="${userInformation.name }"
                        autocomplete="off" class="form-control popup" />
                    <span class="popuptext" id="hint">請輸入名稱</span>
                </div>
                <div class="form-group">
                    <button type="submit" class="accent username-submit">開始聊天</button>
                </div>
            </form>
        </div>
    </div>

    <!-- 聊天室頁面 -->
    <div id="chat-page" class="hidden">
        <div class="chat-container">
            <div class="chat-header">
                <h2>線上客服</h2>
            </div>
            <div class="connecting">Connecting...</div>
            <ul id="messageArea">

            </ul>
            <form id="messageForm" name="messageForm">
                <div class="form-group">
                    <div class="input-group clearfix">
                        <input type="text" id="message" placeholder="輸入訊息..."
                            autocomplete="off" class="form-control" />
                        <button type="submit" class="btn btn-primary">送出</button>
                    </div>
                </div>
            </form>
        </div>
    </div>

<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.1.4/sockjs.min.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
<script type="text/javascript" charset="UTF-8" src="${contextRoot}/js/customerservice/main.js?version=1"></script>
</body>
</html>