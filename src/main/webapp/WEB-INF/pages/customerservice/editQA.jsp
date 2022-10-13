<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="contextRoot" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://cdn.ckeditor.com/ckeditor5/35.0.1/classic/ckeditor.js"></script>
<style type="text/css">
.ck-editor__editable_inline {
    min-height: 300px;	/* 設定最低高度 */
}
</style>
</head>
<body>
<!-- 導覽列 -->
<jsp:include page="../common/navigate.jsp" />

<div class="container">
	<div class="row justify-content-center">
		<div class="col-8">
		
			<h1 class="mt-5 mb-5">修改類別名稱</h1>
				<form id="editorForm" action="${contextRoot}/customerservice/editQA" method="post">		
				<input type="hidden" name="id" value="${questionAnswer.id }" />
				<input type="hidden" name="time" value="${questionAnswer.time }" />
				<input type="hidden" name="typeId" value="${questionAnswer.questionTypeId.id }" />
				
				<div class="form-group">
					<label for="recipient-name" class="col-form-label">分類：</label>
					<input type="text" name="questionTypeValue" class="form-control" value="${questionAnswer.questionTypeId.type}" >
				</div>	
				<div class="form-group">
					<label for="recipient-name" class="col-form-label">Q 問題：</label>
					<input type="text" name="question" class="form-control" value="${questionAnswer.question }">
				</div>
				<div class="form-group" style="display: none;">
					<label for="recipient-name" class="col-form-label">A 解答：</label>
					<textarea name="answer" class="form-control" id="uploadContent">${questionAnswer.answer }</textarea>
				</div>
			</form>	
			
			<!-- CKeditor Content-->
			<div class="form-group">
				<label for="recipient-name" class="col-form-label">A 解答：</label>
				<div id="editor">${questionAnswer.answer }</div><br>	
			</div>
			
			<div class="modal-footer">
	        	<button id="submit" type="submit" class="btn btn-warning me-2">修改</button>
				<a href="${contextRoot}/customerservice/QAType/${questionAnswer.questionTypeId.id }">
					<button type="button" class="btn btn-secondary">取消</button>
				</a>
			</div>	
				
		</div><!-- end col-->
	</div><!-- end row-->
</div><!-- end container-->
	
<script type="text/javascript">
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