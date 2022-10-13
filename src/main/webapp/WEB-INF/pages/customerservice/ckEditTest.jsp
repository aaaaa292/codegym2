<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="contextRoot" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>addPage</title>
<script src="https://cdn.ckeditor.com/ckeditor5/35.0.1/classic/ckeditor.js"></script>

<style type="text/css">
.ck-editor__editable_inline {
    min-height: 300px;	/* 設定最低高度 */
}
</style>

</head>
<!-- 導覽列 -->
<jsp:include page="../common/navigate.jsp" />

<div class="container">

	<h1 class="text-center">發表文章</h1>
	
	<form id="editorForm">
	   <div class="h2">標題: <input name="title" type="text"></div>
	   <textarea style="display: none;" name="content" id="uploadContent"></textarea>
	</form><br>
	
	<!-- CKeditor Content-->
	<p class="h2">文章內容:</p>	
	<div id="editor">This is some sample content.</div><br>	
	<input id="submit" type="submit" value="送出">
	
 </div>

				

 <script>
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