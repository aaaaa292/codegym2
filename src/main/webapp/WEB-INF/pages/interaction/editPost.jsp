<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<c:set var="contextRoot" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>編輯頁面</title>
<script
	src="https://cdn.ckeditor.com/ckeditor5/35.0.1/classic/ckeditor.js"></script>
</head>
<body>
<jsp:include page="../common/navigate.jsp" />
	<div class="container">
		<div class="row justify-content-center">
			<div class="col-8">
				<h1>修改留言頁面</h1>
				<div class="card">
					<div class="card-header">修改留言</div>
					<div class="card-body">
<%-- 					<form action="${contextRoot}/post/editPost" method="post" enctype ="application/x-www-form-urlencoded"> --%>
<!-- 						<h3>文章標題:</h3> -->
<!-- 						<div> -->
<%-- 							   <input type="hidden" name="id" value="${post.id}"> --%>
<%-- 						<input type="text" name="title" value="${post.title}" required > --%>
<!-- 						</div> -->
<!-- 						<br /> -->
<!-- 						<input type="file" name="imgPath"> -->
						
<!-- 						<h3>文章內容:</h3> -->
<!-- 						<div> -->
<%-- 						<div id="editor">${post.postContent}</div>					 --%>
<%-- 						<textarea name="postContent" style="width:400px;height:120px;">${post.postContent}</textarea>		 --%>
<%-- 						<input type="hidden" name="time" value="<fmt:formatDate pattern="yyyy/MM/dd HH:mm:ss EEEE" value="${post.time}" />" placeholder="请选择操作时间" style="width:130px"> --%>
<!-- 						</div> -->
<!-- 						<div> -->
<%-- 						<input id="postImg" name="postImg" type="file" class="form-control" value="${post.photo}" required> --%>
<!-- 						</div> -->
<!-- 						<button>儲存</button> -->
<%-- 					</form> --%>
					
					<form id="editorForm" method="post"
							action="${contextRoot}/post/editPost/result/${post.id}" enctype="multipart/form-data">
							<div class="h2">
							<input type="hidden" name="id" value="${post.id}">
								發文標題：
								<br/>
								<input name="title" type="text" value="${post.title}">
							</div>
							<br/>							
							<textarea style="display: none;" name="postContent"	id="uploadContent"></textarea>
								<br/>
						</form>
						<br>
						<!-- CKeditor Content-->
						<p class="h2">文章內容：</p>
						<div id="editor">${post.postContent}</div>
						<br> <input id="submit" type="submit" value="送出">
					
					
					</div>
				</div>
			</div>
		</div>
	</div>
<jsp:include page="../common/footer.jsp" />
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
            //$('#x').html(data);

            document.getElementById("editorForm").submit();
        });
    </script>
</body>
</html>