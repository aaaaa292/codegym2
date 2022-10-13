<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- 開啟新的一頁。這些東西都要複製，不能功能會失效 起始 -->
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!-- 開啟新的一頁。這些東西都要複製，不能功能會失效 結束-->



<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>會員註冊</title>
<c:set var="contextRoot" value="${pageContext.request.contextPath}" />
<!-- web icon -->
<link rel="icon" href="${contextRoot}/img/member/icon.png">

<!-- ~~~抓這裡~~~-->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-gH2yIJqKdNHPEq0n4Mqa/HGKIhSkIHeL5AyhkYV8i59U5AR6csBvApHHNl/vI1Bx"
	crossorigin="anonymous">


<!-- !!!!!Font Awesome -->
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"
	rel="stylesheet" />
<link href="${contextRoot}/css/member/bootstrap.min.css"
	rel="stylesheet">

<!-- !!!!!Font Awesome -->
<link href="${contextRoot}/css/member/all.min.css" rel="stylesheet" />

<!-- Google Fonts -->
<link
	href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700&display=swap"
	rel="stylesheet" />
<!-- MDB -->
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/4.4.0/mdb.min.css"
	rel="stylesheet" />
<!-- ~~~抓這裡~~~-->

<style>
body {
	background-color: #DEFFFF;
}

#photo {
	text-align: center;
}

#photo img {
	border-radius: 80px;
	width: 150px;
	height: 150px;
	margin-bottom: 10px;
}

#photo img:hover {
	opacity: 0.7;
	cursor: pointer;
}

#photo button {
	border: 1px solid #021111;
	border-radius: 8px;
	width: 100px;
	height: 30px;
}

#photo button:hover {
	cursor: pointer;
	color: #f0f8ff;
	background-color: #3d3b3b;
	border: 4px solid #f0f8ff;
}

#radio input[type="radio"] {
	display: none;
}

#radio input:checked+.button {
	background: #5e7380;
	color: #fff;
	cursor: default;
}

#radio .button {
	display: inline-block;
	margin: 0 5px 10px 0;
	padding: 5px 10px;
	background: #f7f7f7;
	color: #333;
	cursor: pointer;
}

#radio .button:hover {
	background: #bbb;
	color: #fff;
}

#radio .round {
	border-radius: 5px;
}

div.ex {
	background-color: #e5eecc;
	padding: 7px;
	border: solid 1px #c3c3c3;
}
</style>
</head>

<body>
	<jsp:include page="../common/navigate.jsp" />
	<div class="form_footer " style="text-align: right;">
		<button class="btn btn-primary fastLogin" id="studentOneKey">學生:陳同學</button>
		<button class="btn btn-primary fastLogin" id="teacherOneKey">老師:曾老師</button>
		<!-- 				<button class="btn btn-primary fastLogin">Emma</button> -->
		<!-- 				<button class="btn btn-primary fastLogin">Jim</button> -->
	</div>
	<div class="container text-center">
		<form action="${contextRoot}/member/add/result" method="post"
			enctype="multipart/form-data">
			<!--  上傳大頭傳  -->
			<div id="photo">
				<img id="img1" src="${contextRoot}/img/member/A.jpg" /> <br>
				<button type="button" id="photoBtn">上傳大頭貼</button>
			</div>
			<div class="form-floating">
				<input type="hidden" name="photoBase64" id="photoBase64"> <input
					type="file" name="photo" id="getFile" class="form-control"
					style="display: none;" required>
			</div>
			<br>
			<!-- Text input -->
			<div class="row justify-content-md-center align-items-center">
				<div class="col-lg-4">
					<div class="form-outline mb-4">
						<input type="text" id="name" class="form-control" name="name" required />
						<label class="form-label cleanWord" for="name">姓名</label>
					</div>
				</div>
			</div>

			<!-- Email input -->
			<div class="row justify-content-md-center align-items-center">
				<div class="col-lg-4">
					<div class="form-outline mb-4">
						<input type="email" id="email" class="form-control" name="email" required />
						<label class="form-label cleanWord" for="email">Email</label>
					</div>
				</div>
			</div>

			<!-- Password input -->
			<div class="row justify-content-md-center align-items-center">
				<div class="col-lg-4">
					<div class="form-outline mb-4">
						<input type="password" id="password" class="form-control"
							name="password" required /> <label class="form-label cleanWord"
							for="password">密碼</label>
					</div>
				</div>
			</div>
			<div class="row justify-content-md-center align-items-center">
				<div class="col-lg-4">
					<div class="form-outline mb-4">
						<input type="password" id="password234" class="form-control"
							name="password234" required /> <label class="form-label cleanWord"
							for="password">確認密碼*</label>
					</div>
				</div>
			</div>

			<!-- Phone input -->
			<div class="row justify-content-md-center align-items-center">
				<div class="col-lg-4">
					<div class="form-outline mb-4">
						<input type="text" id="phone" class="form-control" name="phone" required />
						<label class="form-label cleanWord" for="phone">電話</label>
					</div>
				</div>
			</div>

			<!-- Gender input -->
			<div class="row justify-content-md-center align-items-center">
				<div class="col-lg-1">性別:</div>
				<div class="form-check form-check-inline col-lg-1">
					<input class="form-check-input" type="radio" name="gender"
						id="inlineRadio1" value="Male"> <label
						class="form-check-label" for="inlineRadio1">男</label>
				</div>
				<div class="form-check form-check-inline col-lg-1">
					<input class="form-check-input" type="radio" name="gender"
						id="inlineRadio2" value="Female"> <label
						class="form-check-label" for="inlineRadio2">女</label>
				</div>
			</div>
			<br>

			<!-- birthday input -->
			<div class="row justify-content-md-center align-items-center">
				<div class="col-lg-4">
					<label for="birthday" class="t1">生日</label> <input type="date"
						name="birthday" id="birthday">
				</div>
			</div>
			<br>
			<!-- Role input -->
			<div class="row justify-content-md-center align-items-center">
				<div class="col-lg-1">身份:</div>
				<div class="col-lg-2" id="radio">
					<label> <input type="radio" id="student" name="role"
						value=2> <span class="round button">學生</span>
					</label> <label> <input type="radio" id="teacher" name="role"
						value=1> <span class="round button">老師</span>
					</label>

				</div>
			</div>
			<br>

			<!-- 權限顯示老師才會顯示出來 -->
			<div id="teacherExperienceBlock">
				<!-- 				<div class="row justify-content-md-center align-items-center"> -->
				<!-- 					<div class="col-lg-4"> -->
				<!-- 						<div class="form-outline mb-4"> -->
				<!-- 							<input type="text" id="expertise" class="form-control" -->
				<!-- 								name="expertise" /> <label class="form-label cleanWord"  for="expertis">專長</label> -->
				<!-- 						</div> -->
				<!-- 					</div> -->
				<!-- 				</div> -->
				<br>
				<div class="row justify-content-md-center align-items-center">
					<div class="col-lg-4">
						<div class="form-outline mb-4">
							<input type="text" id="experience" class="form-control"
								name="experience" /> <label class="form-label"
								for=" experience">學經歷</label>
						</div>
					</div>
				</div>
				<br>
				<div class="row justify-content-md-center align-items-center">
					<div class="col-lg-4">
						<div class="form-outline mb-4">
							<input type="text" id="expertise" class="form-control"
								name="expertise" /> <label class="form-label" for="expertis">專長</label>
						</div>
					</div>
				</div>
				<br>
				<div class="row justify-content-md-center align-items-center">
					<div class="col-lg-4">
						<div class="form-outline mb-6">

							<input type="text" id="teaching" class="form-control"
								name="teaching" style="height: 180px" /><label
								class="form-label" for="teaching ">教學特色</label>

						</div>

					</div>
				</div>
			</div>
			<br>
			<div id="studentinterest">
				<div class="form-row">
					<div class="col mb-3">
						<label for="checkbox">請勾選您感興趣的項目</label> <input type="checkbox"
							id="HTML" name="Interestcourses" value="HTML">HTML <input
							type="checkbox" id="CSS" name="Interestcourses" value="CSS">CSS
						<input type="checkbox" id="JavaScript" name="Interestcourses"
							value="JavaScript">JavaScript <input type="checkbox"
							id="JQuery" name="Interestcourses" value="JQuery">JQuery
						<input type="checkbox" id="Java" name="Interestcourses"
							value="Java">Java <input type="checkbox" id="Servlet"
							name="Interestcourses" value="Servlet">Servlet <input
							type="checkbox" id="Python" name="Interestcourses" value="Python">Python
						<input type="checkbox" id="PHP" name="Interestcourses" value="PHP">PHP
						<input type="checkbox" id="MySQL" name="Interestcourses"
							value="MySQL">MySQL <input type="checkbox" id="sqlServer"
							name="Interestcourses" value="sqlServer">SQL server
						<p>
					</div>
				</div>
				<div class="form-row">
					<div class="col mb-3">
						<label for="role">請問您學程式時間?</label> <input type="radio"
							id="learningexperience1" name="learningexperience" value="1">1年以下
						<input type="radio" name="learningexperience" value="2">1～3年
						<input type="radio" name="learningexperience" value="3">3年以上
						<p>
					</div>
				</div>
			</div>
			<!-- Submit button -->
			<button type="submit" class="btn btn-primary"onclick="myFunction()">加入會員</button>
			<button type="submit" class="btn btn-secondary">取消</button>
			<!-- Submit button -->
		</form>

	</div>
	<br>
	<jsp:include page="../common/footer.jsp" />
</body>
<!-- ~~~抓這裡~~~-->
<script
	src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.5/dist/umd/popper.min.js"
	integrity="sha384-Xe+8cL9oJa6tN/veChSP7q+mnSPaj5Bcu9mPX5F5xIGE0DVittaqT5lorf0EI7Vk"
	crossorigin="anonymous"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/js/bootstrap.min.js"
	integrity="sha384-ODmDIVzN+pFdexxHEHFBQH3/9/vQ9uori45z4JjnFsRydbmQbmL5t1tQ0culUzyK"
	crossorigin="anonymous"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-A3rJD856KowSb7dwlZdYEkO39Gagi7vIsF0jrRAoQmDKKtQBHUuLZ9AsSv4jD4Xa"
	crossorigin="anonymous"></script>
<!--!!!!! MDB -->

<script type="text/javascript"
	src="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/4.4.0/mdb.min.js"></script>
<!-- ~~~抓這裡~~~-->
<script>
<!--放入大頭照-->
	/* Set click on photoBtn */
	document.getElementById("photoBtn").addEventListener("click", function(e) {
		document.getElementById('getFile').click();
	});

	/* Set click on image */
	document.getElementById("img1").addEventListener("click", function(e) {
		document.getElementById('getFile').click();
	});
	/* Change images after upload */
	document.getElementById("getFile").addEventListener("change", function(e) {
		let file = e.target.files[0];
		var reader = new FileReader();
		reader.onloadend = function() {
			console.log(reader.result);
			let img = document.getElementById("img1");
			img.setAttribute("src", reader.result);
			$("#photoBase64").val(reader.result);
		}
		reader.readAsDataURL(file);
	});
	<!-- 檢查帳號是否重複-->
	  $(function() {
	    $('#email').blur(function(){  
	    	
	    	let email = $("#email").val();
	    	let urlStr = "${contextRoot}/member/checkEmail?email=" + email;
	      $.ajax({
	        url  : urlStr,
	        type : 'POST',
	        dataType : 'text',
	        success: function(data) {
	          if(data=='重複') {
	            alert('申請帳號重複，請輸入其他帳號');
	            document.getElementById("email").value="";	            
	          }
	        }
	      });
	    });
	  });
	  
	  <!-- 顯示專長、學經歷、教學特色-->
	 
// 網頁載入預設點選學生
	$( document ).ready(function() {
		 $("#student").attr('checked', true);
		 showBlock();
	});
// 	如果有變更老師學生權限，判斷要顯示哪個視窗
	$('input:radio[name=role]').change(function () {
		showBlock();
    });
// 	判斷是要顯示老師區塊還是學生區塊
	function	showBlock() {
		var button =$('input[name*=role]:checked').val()
		console.log("button",button);
		
		if(button==1){
			$("#teacherExperienceBlock").show();
		}else{
			$("#teacherExperienceBlock").hide();	
		}	  
		if(button==2){
			$("#studentinterest").show();
		}else{			
			$("#studentinterest").hide();
		}	  
	}		
</script>
<script type="text/javascript">
	//快速註冊-學生
	$("#studentOneKey").click(function() {
		$(".cleanWord").text("");
		$("#name").val("陳同學");
		$("#email").val("coolchenyen@gmail.com");
		$("#password").val("1234");
		$("#password234").val("1234");
		$("#phone").val("09123456789");
		$("#inlineRadio1").click();
		$("#student").click();
		$("#learningexperience1").click();
		$("#birthday").val(getFormattedDate(new Date("2022/8/22")));
		$("#HTML").attr('checked', true);
	});
	//快速註冊-老師
	$("#teacherOneKey").click(function() {
		$(".cleanWord").text("");
		$("#name").val("曾老師");
		$("#email").val("yc557430@gmail.com");
		$("#password").val("1234");
		$("#password234").val("1234");
		$("#phone").val("09987654321");
		$("#inlineRadio2").click();
		$("#teacher").click();
		$("#expertise").val("JAVA");
		$("#experience").val("資社會教學10年");
		$("#teaching").val("簡單易懂的教學，輕鬆學會程式語言");
		$("#birthday").val(getFormattedDate(new Date("1980/08/11")));
		
	});	
	//日期格時調整
	function getFormattedDate(date) {
	    return date.getFullYear()
	        + "-"
	        + ("0" + (date.getMonth() + 1)).slice(-2)
	        + "-"
	        + ("0" + date.getDate()).slice(-2);
	}
	//註冊後顯示彈跳小視窗
	 function myFunction() {
	    alert("請到信箱收取驗證信!");
	  }
</script>
</html>