<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="contextRoot" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${questionAnswer.question}</title>
<!-- 自訂義css -->
<link rel="stylesheet" href="${contextRoot}/css/customerservice/frontOneQA.css">

</head>
<body class="qa">
<!-- 導覽列 -->
<jsp:include page="../common/navigate.jsp" />

<!-- QA -->
<div class="container qaContainer mt-1 mb-3" id="wrapper">	
	<div class="row qaRow">
	
		<!-- QA連結路徑 -->
		<div class="mt-3 mb-5">
			<p>
				<a href="${contextRoot}/customerservice">常見FQA</a>
				　>　<a href="${contextRoot}/customerservice/Type/${questionAnswer.questionTypeId.id}">${questionAnswer.questionTypeId.type}</a> 
				　>　<span>${questionAnswer.question }</span>
			</p>
		</div>
		
		<!-- QA內容 -->
		<div class="col mb-3">
			<h2 class="mb-5 text-center"><b>${questionAnswer.question }</b></h2>
			<div style="overflow: auto;">${questionAnswer.answer }</div>
		</div>	
			<h1>${questionScore }</h1>	
		<!-- QA button -->
		<div class="emoticonRow">
			<p class="text-center">您是否找到答案了？</p>
			<div class="emoticonContent">
<!-- 				<div> -->
<%-- 					<form action="${contextRoot }/customerservice/score" method="post"> --%>
<%-- 						<input type="hidden" id = "user" name="user" value="${userInformation.id}"> --%>
<%-- 						<input type="hidden" id = "questionAnswer" name="questionAnswer" value="${questionAnswer.id}"> --%>
<!-- 						<button type="submit" name="score" value="5" class="emoticonBTN goodBTN" onclick="smile()"> -->
<%-- 							<img class="emoticonImg" id="goodImg" src="${contextRoot }/img/customerservice/good.png"> --%>
<!-- 						</button> -->
						
<!-- 						<button type="submit" name="score" value="2" class="emoticonBTN sosoBTN" onclick="soso()"> -->
<%-- 							<img class="emoticonImg" id="sosoImg" src="${contextRoot }/img/customerservice/soso.png"> --%>
							
<!-- 						</button> -->
<!-- 						<button type="submit" name="score" value="0" class="emoticonBTN badBTN" onclick="bad()"> -->
<%-- 							<img class="emoticonImg" id="badImg" src="${contextRoot }/img/customerservice/bad.png"> --%>
<!-- 						</button>	 -->
<%-- 					</form> --%>
<!-- 				</div> -->
				<div>
					<button class="emoticonBTN goodBTN" onclick="setEmoticonScore(5);">
						<img class="emoticonImg" id="goodImg" src="${contextRoot }/img/customerservice/good.png" >
					</button>
				</div>
				<div>	
					<button class="emoticonBTN sosoBTN" onclick="setEmoticonScore(2);">
						<img class="emoticonImg" id="sosoImg" src="${contextRoot }/img/customerservice/soso.png" >
					</button>			
				</div>
				<div>
					<button class="emoticonBTN badBTN" onclick="setEmoticonScore(0);">
						<img class="emoticonImg" id="badImg" src="${contextRoot }/img/customerservice/bad.png" >
					</button>
				</div>
			</div>
		</div>
		
	</div><!-- row qaRow end -->
</div><!-- container end -->
<jsp:include page="../common/footer.jsp" />
		
<script>
window.onload=function(){
	//查表情分數
	getEmoticon()	
}

// 透過按鈕onclick事件寫入分數
function setEmoticonScore(score){
	
	var emoticonScore = score ;	
	// CustomerserviceDto
	var dtoObject = {
			"score" : emoticonScore,	
			"questionAnswer" : ${questionAnswer.id},
			"user" : '${userInformation.id}'
		};	
	var dtoJsonString = JSON.stringify(dtoObject);
	
	$.ajax({
		url : '${contextRoot}/customerservice/setScore',
		contentType : 'application/json', // 送過去的資料型別
		dataType : 'json', // 回傳回來的資料型別
		method : 'post',
		data : dtoJsonString,
		success : function(result) {
			console.log(result)
			// 尚未登入null回傳值為99，導到登入頁面
			if (result == 99) {
				window.location.href = "${contextRoot}/member/login";
			}
			initEmoticon();
			showEmoticon(result);
		},
		error : function(err) {
			console.log(err)
		}
	})	
}

// 根據使用者，從資料庫撈出表情評分
function getEmoticon(){
		
	var dtoObject = {
			"questionAnswer" : ${questionAnswer.id},
			"user" : '${userInformation.id}'
		}
	var dtoJsonString = JSON.stringify(dtoObject);
	
	$.ajax({
		url : '${contextRoot}/customerservice/getScore',
		contentType : 'application/json', // 送過去的資料型別
		dataType : 'json', // 回傳回來的資料型別
		method : 'post',
		data : dtoJsonString,
		success : function(result) {
			console.log(result)
			initEmoticon();
			showEmoticon(result);		
		},
		error : function(err) {
			console.log(err)
		}
	})
}

/* ----- 表情呈現效果 ----- */
// 全部變灰
function initEmoticon(){	
	document.getElementById('goodImg').src = '${contextRoot }/img/customerservice/good0.png';
	document.getElementById('goodImg').style.transform = 'scale(1, 1)';
	document.getElementById('sosoImg').src = '${contextRoot }/img/customerservice/soso0.png';
	document.getElementById('sosoImg').style.transform = 'scale(1, 1)';
	document.getElementById('badImg').src = '${contextRoot }/img/customerservice/bad0.png';
	document.getElementById('badImg').style.transform = 'scale(1, 1)';
}

// 依照數字變色
function showEmoticon(score){
	if (score == 5) {
		document.getElementById('goodImg').src = '${contextRoot }/img/customerservice/good.png';
		document.getElementById('goodImg').style.transform = 'scale(1.4, 1.4)';
	} else if (score == 2) {
		document.getElementById('sosoImg').src = '${contextRoot }/img/customerservice/soso.png';
		document.getElementById('sosoImg').style.transform = 'scale(1.4, 1.4)';
	}else if (score == 0)  {
		document.getElementById('badImg').src = '${contextRoot }/img/customerservice/bad.png';
		document.getElementById('badImg').style.transform = 'scale(1.4, 1.4)';
	}else if (score == 99) {
		document.getElementById('goodImg').src = '${contextRoot }/img/customerservice/good.png';
		document.getElementById('goodImg').style.transform = 'scale(1, 1)';
		document.getElementById('sosoImg').src = '${contextRoot }/img/customerservice/soso.png';
		document.getElementById('sosoImg').style.transform = 'scale(1, 1)';
		document.getElementById('badImg').src = '${contextRoot }/img/customerservice/bad.png';
		document.getElementById('badImg').style.transform = 'scale(1, 1)';
	}
}
</script>
</body>
</html>