// 存入localstorage
$(".add_cart").click(function (e) {
            if(localStorage.getItem("cart") === null){   //localStorage沒有購物車物件就創一個
				var cart = [];
			}
			else{                                        //已經存在 就抓出來
				cart = JSON.parse(localStorage.getItem("cart"));
			}

            let course = $(e.target).closest(".card");   

			var count = 0 ;
			for(let i=0; i < cart.length; i++){         //檢查存在與否
				if(cart[i].courseId === course.find(".courseId").text()){
				   count++;
				}
			}

			if(count === 1){  //已存在 不進購物車
                alert("已放入購物車!");
			}
			else{             //不存在 進購物車
				
			    let newItem = {
						userId: $("#uid").text(),
						price: $(e.target).data("price"),
						courseId: course.find(".courseId").text(),
						courseName: course.find(".courseName").text(),
						amount: course.find(".quantity").text()
					};
			    console.log(newItem);
			    cart.push(newItem);
			    localStorage.setItem("cart", JSON.stringify(cart));

				}

			



		})