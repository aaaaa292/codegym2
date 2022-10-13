<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html>

<head>
	<meta charset="UTF-8">
	<title>上架課程</title>

	<c:set var="contextRoot" value="${pageContext.request.contextPath}" />

	<!-- web icon -->
	<link rel="icon" href="${contextRoot}/img/icon.png">

	<!-- 自定義CSS -->
	<link rel="stylesheet" href="${contextRoot}/css/learning/addCourse.css">

</head>

<body>
	<jsp:include page="../common/navigate.jsp" />

	<div class="container" id="wrapper">
		<main class="form-signin" style="padding-top: 80px;">
			<div style="color: red">${message}</div>

			<form id="mainForm" action="${contextRoot}/course/add/result" method="post" enctype="multipart/form-data">
				<input name="userId" type="hidden" value="${userInformation.id}">
				<h1 class="h3 text-center mb-3 fw-normal">輸入課程資訊</h1>
				<br>

				<!-- 輸入課程名稱 -->
				<div id="firstStepInput" class="container text-center">
					<div class="row justify-content-md-center align-items-center">
						<div id="addCourseNameInput" class="col col-lg-3 hide">
							<input type="text" value="" style="width: 100%" placeholder="輸入課程名稱">
						</div>
						<div id="addCourseNameSelect" class="col col-lg-3 hide">
							<select id="courseProfileSelect" style="width: 100%">
								<c:forEach items="${courseProfiles}" var="courseProfile">
									<option value="${courseProfile.id}">${courseProfile.name}</option>
								</c:forEach>
							</select>
						</div>
						<div id="addCourseNameBTN" class="col col-lg-3">
							<button type="button" class="btn btn-outline-success">+
								上傳全新課程</button>
						</div>
						<div id="selectCourseNameBTN" class="col col-lg-3">
							<button type="button" class="btn btn-outline-warning">
								<!-- <img width="20" height="20" src="${contextRoot}/img/dropDownIcon.png"> -->
								+ 新增章節內容
							</button>
						</div>

						<div id="changeBTN" class="col col-lg-1 hide">
							<button type="button" class="btn btn-outline-danger">返回</button>
						</div>
					</div>
				</div>
				<div id="courseTitle" class="text-center hide">
					<!-- 上一步填的課程名稱 -->
					<div class="row">
						<div class="form-floating col-12">
							<input id="courseName" name="courseName" type="hidden" class="form-control">
							<input id="courseNameShow" type="text" class="form-control"> <label>課程名稱</label>
						</div>
					</div>
				</div>
				<br>
				<!-- 輸入課程資訊 -->
				<div id="secondStepInput" class="hide">
					<div class="row">
						<div class="form-floating col-6">
							<input id="coursePrice" name="coursePrice" type="number" class="form-control" min="0"
								required> <label>課程價格</label>
						</div>
						<div class="form-floating col-6">
							<input id="courseImg" name="courseImg" type="file" class="form-control" required>
							<label>課程封面</label>
						</div>
					</div>
					<br>
					<div class="row align-items-center">
						<div class="col-2">
							請選擇標籤 <img src="${contextRoot}/img/learning/tagIcon.png" height="20"> :
						</div>
						<div class="col-10 text-center">
							<div class="form-check form-check-inline">
								<input class="form-check-input" type="checkbox" name="programmingLanguages[]"
									id="HTMLCheckbox" value="HTML">
								<label class="form-check-label" for="HTMLCheckbox">HTML</label>
							</div>
							<div class="form-check form-check-inline">
								<input class="form-check-input" type="checkbox" name="programmingLanguages[]"
									id="CSSCheckbox" value="CSS">
								<label class="form-check-label" for="CSSCheckbox">CSS</label>
							</div>
							<div class="form-check form-check-inline">
								<input class="form-check-input" type="checkbox" name="programmingLanguages[]"
									id="JavaScriptCheckbox" value="JavaScript"> <label class="form-check-label"
									for="JavaScriptCheckbox">JavaScript</label>
							</div>
							<div class="form-check form-check-inline">
								<input class="form-check-input" type="checkbox" name="programmingLanguages[]"
									id="JQueryCheckbox" value="JQuery"> <label class="form-check-label"
									for="JQueryCheckbox">JQuery</label>
							</div>
							<div class="form-check form-check-inline">
								<input class="form-check-input" type="checkbox" name="programmingLanguages[]"
									id="JavaCheckbox" value="Java">
								<label class="form-check-label" for="JavaCheckbox">Java</label>
							</div>
							<div class="form-check form-check-inline">
								<input class="form-check-input" type="checkbox" name="programmingLanguages[]"
									id="ServletCheckbox" value="Servlet"> <label class="form-check-label"
									for="ServletCheckbox">Servlet</label>
							</div>
							<div class="form-check form-check-inline">
								<input class="form-check-input" type="checkbox" name="programmingLanguages[]"
									id="PythonCheckbox" value="Python"> <label class="form-check-label"
									for="PythonCheckbox">Python</label>
							</div>
							<div class="form-check form-check-inline">
								<input class="form-check-input" type="checkbox" name="programmingLanguages[]"
									id="PHPCheckbox" value="PHP">
								<label class="form-check-label" for="PHPCheckbox">PHP</label>
							</div>
							<div class="form-check form-check-inline">
								<input class="form-check-input" type="checkbox" name="programmingLanguages[]"
									id="MySQLCheckbox" value="MySQL">
								<label class="form-check-label" for="MySQLCheckbox">MySQL</label>
							</div>
							<div class="form-check form-check-inline">
								<input class="form-check-input" type="checkbox" name="programmingLanguages[]"
									id="sqlServerCheckbox" value="sqlServer"> <label class="form-check-label"
									for="sqlServer">SQL server</label>
							</div>
						</div>
						<!--<div class="col-1">
							<button id="addNewLangBTN" class="btn btn-secondary" type="button" data-bs-toggle="modal" data-bs-target="#Modal1">新增</button>
						</div>-->
					</div>
					<div class="row">
						<div class="form-floating col-12">
							<input name="courseIntroduction" id="courseIntroduction" type="text" class="form-control"> <label>課程介紹</label>
						</div>
					</div>
				</div>
				<br>
				<!-- 輸入課程影片 -->
				<div id="thirdStepInput" class="hide">
					<div id="addVideosBox">
						<div id="addVideosTop" class="row align-items-center">
							<div class="col-8 text-left">上傳課程影片</div>
							<div id="addVideosIcon" class="col-4 text-end">收合</div>
						</div>
						<div id="addVideosBottom" class="hide">
							<div class="uploadVideo row align-items-center hide">
								<div class="col-3 form-floating">
									<select name="courseChapter" class="chapterSelect form-select"
										aria-label="Default select example" required>
									</select> <label>請選擇章節</label>

								</div>
								<div class="col-1 form-floating">
									<button class="addNewChapterBTN btn btn-secondary" type="button"
										data-bs-toggle="modal" data-bs-target="#Modal2">新增</button>
								</div>
								<div class="col-1 form-floating">
									<input type="number" class="form-control" name="courseSection" min="1">
									<label>課程小節</label>
								</div>
								<div class="col-2 form-floating">
									<input type="text" class="form-control" name="courseSectionName"> <label>名稱</label>
								</div>
								<div class="col-2 form-floating">
									<input type="file" class="form-control" name="courseVideo">
									<label>上傳影片</label>
								</div>
								<div class="col-2 form-floating">
									<input type="file" class="form-control" name="courseHomeworkFile">
									<label>作業附件</label>
								</div>
								<div class="col-1 form-floating">
									<button class="removeNewVideoBTN btn btn-danger" type="button">刪除</button>
								</div>
							</div>

							<div class="uploadVideo row align-items-center">
								<div class="col-3 form-floating">
									<select id="courseChapterSelect" name="courseChapter" class="chapterSelect form-select"
										aria-label="Default select example" required>
									</select> <label>請選擇章節</label>
								</div>
								<div class="col-1 form-floating">
									<button class="addNewChapterBTN btn btn-secondary" type="button"
										data-bs-toggle="modal" data-bs-target="#Modal2">新增</button>
								</div>
								<div class="col-1 form-floating">
									<input type="number" class="form-control" name="courseSection" min="1">
									<label>課程小節</label>
								</div>
								<div class="col-2 form-floating">
									<input type="text" class="form-control" name="courseSectionName"> <label>名稱</label>
								</div>
								<div class="col-2 form-floating">
									<input type="file" class="form-control" name="courseVideo">
									<label>上傳影片</label>
								</div>
								<div class="col-2 form-floating">
									<input type="file" class="form-control" name="courseHomeworkFile">
									<label>作業附件</label>
								</div>
								<div class="col-1 form-floating">
									<button class="removeNewVideoBTN btn btn-danger" type="button">刪除</button>
								</div>
							</div>

							<div id="addNewVideoBTN" class="row align-items-center ">
								<div class="col-12 form-floating text-center">
									<button type="button" class="btn btn-info">+</button>
								</div>
							</div>

						</div>

					</div>
				</div>
				<br>

				<div id="BTNs" class="text-center">
					<div id="previousBTN" class="mb-2 hide">
						<button type="button" class="w-25 btn btn-lg btn-outline-dark">上一步</button>
					</div>
					<div id="nextBTN" class="mb-2">
						<button type="button" class="w-25 btn btn-lg btn-primary">下一步</button>
					</div>
					<div id="submitBTN" class="mb-2 hide">
						<button type="submit" class="w-25 btn btn-lg btn-primary">送出</button>
					</div>
					<div>
						<button type="button" class="w-25 btn btn-lg btn-outline-dark" id="cancel">清除</button>
					</div>
				</div>

			</form>
			<!-- 表單結束 -->
		</main>

		<!-- 新增程式語言彈跳視窗 -->
		<div class="modal fade" id="Modal1" tabindex="-1" aria-labelledby="Modal1Label" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="Modal1Label">新增程式語言</h5>
						<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
					</div>
					<div class="modal-body form-floating">
						<input id="addLangInput" type="text" class="form-control">
						<label>輸入程式語言名稱</label>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
						<button type="button" class="btn btn-primary" id="addLangBTN"
							data-bs-dismiss="modal">Add</button>
					</div>
				</div>
			</div>
		</div>

		<!-- 新增章節彈跳視窗 -->
		<div class="modal fade" id="Modal2" tabindex="-1" aria-labelledby="Modal2Label" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="Modal2Label">新增章節</h5>
						<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
					</div>
					<div class="row modal-body">
						<div class="col-3 form-floating">
							<input id="addChapterNumInput" type="number" class="form-control" min="1">
							<label>章節編號</label>
						</div>
						<div class="col-9 form-floating">
							<input id="addChapterNameInput" type="text" class="form-control">
							<label>輸入章節名稱</label>
						</div>
					</div>

					<div class="modal-footer">
						<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
						<button type="button" class="btn btn-primary" id="addChapterBTN"
							data-bs-dismiss="modal">Add</button>
					</div>
				</div>
			</div>
		</div>
		</div>

		<jsp:include page="../common/footer.jsp" />
		<!-- js code -->
		<!-- <script src="${contextRoot}/js/learning/addCourse.js"></script> -->
		<script>
			//點擊輸入課程名稱
			$("#addCourseNameBTN").on("click", () => {
				$("#addCourseNameInput").removeClass("hide");
				$("#addCourseNameBTN").addClass("hide");
				$("#selectCourseNameBTN").addClass("hide");

				$("#changeBTN").removeClass("hide");

				$("#addCourseNameInput input").attr("name", "cname");
				$("#addCourseNameSelect select").removeAttr("name");
			});

			//點擊選擇課程
			$("#selectCourseNameBTN").on("click", () => {
				$("#addCourseNameBTN").addClass("hide");
				$("#addCourseNameSelect").removeClass("hide");
				$("#selectCourseNameBTN").addClass("hide");

				$("#changeBTN").removeClass("hide");

				$("#addCourseNameInput input").removeAttr("name");
				$("#addCourseNameSelect select").attr("name", "cname");
			});

			//點擊返回
			$("#changeBTN").on("click", () => {
				$("#addCourseNameInput").addClass("hide");
				$("#addCourseNameBTN").removeClass("hide");

				$("#addCourseNameSelect").addClass("hide");
				$("#selectCourseNameBTN").removeClass("hide");

				$("#changeBTN").addClass("hide");
			});

			//點擊下一步
			$("#nextBTN button").on("click", () => {
				if ($("#nextBTN button").text() == "下一步") {
					let courseName = $('[name="cname"]').val();
					if (courseName != "") {
						//上傳全新課程
						if ($("#addCourseNameInput").hasClass("hide") == false) {
							$("#previousBTN").removeClass("hide");
							$("#nextBTN").addClass("hide");
							$("#submitBTN").removeClass("hide");

							$("#firstStepInput").addClass("hide");
							$("#secondStepInput").removeClass("hide");
							$("#thirdStepInput").removeClass("hide");
							$("#courseTitle").removeClass("hide");
							$("#addVideosBottom").removeClass("hide");

							$("#courseName").val(courseName);
							$("#courseNameShow").val(courseName);
							$("#courseNameShow").attr("disabled", "disabled");
						}
						//新增章節內容
						else if ($("#addCourseNameSelect").hasClass("hide") == false) {
							// 取得選擇的課程id
							let courseId = $("#courseProfileSelect").find(":selected").val();
							// 把form表單的action加上id
							let actionUrl = $("#mainForm").attr("action") + "/" + courseId;
							$("#mainForm").attr("action", actionUrl);

							$("#previousBTN").removeClass("hide");
							$("#nextBTN").addClass("hide");
							$("#submitBTN").removeClass("hide");

							$("#firstStepInput").addClass("hide");
							$("#thirdStepInput").removeClass("hide");
							$("#courseTitle").removeClass("hide");
							$("#addVideosBottom").removeClass("hide");

							$("#courseName").val($("#courseProfileSelect").find(":selected").text());
							$("#courseNameShow").val($("#courseProfileSelect").find(":selected").text());
							$("#courseNameShow").attr("disabled", "disabled");

							$("#coursePrice").removeAttr("required");
							$("#courseImg").removeAttr("required");

							// 用ajax以courseId取得課程章節
							let urlString = '${contextRoot}/course/add/findChapters/' + courseId;
							$.ajax({
								type: "GET",
								url: urlString,
								dataType: "json",
								success: function (result) {
									$.each(result, function(index, value){
										$("#courseChapterSelect").html("");
										$("#courseChapterSelect").append('<option value="'+value.name+'">'+value.name+'</option>');
									});
								},
								error: function (thrownError) {
									console.log(thrownError);
								}
							});
						} else {
							alert("請輸入課程名稱");
						}
					} else {
						alert("請輸入課程名稱");
					}
				}
				// 按下送出按鈕
				else {}
			});

			//點擊上一步
			$("#previousBTN button").on("click", () => {
				$("#previousBTN").toggleClass("hide");
				$("#nextBTN").toggleClass("hide");
				$("#submitBTN").toggleClass("hide");

				$("#firstStepInput").removeClass("hide");
				$("#secondStepInput").addClass("hide");
				$("#thirdStepInput").addClass("hide");
				$("#courseTitle").addClass("hide");
			});

			//點擊新增程式語言
			$("#addLangBTN").on("click", () => {
				let optionValue = $("#addLangInput").val();
				let option = document.createElement("option");
				$(option).attr("value", optionValue);
				$(option).attr("selected", "selected");
				$(option).text(optionValue);
				$("#programmingLanguage").append(option);
			});

			//點擊新增章節
			$("#addChapterBTN").on("click", () => {
				let optionValue1 = $("#addChapterNumInput").val();
				let optionValue2 = $("#addChapterNameInput").val();
				let optionValue = optionValue1 + "." + optionValue2;

				let option = document.createElement("option");
				$(option).attr("value", optionValue);
				$(option).text(optionValue);

				$(".chapterSelect").append(option);
			});

			//點擊新增影片上方導覽列
			$("#addVideosTop").on("click", () => {
				if ($("#addVideosIcon").text() == "展開") {
					$("#addVideosIcon").text("收合");
				} else {
					$("#addVideosIcon").text("展開");
				}
				$("#addVideosBottom").toggleClass("hide");
			});

			//點擊新增影片的+
			$("#addNewVideoBTN").on("click", () => {
				//複製一組輸入欄位
				$("#addNewVideoBTN").before($(".uploadVideo:first").clone().removeClass("hide"));
			});

			//綁定點擊事件到新增影片的刪除
			$("#addVideosBottom").delegate(".uploadVideo div .removeNewVideoBTN", "click", function (event) {
				event.target.parentElement.parentElement.remove();
			});
		</script>
	
</body>

</html>