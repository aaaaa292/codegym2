<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- 開啟新的一頁。這些東西都要複製，不能功能會失效 起始 -->
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!-- 開啟新的一頁。這些東西都要複製，不能功能會失效 結束-->

<jsp:include page="../common/navigate.jsp" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>會員修改</title>
<c:set var="contextRoot" value="${pageContext.request.contextPath}" />

<link rel="stylesheet" href="${contextRoot}/css/learning/addCourse.css">
<style>
.hide {
	display: none;
}
</style>
</head>
<body>
	<div class="container text-center">
		<h1>會員資訊</h1>
		<form id="create_customer" class="border-style:groove;" method="post"
			action="${contextRoot}/member/edit/editStudentInfo"
			enctype="multipart/form-data">
			<input type="text" id="userId" class="form-control" name="userId"
				value="${userInformation.id}" hidden />
			<!--           上傳大頭傳 -->
			<div id="photo">
				<img id="img1"
					src="data:image/jpeg;base64,${userInformation.base64Photo}"
					width="150" height="150" class="rounded-circle"> <br>
				<button type="button" id="photoBtn" style="display: none;">更換大頭貼</button>
			</div>
			<div class="form-floating">
				<!-- 				<input type="file" name="photo" id="getFile" class="form-control" -->
				<%-- 					value="${userInformation.phone}" style="display: none;" required> --%>
			</div>
			<br>
			<!-- Text input -->
			<div class="row justify-content-md-center align-items-center">
				<div class="col-lg-4">
					<div class="form-outline mb-4">
						<label class="form-label" for="name">姓名</label> <input type="text"
							id="name" class="form-control" name="name"
							value="${userInformation.name}" required />

					</div>
				</div>
			</div>
			<!-- Email input -->
			<div class="row justify-content-md-center align-items-center">
				<div class="col-lg-4">
					<div class="form-outline mb-4">
						<label class="form-label" for="email">電子郵件</label> <input
							type="email" id="email" class="form-control" name="email"
							value="${userInformation.email}" required disabled />
					</div>
				</div>
			</div>
			<!-- Password input -->
			<div class="row justify-content-md-center align-items-center">
				<div class="col-lg-4">
					<div class="form-outline mb-4">
						<label class="form-label" for="password">密碼</label> <input
							type="password" id="password" class="form-control"
							name="password" value="${userInformation.password}" required />
					</div>
				</div>
			</div>
			<div id="checkPasswordBox"
				class="row justify-content-md-center align-items-center hide">
				<div class="col-lg-4">
					<div class="form-outline mb-4">
						<label class="form-label" for="checkPassword">確認密碼</label> <input
							type="password" id="checkPassword" class="form-control"
							name="checkPassword" value="${userInformation.password}" required />
					</div>
				</div>
			</div>
			<!-- Phone input -->
			<div class="row justify-content-md-center align-items-center">
				<div class="col-lg-4">
					<div class="form-outline mb-4">
						<label class="form-label" for="phone">電話號碼</label> <input
							type="text" id="phone" class="form-control" name="phone"
							value="${userInformation.phone}" required />
					</div>
				</div>
			</div>
			<div class="form-row">
				<div class="col mb-3">
					<label for="checkbox">請勾選您所想要學習的課程</label> <input type="checkbox"
						id="HTML" name="Interestcourses" value="HTML">HTML <input
						type="checkbox" id="CSS" name="Interestcourses" value="CSS">CSS
					<input type="checkbox" id="JavaScript" name="Interestcourses"
						value="JavaScript">JavaScript <input type="checkbox"
						id="JQuery" name="Interestcourses" value="JQuery">JQuery <input
						type="checkbox" id="Java" name="Interestcourses" value="Java">Java
					<input type="checkbox" id="Servlet" name="Interestcourses"
						value="Servlet">Servlet <input type="checkbox" id="Python"
						name="Interestcourses" value="Python">Python <input
						type="checkbox" id="PHP" name="Interestcourses" value="PHP">PHP
					<input type="checkbox" id="MySQL" name="Interestcourses"
						value="MySQL">MySQL <input type="checkbox" id="sqlServer"
						name="Interestcourses" value="sqlServer">SQL server
					<p>
				</div>
			</div> 
			<div class="form-row">
				<div class="col mb-3">
					<label for="role">學程式時間?</label> <input type="radio" id="lg1"
						name="learningexperience" value="1">1年以下 <input
						type="radio" id="lg2" name="learningexperience" value="2">1～3年
					<input type="radio" id="lg3" name="learningexperience" value="3">3年以上
					<p>
				</div>
			</div>

			<button type="submit" id="modifyBTN" class="btn btn-primary">修改</button>
			<input type="text" id="idInterest" class="form-control"
				name="idInterest" value="${userInformation.id}" hidden />
		</form>
	</div>
	<jsp:include page="../common/footer.jsp" />
</body>
<!-- 表單結束 -->
<script>
$("#modifyBTN").click(function(e) {
	if(e.target.innerHTML == "修改") {
		e.target.innerHTML = "儲存";
		$("#name").removeAttr("disabled");
		$("#password").removeAttr("disabled");
		$("#phone").removeAttr("disabled");
		$("#checkPasswordBox").removeClass("hide");
	}
	else {
		e.target.innerHTML = "修改";
		$("#name").prop('disabled', true);
		$("#password").prop('disabled', true);
		$("#phone").prop('disabled', true);
		$("#checkPasswordBox").addClass("hide");
		
		let urlString = '${contextRoot}/member/edit/${userInformation.id}?name=' 
			+ $("#name").val()
			+ '&password='+ $("#password").val()
			+ '&phone='+ $("#phone").val();
		$.ajax({
			type:"POST",
			url: urlString,  
		    success: function() {
					console.log("儲存成功");
			 	}
		});
	}
});
	
	var userInterest="${userInterest}";
	var learningexperience="${userInterest.learningexperience}";
	var Interestcourses="${Interestcourses}";

	$( document ).ready(function() {
	// 學程式時間趙滋千註冊的資料幫她選起來
		$("#lg"+learningexperience).click();
//	 	sessio存的課程資料有選過的課程幫他打勾
		initInterestcourses(Interestcourses);
	});
	function initInterestcourses(Interestcourses) {
		let InterestcoursesArr = Interestcourses.split(',');
		InterestcoursesArr.forEach(function(item, i) {
		  console.log(i, item)
		  $("#"+item).attr('checked', true);
		});
	}


// $("#modifyBTN").click(function(e) {
// 	console.log(e.target);
// 	if(e.target.innerHTML == "修改") {
// 		e.target.innerHTML = "儲存";
// 		$("#name").removeAttr("disabled");
// 		$("#password").removeAttr("disabled");
// 		$("#phone").removeAttr("disabled");
// 		$("#checkPasswordBox").removeClass("hide");
// 	}
// 	else {
// 		e.target.innerHTML = "修改";
// 		$("#name").prop('disabled', true);
// 		$("#password").prop('disabled', true);
// 		$("#phone").prop('disabled', true);
// 		$("#checkPasswordBox").addClass("hide");
// 	}
// });

/* Set click on photoBtn */
// document.getElementById("photoBtn").addEventListener("click", function (e) {
//     document.getElementById('getFile').click();
// });

/* Set click on image */
// document.getElementById("img1").addEventListener("click", function (e) {
//     document.getElementById('getFile').click();
// });
/* Change images after upload */
// document.getElementById("getFile").addEventListener("change", function (e) {
//     let file = e.target.files[0];
//     var reader = new FileReader();
//     reader.onloadend = function() {
//         console.log(reader.result);
//         let img = document.getElementById("img1");
//         img.setAttribute("src", reader.result);
//     }
//     reader.readAsDataURL(file);
// });

//網頁載入的時候會自動執行
// document.addEventListener("DOMContentLoaded", () => {
// // 會員的性別
// var gender="${userInformation.gender}";
// console.log("gender:"+gender);
// // 判斷會員的性別是男性還是女性，去把畫面直選起來
// if (gender == "male") {
// 		//找出radio男性的選項做點擊得動作
// 	    document.querySelector('input[name=gender][value="male"]').click();
// 	} else if (gender  == "Female") {
// 		//找出radio女性的選項做點擊得動作
// 	    document.querySelector('input[name=gender][value="Female"]').click();
// 	}
// });
// //網頁載入的時候會自動執行
// document.addEventListener("DOMContentLoaded", () => {
// // 會員的使用權限
// var role="${userInformation.role}";
// console.log("role:"+role);
// // 判斷會員是老師還是學生，去把畫面直選起來
// if (role == "1") {
// 		//找出role老師的選項做點擊得動作
// 	    document.querySelector('input[name=role][value="1"]').click();
// 	} else if (role == "2") {
// 		//找出role學生的選項做點擊得動作
// 	    document.querySelector('input[name=role][value="2"]').click();
// 	}
// });

</script>
</html>
