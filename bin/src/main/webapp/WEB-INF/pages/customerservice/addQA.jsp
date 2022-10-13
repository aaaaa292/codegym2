<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="contextRoot" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>新增Question&Answer</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://cdn.ckeditor.com/ckeditor5/35.0.1/classic/ckeditor.js"></script>
<!-- bootstrap -->
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css"
	integrity="sha384-GJzZqFGwb1QTTN6wy59ffF1BuGJpLSa9DkKMp0DgiMDm4iYMj70gZWKYbI706tWS"
	crossorigin="anonymous">
	
<style type="text/css">
.ck-editor__editable_inline {
    min-height: 300px;	/* 設定最低高度 */
}
</style>
</head>
<!-- 導覽列 -->
<jsp:include page="../backstage/backstageNavbar.jsp" />

<div class="container">
	<div class="row justify-content-center">
		<div class="col-8">
		
			<h1 class="mb-3">新增常見FAQ</h1>
			<!-- 新增QA表單 -->	
			<form id="editorForm" action="${contextRoot}/customerservice/addQuestionAnswer" method="post" >
				<input type="hidden" name="questionTypeId" value="${typeId}">
				
				<label for="recipient-name" class="col-form-label">請選分類
					<img src="${contextRoot}/img/learning/tagIcon.png" height="15">：
				</label>			
				<div class="d-flex">
					<select id="typeSelect" name="questionTypeValue" class="form-select" aria-label="Default select example" style="width: 89%;" required>
						<option value="基本介紹">基本介紹</option>
						<option value="註冊登入">註冊登入</option>
						<option value="建立課程">建立課程</option>
					</select>
					
					<!-- 新增分類Button觸發Modal -->
					<button type="button" class="btn btn-primary ms-2" data-toggle="modal" data-target="#exampleModal">
					  + 新增
					</button>	
				</div>		
	
				<!-- 新增分類彈跳視窗Modal -->
				<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
				  <div class="modal-dialog">
				    <div class="modal-content">
				      <div class="modal-header">
				        <h5 class="modal-title" id="exampleModalLabel">新增分類</h5>
				        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
				          <span aria-hidden="true">&times;</span>
				        </button>
				      </div>
				      <div class="modal-body">
				        <input type="text" id="addTypeInput">
				      </div>
				      <div class="modal-footer">	        
				        <button type="button" class="btn btn-primary" data-dismiss="modal" id="addTypeBTN">新增</button>
				        <button type="button" class="btn btn-secondary" data-dismiss="modal">關閉</button>
				      </div>
				    </div>
				  </div>
				</div>
				<!-- end 新增分類彈跳視窗Modal-->
							
				<div class="form-group">
					<label for="recipient-name" class="col-form-label">Q 問題：</label>
					<input type="text" name="question" class="form-control" id="questionInput">
				</div>
				<div class="form-group" style="display: none;">
					<label for="recipient-name" class="col-form-label">A 解答：</label>
					<textarea name="answer" class="form-control" id="uploadContent"></textarea>
				</div>				
			</form>
			
			<!-- CKeditor Content-->
			<div class="form-group">
				<label for="recipient-name" class="col-form-label">A 解答：</label>
				<div id="editor"></div><br>
			</div>
			
			<div class="mb-5 text-right">
				<button type="button" class="btn btn-outline-info" id="inputOneQA">一鍵輸入</button>
	       		<button id="submit" type="submit" class="btn btn-success">新增</button>
	       		<a href="${contextRoot}/customerservice/QAType/${typeId}" style="text-decoration: none;">
					<button type="button" class="btn btn-secondary">取消</button>
				</a>	
			</div>
											
		</div><!-- end col-->
	</div><!-- end row-->
</div><!-- end container-->
<jsp:include page="../common/footer.jsp" />

<!-- bootstrap -->
<script
	src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js"
	integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj"
	crossorigin="anonymous"></script>
<script
	src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"
	integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN"
	crossorigin="anonymous"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.min.js"
	integrity="sha384-+sLIOodYLS7CIrQpBjl+C7nPvqq+FbNUBDunl/OZv93DB7Ln/533i8e/mZXLi/P+"
	crossorigin="anonymous"></script>

<script type="text/javascript">
//一鍵輸入CusMessage
$("#inputOneQA").click(function() {
	$("#questionInput").val("該如何建立課程");
	$('.ck-content p').append("在 CodeGym 平台上建立課程十分簡單！首先至導覽列找到「上架課程」，就會進入到課程上架的選擇頁面，並且按照流程，能成功建立課程。");
});

// 新增QuestionType
$(document).ready(function() {
	$("#addTypeBTN").on("click", () => {
		let optionValue = $("#addTypeInput").val();
		let option = document.createElement("option");
		
		$(option).attr("value", optionValue);
		$(option).attr("selected", "selected");
		$(option).text(optionValue);	
		
		$("#typeSelect").append(option);
	});
})

// CKedit套件
class MyUploadAdapter {
    constructor(loader) {
        // The file loader instance to use during the upload.
        this.loader = loader;
    }

    // Starts the upload process.
    upload() {
        return this.loader.file
            .then(file => new Promise((resolve, reject) => {}));
    }
}

function MyCustomUploadAdapterPlugin(editor) {
    editor.plugins.get('FileRepository').createUploadAdapter = (loader) => {
        // Configure the URL to the upload script in your back-end here!
        return new MyUploadAdapter(loader);
    };
}

let editor;
ClassicEditor
    .create(document.querySelector('#editor'), {
        extraPlugins: [MyCustomUploadAdapterPlugin],
    })
    .then(newEditor => {
        editor = newEditor;
    })
    .catch(error => {
        console.log(error);
    });

document.querySelector('#submit').addEventListener('click', () => {
    $('.ck-reset_all').remove();
    $('.ck-progress-bar').remove();
    const data = $('.ck-content').html();
    $('#uploadContent').val(data);

    document.getElementById("editorForm").submit();
});
</script>

</body>
</html>