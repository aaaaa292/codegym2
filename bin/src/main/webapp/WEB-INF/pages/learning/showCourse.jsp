<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<title>${courseProfile.name}</title>

<c:set var="contextRoot" value="${pageContext.request.contextPath}" />

<!-- web icon -->
<link rel="icon" href="${contextRoot}/img/icon.png" />
<!-- 自定義CSS -->
<link rel="stylesheet" href="${contextRoot}/css/learning/showCourse.css" />
</head>

<body>
	<jsp:include page="../common/navigate.jsp" />

	<div class="container" style="margin-top: 50px; width: 70%">
		<div class="container-all">
			<!-- 左邊 -->
			<div class="container-left">
				<!-- 未購買課程隱藏此項 -->
				<c:if test="${!empty bought}">
					<!-- 導覽列 -->
					<nav id="sidebar" style="height: 100%">
						<!-- 展往/縮起來 按鈕 -->
						<button type="button" id="collapse"
							class="btn btn-secondary collapse-btn">
							<img height="20" src="${contextRoot}/img/collapseIcon.png" />
						</button>
						<p class="text-white bg-dark">${courseProfile.name}</p>
						<!-- List 列表 -->
						<ul id="mainList" class="list-unstyled text-start"></ul>
					</nav>
				</c:if>
			</div>
			<!-- 右邊 -->
			<div class="container-right">
				<%-- 				<c:if test="${empty bought}"> --%>
				<!-- 					<button type="button" class="btn btn-info">免費試看內容</button> -->
				<%-- 				</c:if> --%>
				<!-- 影片 -->
				<div class="container-fluid" style="background-color: #ddd; height: 100%; object-fit: contain;"></div>

			</div>
		</div>
	</div>

	<div class="container mt-4" style="width: 70%">
		<!-- 學生才顯示瀏覽課程 -->
		<c:if test="${userInformation.role != 1}">
			<!-- 課程選項 -->
			<div class="row justify-content-md-center align-items-center mx-1"
				id="videoInfoBox">
				<div class="col-3 row text-start">
					<div class="row">
						<div class="d-flex align-items-center ">
							<div class="text-start">
								<img src="${contextRoot}/img/starIcon.png" height="20"> <a
									type="button" id="scoreAvg" data-bs-toggle="modal"
									data-bs-target="#Modal2"></a>
							</div>
							<!-- 已購買課程才可評分 -->
							<c:if test="${!empty bought}">
								<div class="ms-2">
									<button class="addNewScoreBTN btn btn-outline-warning"
										type="button" data-bs-toggle="modal" data-bs-target="#Modal1">幫課程評分</button>
									<!-- 							<a href="">幫此課程評分</a> -->
								</div>
							</c:if>
						</div>
					</div>
				</div>
				<!-- 未購買課程顯示此項 -->
				<c:if test="${empty bought}">
					<div class="col text-center">
						<p class="h3" style="color: #E6E6FA">|</p>
					</div>
					<div class="col-4 text-center">
						NT$${courseProfile.price}
						<button class="btn btn-outline-danger">立即購買</button>
						<button class="btn btn-outline-success">加入購物車</button>
					</div>
				</c:if>
				<div class="col-1 text-center">
					<p class="h3" style="color: #E6E6FA">|</p>
				</div>
				<div class="col text-center">
					<button class="btn btn-outline-primary" style="width: 90px;"
						type="button" data-bs-toggle="modal" data-bs-target="#Modal3">聯絡老師</button>
				</div>
				<div class="col text-center">
					<p class="h3" style="color: #E6E6FA">|</p>
				</div>
				<div class="col text-center">
					<a href="${contextRoot}/customerservice/addCusMessage">
						<button class="btn btn-outline-success" style="width: 90px;">回報問題</button>
					</a>
				</div>
				<hr class="mt-3">
			</div>
		</c:if>
		<!-- 課程簡介 -->
		<div id="videoIntroductionBoxTitle">
			<p class="h3">課程簡介</p>
		</div>
		<div id="videoIntroductionBox">
			<p>${courseProfile.introduction}</p>
		</div>
	</div>

	<!-- 留言板 -->
	<div class="container " style="width: 70%" id="commentBox">
		<div class="container mb-5 mt-5 p-0">
			<div class="card">
				<div class="row">
					<div class="col-md-12">
						<h3 class="text-center mb-5 bg-dark p-3 text-white">留言板</h3>
						<div class="row">
							<div class="col-md-12">
								<div class="media">
									<div class="media-body">
										<c:forEach items="${courseProfile.courseComments}" var="c">
											<div class="row">
												<div class="col-1">
													<img
														src="data:image/jpeg;base64,${c.userInformation.base64Photo}"
														class="mr-3 rounded-circle">
												</div>
												<div class="col-11">
													<h5>
														${c.userInformation.name} <span class="h6"> -
															${c.time}</span> <span class="h6"> <!-- <img
															src="${pageContext.request.contextPath}/img/like.png"
															width="10">x -->
															<button class="likeBTN"
																style="border: none; background: none;">讚數${c.likeCount}</button>
														</span>
													</h5>
													<h6>${c.comment}</h6>
												</div>
											</div>
										</c:forEach>
									</div>
								</div>
							</div>
						</div>
						<br>
						<!-- 已購買課程才可留言 -->
						<c:if test="${!empty bought}">
							<form class="text-center"
								action="${pageContext.request.contextPath}/course/comment/add">
								<div class="form-floating">
									<input class="hide" type="number" value="${courseProfile.id}"
										name="courseId"> <input class="hide" type="number"
										value="${userInformation.id}" name="userId">
									<textarea name="comment" rows="3" cols="100"
										style="width: 100%;" placeholder="請在此輸入留言:" required></textarea>
								</div>
								<div class="mb-2">
									<button class="w-25 btn btn-lg btn-secondary">送出</button>
								</div>
							</form>
						</c:if>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- 新增評分彈跳視窗 -->
	<div class="modal fade" id="Modal1" tabindex="-1"
		aria-labelledby="Modal1Label" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="Modal1Label">為此課程評分</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="row modal-body">
					<div class="col-3 form-floating">
						<input id="addScoreNumInput" type="number" class="form-control"
							min="1" max="5"> <label>分數(1到5分)</label>
					</div>
					<div class="col-9 form-floating">
						<input id="addScoreCommentInput" type="text" class="form-control">
						<label>在此輸入評論</label>
					</div>
				</div>

				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-bs-dismiss="modal">Close</button>
					<button type="button" class="btn btn-primary" id="addScoreBTN"
						data-bs-dismiss="modal">Add</button>
				</div>
			</div>
		</div>
	</div>
	<!-- 觀看課程評價彈跳視窗 -->
	<div class="modal fade" id="Modal2" tabindex="-1"
		aria-labelledby="Modal2Label" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="Modal2Label">課程評價</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="row modal-body" id="scoresContent"></div>
			</div>
		</div>
	</div>
	<!-- 老師聯絡資訊彈跳視窗 -->
	<div class="modal fade" id="Modal3" tabindex="-1"
		aria-labelledby="Modal3Label" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="Modal3Label">老師聯絡資訊</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="row modal-body" id="scoresContent">
					<p>姓名: ${courseProfile.userInformation.name}</p>
					<p>電子郵件: ${courseProfile.userInformation.email}</p>
				</div>
			</div>
		</div>
	</div>
	<jsp:include page="../common/footer.jsp" />
	<!-- js code -->
	<script src="${contextRoot}/js/learning/showCourse.js"></script>
	<script>
			// 取得課程評分
			<c:set var="scoreTimes" value="${0}" />
			<c:set var="scoreTotal" value="${0}" />
			<c:forEach items="${courseProfile.courseScores}" var="courseScore">
				<c:set var="scoreTimes" value="${scoreTimes + 1}" />
				<c:set var="scoreTotal" value="${scoreTotal + courseScore.score}" />
			</c:forEach>
			// 計算平均評分
			<c:if test="${scoreTimes != 0}">
				<c:set var="scoreAvg" value="${scoreTotal / scoreTimes}" />
			</c:if>
			// 還沒有人評分的情況
			<c:if test="${scoreTimes == 0}">
				<c:set var="scoreAvg" value="${0}" />
			</c:if>
			
			// 把課程資訊存成JSON
			let course = {
				// 課程基本資訊
				"courseName": "${courseProfile.name}",
				"teacher": "${courseProfile.userInformation.name}",
				"uploadTime": "${courseProfile.time}",
				"coursePrice": "${courseProfile.price}",
				"scoreAvg": "${scoreAvg}",
				"courseChapters": [
				<c:forEach items="${courseProfile.courseChapters}" var="courseChapter">
					{
						"id" : "${courseChapter.id}",
						"number" : "${courseChapter.number}",
						"name" : "${courseChapter.name}",
						"courseDetails" : [
						<c:set var="views" value="${0}" />
						<c:set var="rates" value="${0}" />
						<c:forEach items="${courseChapter.courseDetails}" var="courseDetail">
							// 觀看次數
							<c:forEach items="${courseDetail.userCourseViews}" var="view">
								<c:set var="views" value="${views + 1}" />
							</c:forEach>
							// 課程進度
							<c:forEach items="${courseDetail.userCourseProgressRate}" var="rate">
								<c:if test="${rate.userInformation.id == userInformation.id}">
									<c:set var="rates" value="${rate.rate}" />
								</c:if>
							</c:forEach>
							{
								"id" : "${courseDetail.id}",
								"section" : "${courseDetail.section}",
								"name" : "${courseDetail.name}",
								"uploadTime" : "${courseDetail.time}",
								"views" : "${views}",
								"rates" : "${rates}",
								"userFavorite" : [
								    <c:forEach items="${courseDetail.userFavoriteCourses}" var="userFavoriteCourse">
								    	{
								    		"userId" : "${userFavoriteCourse.userInformation.id}"
								    	},
								    </c:forEach>
								]
							},
						</c:forEach>
						]
					},
				</c:forEach>
				]
			}
			
		//開始填入課程資訊
			
			// 把平均評分放入scoreImg
			$("#scoreAvg").text(course.scoreAvg+' (${scoreTimes})');
			// 把標題跟影片放到右邊div
			function createRightDivHtml(i, j) {
			 // 判斷是否已收藏後更改文字及樣式
			 	let word = "收藏";
				let BTNclass = "btn-outline-warning";
				course.courseChapters[i].courseDetails[j].userFavorite.forEach(userFavoriteCourse => {
				    if(userFavoriteCourse.userId == "${userInformation.id}") {
						word = "已收藏";
						BTNclass = "btn-warning";
				    }
				});
			    let chapterName = (course.courseChapters[i].name).split(".");
// 			    justify-content-md-center align-items-center
			    let rightDivHtml = "";
				rightDivHtml += '<div class="row justify-content-md-around align-items-center text-white bg-dark p-2" id="title">'
				rightDivHtml += '<c:if test="${empty bought}"><button class="btn btn-info" style="width: 120px;">免費試看內容</button></c:if>'
				rightDivHtml += '<div class="col-8 h2 mt-1">第' + chapterName[0] + '章 ' + chapterName[1] + ': ' + course.courseChapters[i].courseDetails[j].name + '</div>';
				rightDivHtml += '<div class="col-2">觀看次數:' + course.courseChapters[i].courseDetails[j].views + '</div>';
				rightDivHtml += '<p id="courseDetailId" style="display: none;">' + course.courseChapters[i].courseDetails[j].id + '</p>';
				// 已購買課程才可留言收藏課程
				rightDivHtml += '<div class="col-2"><c:if test="${!empty bought && userInformation.role != 1}"><button type="button" id="keepVideoBTN" class="btn ' + BTNclass + '"';
				rightDivHtml += ' onclick="keepFavoriteVideo(0, 0, ' + course.courseChapters[i].courseDetails[j].id + ')">' + word + '</button></c:if></div></div>';
				rightDivHtml += '<div id="videoContainer"><video id="courseVideo" width="800" height="auto" controls onplay="videoRecord()">';
				rightDivHtml += '<source src="${contextRoot}/course/getVideo?courseDetailId=' + course.courseChapters[i].courseDetails[j].id + '" type="video/mp4"/>';
				rightDivHtml += '</video></div>';
				
				return rightDivHtml;
			}
			
			// 排序課程章節
			course.courseChapters.sort(function (a, b) {
				return a.number - b.number;
			});
			
			// 把章節跟小節放到左邊list
			let leftListHtml = "";
			let i = 0;
			course.courseChapters.forEach(courseChapter => {
				//console.log(courseChapter);
				// 放章節
				leftListHtml += '<li><a href="#sublist' + courseChapter.id + '" data-bs-toggle="collapse" id="dropdown">' + courseChapter.name + '</a></li>';
				leftListHtml += '<ul id="sublist' + courseChapter.id + '" class="list-unstyled collapse">';
				// 排序課程小節
				courseChapter.courseDetails.sort(function (a, b) {
					return a.section - b.section;
				});
				
				// 放小節到左邊列表
				let j = 0;
				courseChapter.courseDetails.forEach(courseDetail => {
				    // 設定左邊列表小節按鈕
					leftListHtml += '<li><button style="width:100%;" type="button" class="btn btn-secondary text-start"';
					leftListHtml += ' onclick="changeSection(' + i +', ' + j + ', ' + courseDetail.id;
					leftListHtml += ', \'' + courseChapter.name + '-' + courseDetail.name + '\')">';
					leftListHtml += courseChapter.number + "-"  + courseDetail.section + " " + courseDetail.name + ' <span class="badge bg-info text-dark">' + course.courseChapters[i].courseDetails[j].rates*100 + '%</span></button></li>';
					j ++;
				});
				leftListHtml += '</ul>';
				i ++;
			});
			$(".list-unstyled").append(leftListHtml);
			
			// 載入第一部影片的設定
			let rightDivHtml = createRightDivHtml(0, 0)
			
			$(".container-right .container-fluid").append(rightDivHtml);
			
			// 更換課程小節影片按鈕
			function changeSection(i, j, courseDetailId, title) {
			 	// 判斷是否已收藏後更改文字及樣式
			 	let word = "收藏";
				let BTNclass = "btn-outline-warning";
				course.courseChapters[i].courseDetails[j].userFavorite.forEach(userFavoriteCourse => {
				    if(userFavoriteCourse.userId == "${userInformation.id}") {
						word = "已收藏";
						BTNclass = "btn-warning";
				    }
				});
				// 把標題跟影片放到右邊div
				let rightDivHtml = createRightDivHtml(i, j);
				$(".container-right .container-fluid").html("");
				$(".container-right .container-fluid").append(rightDivHtml);
			}
			
			// 收藏影片按鈕
			function keepFavoriteVideo(i, j, courseDetailId) {
			    // 新增收藏影片
			    if($("#keepVideoBTN").html() == "收藏") {
					$("#keepVideoBTN").removeClass("btn-outline-warning");
				    $("#keepVideoBTN").addClass("btn-warning");
				    $("#keepVideoBTN").html("已收藏");
				    
				    let urlString = '${contextRoot}/course/favorite/keep/' + courseDetailId;
					$.ajax({
						type:"POST",
						url: urlString,  
						dataType : 'text',
					    success: function(data) {
						 	if(data == '收藏成功') {
						 	  	course.courseChapters[i].courseDetails[j].userFavorite.push({'userId' : '${userInformation.id}'});
						 	  	console.log(course);
								console.log("收藏成功");
						 	}
						},
		
					});
				}
			 	// 刪除收藏影片
			    else {
					$("#keepVideoBTN").addClass("btn-outline-warning");
				    $("#keepVideoBTN").removeClass("btn-warning");
				    $("#keepVideoBTN").html("收藏");
				    
				    let urlString = '${contextRoot}/course/favorite/remove/' + courseDetailId;
					$.ajax({
						type:"POST",
						url: urlString,  
						dataType : 'text',
					    success: function(data) {
						 	if(data == '取消收藏') {
						 	   course.courseChapters[i].courseDetails[j].userFavorite.forEach((userFavoriteCourse, index) => {
						 	       if(userFavoriteCourse.userId == '${userInformation.id}') {
						 		  		console.log(course);
						 		  		course.courseChapters[i].courseDetails[j].userFavorite.splice(index, 1);
						 		  		console.log(course);
						 	       }
						 	   });
								console.log("取消收藏");
						 	}
						},
		
					});
			    }
			}
			
			// 每3秒記錄一次觀看進度並判斷觀看次數
			function videoRecord() {
			    saveRateIntervId = setInterval(saveRate, 3000);
			    addViewsIntervId = setInterval(addViews, 3000);
			}
			
			// 計算課程進度並儲存
			function saveRate() {
			 	// 取得影片長度(秒)
			    let duration = document.getElementById('courseVideo').duration;
			 	// 取得觀看時間
			    let currentTime = document.getElementById('courseVideo').currentTime;
			 	// 計算課程進度
			 	let rate = (currentTime / duration).toFixed(2);
			 	console.log("進度: " + rate*100 + "%");
			 	
			 	// 用ajax紀錄觀看進度
		 		let urlString = '${contextRoot}/course/progress/update/' + $("#courseDetailId").text() +'?rate=' + rate;
				$.ajax({
				    type : "POST",
				    url : urlString,
				    success : function(result) {
				    }
				});
				
				// 完成課程結束紀錄
			 	if(rate == 1) {
			 		console.log("完成此課程");
			 		clearInterval(saveRateIntervId);
			 	}
			 	//
			}
			
			// 判斷是否增加觀看次數
			function addViews() {
			 	// 取得影片長度(秒)
			    let duration = document.getElementById('courseVideo').duration;
			 	
			 	// 判斷觀看時間超過影片長度一半就算觀看一次
			    let setTime = duration / 2;

			 	// 取得觀看時間
			 	let currentTime = document.getElementById('courseVideo').currentTime;
			 	if(currentTime > setTime){
			 		console.log("觀看一次");
			 	  	clearInterval(addViewsIntervId);
			 	  	// 用ajax紀錄觀看次數
 			 	  	let urlString = '${contextRoot}/course/views/add/' + $("#courseDetailId").text();
					$.ajax({
					    type : "POST",
					    url : urlString,
					    success : function(result) {
					    }
					});
			 	}
			}
			
			// 新增評分及評論
			$("#addScoreBTN").on("click", () => {
				let score = $("#addScoreNumInput").val();
				let comment = $("#addScoreCommentInput").val();
				
				// 用ajax紀錄評分及評論
		 	  	let urlString = '${contextRoot}/course/score/add/${courseProfile.id}?score=' + score + '&comment=' + comment;
				$.ajax({
				    type : "POST",
				    url : urlString,
				    success : function(result) {
				    }
				});
			});
			
			// 載入課程評價
			$("#scoreAvg").on("click", () => {
			 	// 用ajax取得此課程評價
		 	  	let urlString = '${contextRoot}/course/score/show/${courseProfile.id}';
				$.ajax({
				    type : "GET",
				    url : urlString,
				    success : function(result) {
						let content = "";
						$(result).each(function (index, element) {
						    content += "<p>["+ element.time + "]" + element.score + "分-" + element.userName + ":" + element.comment + "</p>";
						});
						$("#scoresContent").html("");
						$("#scoresContent").append(content);
						console.log(result);
				    }
				});
			});
		</script>
</body>
</html>
