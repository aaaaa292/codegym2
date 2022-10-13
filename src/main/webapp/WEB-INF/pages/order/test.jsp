<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<jsp:include page="../common/navigate.jsp" />
<!DOCTYPE html>
<html>

<head>
<c:set var="contextRoot" value="${pageContext.request.contextPath}" />
<script type="text/javascript"
	src="${contextRoot}/js/common/jquery-3.6.0.min.js"></script>
<meta charset="UTF-8">
<title>localstorage 測試</title>
</head>

<body>

	<div class="container">
		<h3>測試用</h3>
		<div class="card-deck">
			<div class="card">
				<div class="card-body">
					<h5 class="card-title">Java</h5>

					<div class="form-row mb-3">
						<div class="col">
							<p class="card-text">$500</p>
						</div>
						<div class="col">
							<input type="number" value="1" class="form-control amount">
						</div>
					</div>
					<button class="btn btn-info btn-block add_cart" data-price="500">加到購物車</button>
				</div>
			</div>
			

			<div class="pt-4">
				<h3>購物車</h3>
				<a class="btn btn-info text-white" id="clear">清空購物車</a>
				<ul id="cart">

				</ul>
				總價: <span id="total"></span> 元
			</div>
		</div>
	</div>
</body>
<script>
    var cart = [];
    if (localStorage.getItem("cart")) {
      cart = JSON.parse(localStorage.getItem("cart"));
    }
    setCart();

    function setCart() {
      var cartList = "", s_price = 0, total = 0;
      for (let $i = 0; $i < cart.length; $i++) {
        s_price = cart[$i]["price"] * cart[$i]["amount"];
        total += s_price;
        cartList += `<li> ${cart[$i]["name"]} , 單價: ${cart[$i]["price"]}, 數量: ${cart[$i]["amount"]
          }, 總價: ${s_price}</li>`;
      }
      $("#cart")
        .empty()
        .append(cartList);
      $("#total").text(total);
    }

    $("#clear").click(function () {
      cart = [];
      localStorage.removeItem("cart");
      setCart();
    });
    $(".add_cart").click(function () {
      let product = $(this).closest(".card-body");
      console.log(product);
      let newItem = {
        name: product.find(".card-title").text(),
        price: $(this).data("price"),
        amount: product.find(".amount").val()
      };
      cart.push(newItem);
      localStorage.setItem("cart", JSON.stringify(cart));
      setCart();
    });

  </script>

</html>