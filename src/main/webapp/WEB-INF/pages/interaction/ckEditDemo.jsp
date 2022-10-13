<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<c:set var="contextRoot" value="${pageContext.request.contextPath}" />
<meta charset="utf-8">
<title>CKEditor</title>
<script src="https://cdn.ckeditor.com/ckeditor5/35.0.1/classic/ckeditor.js"></script>
<style type="text/css">
.ck-editor__editable {
    min-height: 160px;
}
</style>
</head>

<jsp:include page="layout/navbarPostView.jsp" />
<body>

	<h1 bgcolor="#64A600">CkEdit</h1>

	<div id="editor">This is some sample content.</div>
	<script>
                    ClassicEditor
                            .create(document.querySelector( 
                                '#editor'),{
//                                 toolbar:['bold','italic','link', 
//                                          'bulletedList', 
//                                          'numberedList', 
//                                          '|','outdent','indent']
                            })
                            .then(editor=>{
                                   console.log(editor);
                            })
                            .catch(error=>{
                                   console.error(error);
                            });
            </script>
</body>

</html>