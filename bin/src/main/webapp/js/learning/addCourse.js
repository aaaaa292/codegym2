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
					type:"POST",
					url: urlString,  
					dataType : 'json',
					success: function(result) {
						console.log(result);
					},
	
				});
			} else {
				alert("請輸入課程名稱");
			}
		} else {
			alert("請輸入課程名稱");
		}
	}
	// 按下送出按鈕
	else {
	}
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
