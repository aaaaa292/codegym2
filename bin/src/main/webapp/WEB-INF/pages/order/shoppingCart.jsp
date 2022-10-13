<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<jsp:include page="../common/navigate.jsp" />
<!DOCTYPE html>
<html>

<head>
	<c:set var="contextRoot" value="${pageContext.request.contextPath}" />
	<script type="text/javascript" src="${contextRoot}/js/common/jquery-3.6.0.min.js"></script>
	<meta charset="UTF-8">
	<title>購物車</title>
	<style>
		@keyframes neon {
			0%,
			100% {
				text-shadow: 0 0 20px #fff, 0 0 100px #fff, 0 0 20px #fff;
			}

			50% {
				text-shadow: 0 0 50px #fff, 0 0 150px #fff, 0 0 50px #fff;
			}
		}

		.payBTN {
			color: white;
			animation: neon 1.5s ease-in-out infinite alternate;
		}

		#priceFont{
			color: orange;
			font-size: 30px;
		}

		#radioSize{
			font-size: 20px;
		}

		#codeMsg{
			color:#FF2D2D;
		}

		.courseImg{
			object-fit: contain;
			width:200px;
			height:150px;
		}

		#ec{
			margin-right: 188px;
		}
	</style>
</head>

<body>
	<main>
		<section class="h-100 gradient-custom">
			<div class="container py-5">
				<!-- 表單開始 -->
			<form id="cartForm" action="${contextRoot}/order/ecpay" method="post">
				<div class="row d-flex justify-content-center my-4">
					<div class="col-md-8">
						<div class="card mb-4">
							<div class="card-header py-3 align-items-center justify-content-between d-flex">
								<h5 class="mb-0"><strong>購物車</strong></h5>
								<button type="button" class="deleteAll btn btn-outline-danger">全部移除</button>
							</div>
							<div class="card-body">
								<div class="wholeCart" id="cart">
								</div>
							</div>
						</div>
						<div class="card mb-4" >
							<div class="card-body">
									<strong>備註: </strong><input name="note" size="35">
								<p class="mb-0"></p>
							</div>
						</div>
						<div class="card mb-4 mb-lg-0" hidden="hidden">
							<div class="card-body"></div>
						</div>
					</div>
					<div class="col-md-4">
						<div class="card mb-4">
							<div class="card-header py-3">
								<h5 class="mb-0"><strong>訂單明細</strong></h5>
							</div>
							<div class="card-body">
								<ul class="list-group list-group-flush">
									<li
										class="list-group-item d-flex justify-content-between align-items-center border-0 px-0 pb-0">
										小計 <span>NT$<span id="total"></span></span>
										      <input id="formTotal" name="totalPrice" type="hidden" value="">
									</li>
									<li id="priceDiff" class="list-group-item d-flex justify-content-between align-items-center border-0 px-0 pb-0">
										折扣代碼 <span>-NT$<span id="discountAmt">0</span></span>

									</li>

									<li class="list-group-item d-flex justify-content-between align-items-center px-0">

									</li>
									<li
										class="list-group-item d-flex justify-content-end align-items-center border-0 px-0 mb-3">
										<strong id="priceFont">NT$<strong id="afterDiscount" class="text-right"></strong></strong>
									</li>
									<li id="radioSize" class="list-group-item d-flex justify-content-between align-items-center border-0 px-0 mb-3">
										<div>
										<input type="radio" id="useCoupon">
										<label >我有折扣碼</label>
										</div>
									</li>
									<li id="coupon" class="list-group-item justify-content-between align-items-center border-0 px-0 mb-3">
									  
										<a class="undo" style="cursor: pointer;"><img src="${contextRoot}/img/order/x.png" height="30" ></a>
										<strong></strong><input name="discountCode" class="discountCode" placeholder="請輸入折扣碼...">
										<button type="button" class="btn btn-secondary discountBTN">確定</button><br>
										<p id="codeMsg"> </p>
									</li>
								</ul>
							    
							    <button type="submit" class="btn btn btn-primary btn-lg btn-block payBTN">來去結帳</button>
							
							</div>
						</div>
					</div>
				</div>
				</form>
				<!-- 表單結束 -->
				
			</div>
<!-- 			<div class="col-auto justify-content-end d-flex" id="ec"> -->
<%-- 				<form action="${contextRoot}/order/ecpay" method="post"> --%>
<!-- 					<input  id="ecpay" type="hidden" name="totalPrice" value=""> -->
<!-- 					<button class="btn btn-outline-primary">綠界結帳</button> -->
<%-- 				</form> --%>
<!-- 				</div> -->
		</section>
	</main>

	<script>
		// 判斷使用者是否登入，未登入就把userId設為0
		let userId = '<c:if test="${empty userInformation}">0</c:if><c:if test="${!empty userInformation}">${userInformation.id}</c:if>';

		if (localStorage.getItem("cart")) {
			cart = JSON.parse(localStorage.getItem("cart"));
			console.log(cart)
		}

//=====================================================================================

		var cartList = "",
			total = 0;
		for (let i = 0; i < cart.length; i++) {
			if(cart[i].userId != userId) {
				continue;
			}
			total += cart[i].price;
			console.log(i);
			cartList += '<div class="row singleCourse"><div class="col-lg-4"><div><img src="${contextRoot}/course/getImg?courseId=' +cart[i].courseId + '"'
			cartList += 'class="w-100 courseImg"></div></div><div class="col-lg-5 col-md-6 mb-4 mb-lg-0">'
			cartList += '<input name="courseId" type="hidden" value="'+ cart[i].courseId +'">'
			cartList += '<p><strong>' + cart[i].courseName + '</strong></p><p hidden="hidden">' + cart[i].courseId + '</p>'
			cartList += '<button type="button" class="mb-4 btn btn-outline-danger deleteSingle" data-price="' + cart[i].price + '">移除</button>'
			//cartList += '<button type="button" class="btn btn-danger">收藏</button></div>'
			cartList += '<div class="col-lg-4"><p><strong>NT$' + cart[i].price + '</strong></p></div></div><hr class="my-4" /></div>'

		};
		$("#cart").append(cartList);
		$("#total").text(total); //顯示總價
		$("#formTotal").val(total);//表單 總價
		$("#afterDiscount").text(total);
		$("#ecpay").val(total);

//===================================================================================

		//刪除全部 
		$(".deleteAll").click(function () {   //所有欄位歸零
			$(".wholeCart").remove();        
			$("#total").text(0);
			$("#formTotal").val(0);
			$("#afterDiscount").text(0);
			$("#discountAmt").text(0);
			emptyCart();
			checkCart();
		});

//==================================================================================

		function emptyCart(){ //清空該使用者的購物車
			
			cart = JSON.parse(localStorage.getItem("cart"));
			cart = cart.filter(function(obj) {
				return obj.userId !== userId;
			});
			localStorage.setItem("cart", JSON.stringify(cart));
		}


//=====================================================================================

		//刪除單一
		$(".deleteSingle").click(function (e) {

			$("#total").text($("#total").text() - $(e.target).data("price")); //更新總價
           

			if($(".discountCode").val() != "" && $("#total").text() != 0 ){ //如果套用折扣 且 購物車還有商品

			   discount();                                                  //計算折扣
			   
			}else{                                                          // 有套用折扣購物車沒有商品  或  沒有套用折扣 
				$("#discountAmt").text(0);                                  // 有套用折扣 讓折扣歸零 或 沒有套用折扣 則仍是0
				$("#afterDiscount").text($("#total").text());               // 總價(橘字) 跟進 小計的數字
                $("#formTotal").val($("#afterDiscount").text());            // 表單的價錢欄位跟進總價
			};
			

			$(e.target).closest(".singleCourse").remove();                  //移除html的單筆商品

			cart = JSON.parse(localStorage.getItem("cart"));                
 
			let courseId = $(e.target).prev().text();

			cart = cart.filter(function(obj) {                              //留下沒有要刪除的資料 (其他使用者 跟 現在user的其他商品)  
				return obj.userId !== userId || obj.courseId !== courseId;
			});

			// 更新購物車localStorage
			localStorage.setItem("cart", JSON.stringify(cart));

			$("#ecpay").val($("#afterDiscount").text());

			checkCart();              
		});

//=====================================================================================


		//開啟折扣碼
		$("#coupon").hide();
		$("#useCoupon").click(function(){
			$("#coupon").show();
		});


		//取消折扣碼
		$(".undo").click(function(){   //欄位還原 折扣前
			if($("#coupon").is(":visible")){  
				$("#codeMsg").text("");
				$(".discountCode").val("");
				$("#discountAmt").text(0)
				$("#afterDiscount").text($("#total").text());
				$("#formTotal").val($("#afterDiscount").text());
				$("#useCoupon").prop("checked", false);
				$("#coupon").hide();
				$("#ecpay").val($("#afterDiscount"));
			}
		});



		//使用折扣碼
		$(".discountBTN").click(function(e){
			if($("#codeMsg").text() != ""){  //清空折扣訊息
				$("#codeMsg").text("");
			}
			if($("#total").text() == 0){
				$("#codeMsg").text("請先將課程加入購物車!!");
			}else{
				discount();
			}
		});

//=====================================================================================


        //折扣碼ajax
		function discount(){
			let dCode = $(".discountCode").val();
			var urlString = '${contextRoot}/applyDiscount/' + dCode;
			var totalPrice = $("#total").text()

			$.ajax({
				url: urlString,
				type:'GET',
				dataType:'text',
				success: function(discount){
					
					if(discount != ''){

						// 9折 8折 7折...整數折
						if(discount < 10){
							$("#afterDiscount").text(Math.ceil(totalPrice * discount * 0.1));
							$("#codeMsg").text("已套用" + discount + "折優惠!!")

						}

						// 95折 89折 79折 非整數折
						else if(discount < 100){
							$("#afterDiscount").text(Math.ceil(totalPrice * discount * 0.01));
							$("#codeMsg").text("已套用" + discount + "折優惠!!")

						// >100 用扣除的
						}else{
							$("#afterDiscount").text(totalPrice - discount);
							$("#codeMsg").text("已套用" + discount + "元折價!!")
						}

						$("#formTotal").val($("#afterDiscount").text());                             //表單價錢跟進總價(橘字)
						$("#discountAmt").text($("#total").text() - $("#afterDiscount").text());     //計算折扣額
						$("#ecpay").val($("#afterDiscount").text());
					}
					else{
						$("#discountAmt").text(0);
						$("#afterDiscount").text($("#total").text());
						$("#codeMsg").text("折扣碼不存在，請再次確認!!")
					}


				}


			})


		}

//=====================================================================================
		
		// 送出訂單後清空購物車
		$('#cartForm').on('submit', function() {
			emptyCart();
		});

		//購物車沒東西就不給結帳
		function checkCart(){
		if($("#afterDiscount").text() == 0){ 
		    $(".payBTN").removeClass("btn-primary");
		    $(".payBTN").addClass("btn-secondary");
			$(".payBTN").prop('disabled', true);
		}}
		checkCart(); //載入時 檢查一次購物車有無商品
	</script>
</body>

</html>