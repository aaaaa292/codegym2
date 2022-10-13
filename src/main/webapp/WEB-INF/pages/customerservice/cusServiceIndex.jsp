<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="contextRoot" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>常見FQA</title>

<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Lato">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Montserrat">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="https://unpkg.com/aos@next/dist/aos.css" />

<style>
.w3-third img{
	margin-bottom: -6px; opacity: 0.8; cursor: pointer
}
.w3-third img:hover{
	opacity: 1
}
a > img:hover{
	transform:scale(1.1,1.1);
}
div.goToTop{
	z-index: 0;
	position: fixed;
	bottom: 100px;
	right: 25px;	
}
div.goToTop:hover{
	transform:scale(1.1, 1.1);	
}
div.dialogflowBTN{
	z-index: 1;
	position: fixed;
	bottom: 15px;
	right: 15px;	
}
div.dialogflowBTN:hover{
	transform:scale(1.1, 1.1);
}
div.dialogflow{
	display: none;
	position: fixed;
	bottom: 40px;
	right: 50px;
}
header.cusService {
	width: 100%;
	height: 216px;
	background-color: #eee;
	background-image: url("${contextRoot }/img/customerservice/cusheader.jpg");
	background-size: contain;
}
</style>
</head>
<body>
<!-- 導覽列 -->
<jsp:include page="../common/navigate.jsp" />

<header class="w3-display-container cusService">
	<div class="w3-display-middle w3-center">
	</div>
</header>

<!-- Header -->
<header class="w3-center" style="padding: 40px 0 20px 0;">
	<div class="jumbotron jumbotron-fluid">
		<div class="container">
			<h1 class="w3-center" data-aos="fade-up">常見FQA</h1>
			<p class="lead" data-aos="fade-up">Provide the best service to all participants.</p>
		</div>
	</div>
</header>

<div class="main container text-center">
	<div class="row justify-content-center" id="QATypeBTN">
		<c:forEach var="questionTypes" items="${QuestionTypesList}">
			<div style="width: 14rem;" data-aos="zoom-out">
					<a id="typeLink" href="${contextRoot}/customerservice/Type/${questionTypes.id}">
						<img src="${contextRoot}/customerservice/getImg?typeId=${questionTypes.id}" style="width: 180px; height: 180px; border-radius: 50%;">
<!-- 						<img src="https://picsum.photos/400/400/?random=1" class="card-img-top" style="border-radius: 50%;"> -->
					</a>
				<div class="card-body">
					<p class="card-text"><h4>${questionTypes.type}</h4></p>
				</div>
			</div>		
		</c:forEach>
	</div>
</div>


<div class="w3-content" style="max-width:1100px">
 	<!-- CusstomerServiceMessage Section -->
	<div class="w3-row w3-padding-16" id="about">
		<div class="w3-col m6 w3-padding-large w3-hide-small" data-aos="fade-left" >
			<img src="${contextRoot }/img/customerservice/cusService.jpg" class="w3-round w3-image w3-opacity-min" style="width: 700px;">
		 </div>
		
		 <div class="w3-col m6 w3-padding-small w3-padding-64" data-aos="fade-right">
			<h1 class="w3-center">歡迎提供您寶貴的意見</h1>
			<h5 class="w3-center">2022-09-07</h5><br>			
			<p class="w3-large" style="text-align: justify;">
				我們竭誠歡迎您的建言和迴響，如果您對我們提供的服務有任何建議或意見，請您不吝指教隨時告知，
				好讓我們知道，並做妥善的處理，如果您有任何新的構想，也歡迎能提供給我們參考改進。
			</p>
			<p>– CODEGYM.</p>			
			<p class="w3-large w3-text-grey w3-hide-medium" style="text-align: justify;">
				Lorem Ipsum is simply dummy text of the standard dummy printing and typesetting industry.
			</p>			
			<a href="${contextRoot}/customerservice/addCusMessage" class="nav-link px-2 link-dark" style="text-align: center;">
				<button class="btn btn-lg btn-success mt-3" style="width: 180px;">意見反饋</button>
			</a>
		</div>
	</div>
	
	 <!-- About Section -->
	<div class="w3-row" id="about" style="padding-bottom: 110px;">
		<div class="w3-col m4 w3-padding-large" data-aos="fade-left">
			<h1>聯絡我們</h1>
			<p><b>服務時間週一至週五 09:00 ~ 17:30</b></p>
			<p><b>歡迎您與我們聯絡，享受貼心與優質的數位生活</b></p><br>
			<p><i class="fa fa-map-marker w3-text-teal w3-xlarge"></i>　106台北市大安區復興南路一段390號2樓</p>
			<p><i class="fa fa-phone w3-text-teal w3-xlarge"></i>　( 02 ) 6631 6588</p>
			<p><i class="fa fa-envelope-o w3-text-teal w3-xlarge"></i>　test@test.com</p>
			<hr>
			<div class="mt-4">
				<div class="mb-3">
					也歡迎進入聊天室，真人客服在此為你服務。
				</div>
				<a class="mt-4" href="${contextRoot}/customerservice/chat/${userInformation.name}"  style="padding: 0;">
					<button class="btn btn-warning btn-lg" style="width: 180px">線上客服</button>
				</a>
			</div>		
		 </div>
		
		 <div class="w3-col m8 w3-padding-small" style="text-align: right;" data-aos="fade-right">
		 	<iframe src="https://www.google.com/maps/embed?pb=!1m14!1m8!1m3!1d14460.01880763059!2d121.543412!3d25.0339145!3m2!
		 	1i1024!2i768!4f13.1!3m3!1m2!1s0x0%3A0xedc006d25a9e35df!2z6LOH5bGV5ZyL6Zqb6IKh5Lu95pyJ6ZmQ5YWs5Y-4!5e0!3m2!1szh-TW!
		 	2stw!4v1660807985007!5m2!1szh-TW!2stw"
		 	width="600" height="450" style="border:0;" allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade">
		 	</iframe>	
		</div>
	</div>
</div>

<!-- 移置頂層 -->
<div class="goToTop">
	<a href="#"><img src="${contextRoot}/img/customerservice/top.png" height="50"></a>
</div>

<!-- Dialogflow 機器人 -->
<div class="dialogflowBTN">
	<img src="${contextRoot}/img/customerservice/hibot.png" height="65">
</div>

<div class="dialogflow">
	<iframe
	    allow="microphone;"
	    width="350"
	    height="430"
	    src="https://console.dialogflow.com/api-client/demo/embedded/36f4c62f-979c-4dad-b8e1-c26f1d6a58ef"
	    style="border:1px solid #aaa;">
	</iframe>
</div>

<!-- footer -->
<jsp:include page="../common/footer.jsp" />

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://unpkg.com/aos@next/dist/aos.js"></script>
<script>
//AOS動畫
AOS.init();

// Dialogflow 機器人
$(function(){	 
	$('.dialogflowBTN').on('click', function(){
	  $('.dialogflow').fadeToggle(0);
	})	 
})
</script>
</body>
</html>