<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>

<c:set var="contextRoot" value="${pageContext.request.contextPath}" />

<html>
<head>
<meta charset="UTF-8">
<title>投稿發文</title>
<!-- web icon -->
<link rel="icon" href="${contextRoot}/img/logo-05.png">
<script
	src="https://cdn.ckeditor.com/ckeditor5/35.0.1/classic/ckeditor.js"></script>
</head>
<body>
	<jsp:include page="../common/navigate.jsp" />
	<div class="container">
		<div class="row justify-content-center">
			<div class="col-12">
				<h1>投稿發文頁面</h1>
				<div class="card">
					<div class="card-header">投稿發文</div>
					<div class="card-body">
						<form id="editorForm" method="post"
							action="${contextRoot}/insertPost" enctype="multipart/form-data">
							<div class="h2">
								發文標題： <br /> <input id="title" name="title" type="text" required="required">
							</div>
							<br />
							<div class="h2">選擇標籤：</div>
							<div class="form-control">
								<div class="col-10 text-center">
									<div class="form-check form-check-inline">
										<input id="tagHtml" class="form-check-input" type="checkbox"
											name="programmingLanguages[]" id="HTMLCheckbox" value="HTML" required="required">
										<label class="form-check-label" for="HTMLCheckbox">HTML</label>
									</div>
									<div class="form-check form-check-inline">
										<input class="form-check-input" type="checkbox"
											name="programmingLanguages[]" id="CSSCheckbox" value="CSS">
										<label class="form-check-label" for="CSSCheckbox">CSS</label>
									</div>
									<div class="form-check form-check-inline">
										<input id="tagJavaScript" class="form-check-input" type="checkbox"
											name="programmingLanguages[]" id="JavaScriptCheckbox"
											value="JavaScript"> <label class="form-check-label"
											for="JavaScriptCheckbox">JavaScript</label>
									</div>
									<div class="form-check form-check-inline">
										<input id="tagJQuery" class="form-check-input" type="checkbox"
											name="programmingLanguages[]" id="JQueryCheckbox"
											value="JQuery"> <label class="form-check-label"
											for="JQueryCheckbox">JQuery</label>
									</div>
									<div class="form-check form-check-inline">
										<input id="tagJava" class="form-check-input" type="checkbox"
											name="programmingLanguages[]" id="JavaCheckbox" value="Java">
										<label class="form-check-label" for="JavaCheckbox">Java</label>
									</div>
									<div class="form-check form-check-inline">
										<input class="form-check-input" type="checkbox"
											name="programmingLanguages[]" id="ServletCheckbox"
											value="Servlet"> <label class="form-check-label"
											for="ServletCheckbox">Servlet</label>
									</div>
									<div class="form-check form-check-inline">
										<input class="form-check-input" type="checkbox"
											name="programmingLanguages[]" id="PythonCheckbox"
											value="Python"> <label class="form-check-label"
											for="PythonCheckbox">Python</label>
									</div>
									<div class="form-check form-check-inline">
										<input class="form-check-input" type="checkbox"
											name="programmingLanguages[]" id="PHPCheckbox" value="PHP">
										<label class="form-check-label" for="PHPCheckbox">PHP</label>
									</div>
									<div class="form-check form-check-inline">
										<input class="form-check-input" type="checkbox"
											name="programmingLanguages[]" id="MySQLCheckbox"
											value="MySQL"> <label class="form-check-label"
											for="MySQLCheckbox">MySQL</label>
									</div>
									<div class="form-check form-check-inline">
										<input class="form-check-input" type="checkbox"
											name="programmingLanguages[]" id="sqlServerCheckbox"
											value="sqlServer"> <label class="form-check-label"
											for="sqlServer">sqlServer</label>
									</div>
								</div>

							</div>

							<textarea style="display: none;" name="postContent"
								id="uploadContent"></textarea>
							<br />
							<div class="h2">封面圖片：</div>
							<input id="uploadContent" name="postImg" type="file"
								class="form-control" required>
						</form>
						<br>

						<!-- CKeditor Content-->
						<p class="h2">文章內容：</p>
						<div id="editor"></div>
						<br> <input id="submit" type="submit" value="送出">
						<br/><br/>
						<button type="button" class="btn btn-outline-info" id="inputOnePost">一鍵輸入</button>
					</div>

				</div>
			</div>
		</div>
	</div>

	<jsp:include page="../common/footer.jsp" />

	<script>
	
	//一鍵輸入CusMessage
	$("#inputOnePost").click(function() {
	 $("#title").val("基本的費氏數列-遞迴的問題?");
// 	 $("#tagHtml").attr('checked','true');
	 $("#tagJava").attr('checked','true');
// 	 $("#tagJQuery").attr('checked','true');
// 	 $("#tagJavaScript").attr('checked','true');
	 $('.ck-content p').append("版上的高手，大家好…最近才開始學習Java，目前碰到了一個問題 始終想不出來內部是如何去執行，所以厚著臉皮上來，請教版上高手	題目是這樣子的。使用遞迴來解決費氏數列 費氏數列=>0.1.1.2.3.5.8.13.21.34.55....…(後1個數為前2個數的總合) 以上執行後，結果應該為55 但自己推算，結果總是不正確 所以想把自己的想法打出來，請大家幫忙改正我不對的地方, 想請問，我是邏輯哪邊有問題。 因為想詳述自己的想法，所以打了比較多，謝謝您耐心的看完 雖然是新手，但感覺這是一段很簡單的代碼，卻困擾了我很久 覺得學起來有點灰心阿 @__@ 所以麻煩大家幫幫我，謝謝大家");
	});
	
	
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