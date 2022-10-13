<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CODE GYM</title>

<c:set var="contextRoot" value="${pageContext.request.contextPath}" />

<!-- web icon -->
<link rel="icon" href="${contextRoot}/img/icon.png">
<!-- aos -->
<link rel="stylesheet" href="https://unpkg.com/aos@next/dist/aos.css" />
<!-- 自定義CSS -->
<link rel="stylesheet" href="${contextRoot}/css/common/index.css">

<style>
.card {
	box-shadow: 5px 5px 7px rgba(0, 0, 0, 0.7);
}

.card-img-top {
	width: 100%;
	height: 15vw;
	object-fit: cover;
}

.imgContainer {
	position: relative;
	text-align: center;
	color: white;
}

img {
	opacity: 0.8;
}

.centeredBTN {
	position: absolute;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
<!-- font-awesome -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">


<style>
.card {
 box-shadow: 5px 5px 7px rgba(0, 0, 0, 0.7);
}

.card-img-top {
 width: 100%;
 height: 15vw;
 object-fit: cover;
}

.imgContainer {
 position: relative;
 text-align: center;
 color: white;
}

img {
 opacity: 0.8;
}

.centeredBTN {
 position: absolute;
 top: 50%;
 left: 50%;
 transform: translate(-50%, -50%);
}
recommendCard{
	position: relative;
}

div.recommendTag{
	width: 60px;
	height: 60px;
	color: #4D0000;
	background-color: #FFB5B5;
	padding: 8px 0;
	position: absolute;
	right: 0;
	z-index: 2;
}
</style>
</head>
<body>

	<jsp:include page="common/navigate.jsp" />

	<main>
		<div
			class="position-relative overflow-hidden text-center backgroundImg"
			style="height: 500px; position: relative;">
			<div class="col-md-5 p-lg-5 my-5"
				style="margin-right: 300px; position: absolute; top: -60px; left: 365px;"
				data-aos="zoom-in-up">
				<img style="width: 100%" class="mb-2"
					src="${contextRoot}/img/codegymLogo.png">
				<h2>
					<b>最有趣的<span>線上學習平台</span></b>
				</h2>
				<p class="mb-5">學那些學校不會教的事！學習架設網站，整天一直寫CODE一直爽。學習那些學校沒有教的事。破五星評價學習平台。</p>
				<a class="btn btn-lg btn-warning startBTN" style="width: 200px;"
					href="${contextRoot}/course/show"><b>開 始 上 課</b></a>
			</div>
			<div class="product-device shadow-sm d-none d-md-block"></div>
			<div
				class="product-device product-device-2 shadow-sm d-none d-md-block"></div>
		</div>
	</main>

	<div class="w3-content"
		style="max-width: 1564px; margin: auto 0; padding-bottom: 70px">

		<!-- Project Section -->
		<div class="w3-container d-flex justify-content-center mt-5"
			id="projects">
			<h3 class=" w3-bottombar w3-border-dark-grey" data-aos="zoom-out">
				最有趣的課程</h3>
		</div>
		<div class="w3-container d-flex justify-content-center my-3"
			id="projects">
			<h5 class="mb-5" style="text-align: center; width: 60%;"
				data-aos="zoom-out">跳脫以往的教學模式，不受限於時間及地點，只要擁有行動裝置，隨時上課
				打造您的知識變現系統，更可以經營自媒體品牌，成為意見領袖。</h5>
		</div>

		<div class="d-flex justify-content-center px-5" data-aos="fade-up"
			data-aos-anchor-placement="top-bottom">
			<div class="w3-col l2 mx-3">
				<div class="w3-display-container">
					<img src="${contextRoot}/img/javalg.jpg"
						style="width: 100%; border-radius: 50%;">
				</div>
			</div>
			<div class="w3-col l2 mx-3">
				<div class="w3-display-container">
					<img src="${contextRoot}/img/jslg.jpg"
						style="width: 100%; border-radius: 50%;">
				</div>
			</div>
			<div class="w3-col l2 mx-3">
				<div class="w3-display-container">
					<img src="${contextRoot}/img/pythonlg.jpg"
						style="width: 100%; border-radius: 50%;">
				</div>
			</div>
			<div class="w3-col l2 mx-3">
				<div class="w3-display-container">
					<img src="${contextRoot}/img/javalg.jpg"
						style="width: 100%; border-radius: 50%;">
				</div>
			</div>
			<div class="w3-col l2 mx-3">
				<div class="w3-display-container">
					<img src="${contextRoot}/img/jslg.jpg"
						style="width: 100%; border-radius: 50%;">
				</div>
			</div>
			<div class="w3-col l2 mx-3">
				<div class="w3-display-container">
					<img src="${contextRoot}/img/pythonlg.jpg"
						style="width: 100%; border-radius: 50%;">
				</div>
			</div>
			<div class="w3-col l2 mx-3">
				<div class="w3-display-container">
					<img src="${contextRoot}/img/javalg.jpg"
						style="width: 100%; border-radius: 50%;">
				</div>
			</div>
		</div>
	</div>

	
	<div class="container">
		<div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-3" id="itemsCard"></div>
		<br>
		<div class="alert alert-danger text-center" role="alert" id="bottomMsg"></div>
	</div>
	


	<div class="row w-75 mx-auto my-0 pb-1">
		<div class="w3-container d-flex justify-content-center mt-2"
			id="projects">
			<h3 class=" w3-bottombar w3-border-dark-grey" data-aos="zoom-out">
				推薦課程</h3>
		</div>
		<div class="w3-container d-flex justify-content-center my-3"
			id="projects">
			<h5 class="mb-5" style="text-align: center; width: 60%;"
				data-aos="zoom-out">學習趨勢！看看大家都在網路上學什麼？</h5>
		</div>
	</div>
	<!-- 觀看課程評價細項彈跳視窗 -->
	<div class="modal fade" id="scoreAvgBox" tabindex="-1"
		aria-labelledby="scoreAvgBoxLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="scoreAvgBoxLabel">課程評價</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="row modal-body" id="scoresContent"></div>
			</div>
		</div>
	</div>
	<div class="container">
		<div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-3"
			id="itemsCard" style="width: 80%; margin: 0 auto;"></div>
		<br>
		<div class="alert alert-danger text-center" role="alert"
			id="bottomMsg"></div>
	</div>

	<footer class="w3-container w3-center"
		style="background-color: #f8c612;">
		<div class="w3-xlarge w3-section">
			<i class="fa fa-facebook-official w3-hover-opacity mx-2"></i>
			<i class="fa fa-instagram w3-hover-opacity mx-2"></i>
			<i class="fa fa-snapchat w3-hover-opacity mx-2"></i>
			<i class="fa fa-pinterest-p w3-hover-opacity mx-2"></i>
			<i class="fa fa-twitter w3-hover-opacity mx-2"></i>
			<i class="fa fa-linkedin w3-hover-opacity mx-2"></i>
		</div>
	</footer>
	<jsp:include page="common/footer.jsp" />
	<script src="https://unpkg.com/aos@next/dist/aos.js"></script>
	<script>
		AOS.init();// AOS動畫
		var start = 1;
		var end = 3;
		//利用ajax每次載入三筆課程
		$(window).scroll(function() {
				var scrollBottom = $(document).height()
						- $(window).height() - $(window).scrollTop();
				//console.log("scrollTop" + $(this).scrollTop());
				//console.log(scrollBottom);
				if (scrollBottom <= 0) {
					let urlString = '${contextRoot}/course/show/' + start + '/' + end;
					$.ajax({
						type : "GET",
						url : urlString,
						success : function(result) {
						    console.log(result);
						    if(result != ""){
								let courses = "";
								$(result).each(function (index, element) {
									courses += '<div class="col"><div class="card">';
									courses += '<span hidden="hidden" class="quantity">1</span>';
									courses += '<span hidden="hidden" class="courseId">'+element.id+'</span>';
									courses += '<span hidden="hidden" class="courseName">'+element.name+'</span>';
	
									courses += '<div class="imgContainer">';
									courses += '<a href="${contextRoot}/course/'+element.id+'/show">';
									courses += '<img src="${contextRoot}/course/getImg?courseId='+element.id+'" class="card-img-top"></a>';
									
									courses += '<div class="centeredBTN">';
									courses += '<a href="${contextRoot}/course/'+element.id+'/show" class="text-decoration-none">';
									courses += '<button type="button" class="btn btn-success btn-lg">'+element.name+'</button></a></div></div>';
									courses += '<div class="card-body text-center fs-4 text-truncate">';
									courses += '<p class="h6">';
									courses += '<a href="${contextRoot}/course/'+element.id+'/show" class="text-decoration-none text-dark">';
									courses += '<em>'+element.introduction+'</em></a></p></div>';
										
									courses += '<div class="card-footer text-center">';
									$(element.tags).each(function (i, tag) {
										courses += '<a href="${contextRoot}/course/tag/'+tag+'/show">';
										courses += '<span class="badge bg-primary text-white">#'+tag+'</span></a> ';
									});
								
									courses += '</div><div class="card-footer text-center">';
									courses += '<span class="badge rounded-pill bg-secondary">'+element.teacherName+'</span>';
									courses += '<span class="badge rounded-pill bg-dark courseTime">'+element.time+'</span></div>';
								
									courses += '<div class="card-footer text-center">';
									let totalScore = 0;
									let scoreTimes = 0;
									let avgScore = 0;
									$(element.scores).each(function (i, score) {
										totalScore += score;
										scoreTimes ++;
									});
									if(totalScore != 0) {
										let avgScore = totalScore / scoreTimes;
									}
							
									courses += '<img src="${contextRoot}/img/starIcon.png" height="20">';
									courses += '<a type="button" class="scoreAvg text-decoration-none text-dark" ';
									courses += 'data-bs-toggle="modal" data-bs-target="#scoreAvgBox">'+avgScore+'('+scoreTimes+')</a>';
									courses += '</div></div></div>';
								});
								$("#itemsCard").append(courses);
								start = start + 3;
								end = end + 3;
						    }
						    else {
								$("#bottomMsg").text("已至底部");
						    }
						}
					});
				}
				
			});
		$(window)
				.scroll(
						function() {
							var scrollBottom = $(document).height()
									- $(window).height()
									- $(window).scrollTop();
							//console.log("scrollTop" + $(this).scrollTop());
							//console.log(scrollBottom);
							if (scrollBottom <= 0) {
								let urlString = '${contextRoot}/course/show/'+ start + '/' + end;
								//let urlString = '${contextRoot}/course/show/json';
								$.ajax({type : "GET",url : urlString,success : function(result) {
												console.log(result);
												if (result != "") {
													let courses = "";
													$(result).each(function(index,element) {
																		courses += '<div class="col"><div class="card recommendCard" style="width:300px">';
																		courses += '<div class="recommendTag text-center">熱門<br>推薦</div>';
																		courses += '<span hidden="hidden" class="quantity">1</span>';
																		courses += '<span hidden="hidden" class="courseId">'
																				+ element.id
																				+ '</span>';
																		courses += '<span hidden="hidden" class="courseName">'
																				+ element.name
																				+ '</span>';

																		courses += '<div class="imgContainer m-3">';
																		courses += '<a href="${contextRoot}/course/'+element.id+'/show">';
																		courses += '<img src="${contextRoot}/course/getImg?courseId='
																				+ element.id
																				+ '" class="card-img-top"></a>';

																		courses += '<div class="centeredBTN">';
																		courses += '<a href="${contextRoot}/course/'+element.id+'/show" class="text-decoration-none">';
																		courses += '<button type="button" class="btn btn-success btn-lg">'
																				+ element.name
																				+ '</button></a></div></div>';
																		courses += '<div class="card-body text-center fs-4 text-truncate">';
																		courses += '<p class="h6">';
																		courses += '<a href="${contextRoot}/course/'+element.id+'/show" class="text-decoration-none text-dark">';
																		courses += '<em>'
																				+ element.introduction
																				+ '</em></a></p></div>';

																		courses += '<div class="card-footer text-center">';
																		$(
																				element.tags)
																				.each(
																						function(
																								i,
																								tag) {
																							courses += '<a href="${contextRoot}/course/tag/'+tag+'/show">';
																							courses += '<span class="badge bg-primary text-white">#'
																									+ tag
																									+ '</span></a> ';
																						});

																		courses += '</div><div class="card-footer text-center">';
																		courses += '<span class="badge rounded-pill bg-secondary">'
																				+ element.teacherName
																				+ '</span>';
																		courses += '<span class="badge rounded-pill bg-dark courseTime">'
																				+  (new Date(element.time)).toLocaleDateString()
																				+ '</span></div>';

																		courses += '<div class="card-footer text-center">';
																		let totalScore = 0;
																		let scoreTimes = 0;
																		let avgScore = 0;
																		$(element.scores).each(function(i, score) {
																			totalScore += score;
																			scoreTimes++;
																		});
																		if (totalScore != 0) {
																			avgScore = totalScore / scoreTimes;
																		}

																		courses += '<img src="${contextRoot}/img/starIcon.png" height="20">';
																		//courses += '<a type="button" class="scoreAvg text-decoration-none text-dark" ';
      																	//courses += 'data-bs-toggle="modal" data-bs-target="#scoreAvgBox">'
      																	courses += avgScore
																				+ '('
																				+ scoreTimes
																				+ ')</a>';
																		courses += '</div></div></div>';
																	});
													$("#itemsCard").append(
															courses);
													start = start + 3;
													end = end + 3;
												} else {
													$("#bottomMsg")
															.text("已至底部");
												}
											}
										});
							}

						});
	</script>
</body>
</html>