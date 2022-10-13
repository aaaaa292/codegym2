package com.ispan.codegym.order.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.ispan.codegym.learning.model.bean.CourseProfiles;
import com.ispan.codegym.learning.service.CoursesService;
import com.ispan.codegym.member.model.bean.UserInformation;
import com.ispan.codegym.order.model.bean.DiscountCodes;
import com.ispan.codegym.order.model.bean.OrderItems;
import com.ispan.codegym.order.model.bean.Orders;
import com.ispan.codegym.order.service.OrderService;

import ecpay.payment.integration.AllInOne;
import ecpay.payment.integration.domain.AioCheckOutOneTime;

@Controller
public class OrderController {

	@Autowired
	private OrderService ordService;
	@Autowired
	private CoursesService cService;	

	@GetMapping("/shoppingCart")
	public String shoppingCart() {
		return "/order/shoppingCart";
	}

	@PostMapping("/paymentSuccess")
	public String paymentSuccess() {
		return "/order/paymentSuccess";
	}
	

	// 購買
	@PostMapping("/insertNewOrder")
	public String insertNewOrder(HttpSession session, @RequestParam("courseId") int[] courseId,
			@RequestParam("totalPrice") int totalPrice, @RequestParam("note") String note,
			@RequestParam("discountCode") String discountCode) {
		UserInformation userInformation = (UserInformation) session.getAttribute("userInformation");
		if (userInformation == null) {
			return "member/login";
		}


		Orders newOrder = new Orders();
		int userId = userInformation.getId();

		newOrder.setUserInformation(userInformation);
		newOrder.setTotalPrice(totalPrice);
		newOrder.setNote(note);
		
		System.out.println(discountCode);

		// 購買 折扣碼數量-1 用完的話不會報錯 我懶得寫 ouo b
		if (!discountCode.equals("")) {
			DiscountCodes fdc = ordService.findDiscountCode(discountCode);
			Integer q = fdc.getQuantity();
			newOrder.setDiscountCode(fdc);
			fdc.setQuantity(q - 1);
		}

		ordService.insertNewOrder(newOrder);

		for (int i = 0; i < courseId.length; i++) {

			OrderItems newOrderItems = new OrderItems();
			newOrderItems.setOrder(newOrder);
			CourseProfiles c = cService.findCourseProfileById(courseId[i]);
			newOrderItems.setCourseProfile(c);
			newOrderItems.setQuantity(1);

			ordService.insertNewOrderItems(newOrderItems);
		}

		return "/order/paymentSuccess";

	}

	// 回傳優惠額度
	@GetMapping("/applyDiscount/{discountCode}")
	@ResponseBody
	public Integer applyDiscount(@PathVariable String discountCode) {
		DiscountCodes fdc = ordService.findDiscountCode(discountCode);

		if (fdc != null) {
			return fdc.getDiscount();

		} else {
			return null;
		}

	}

	@GetMapping("/order/show")
	public String showOrders(HttpSession session, Model model) {
		UserInformation userInformation = (UserInformation) session.getAttribute("userInformation");
		if (userInformation == null) {
			return "member/login";
		}
		int userId = userInformation.getId();

		List<Orders> orders = ordService.findByUserId(userId);
		model.addAttribute("orders", orders);
		return "/order/showAllOrders";
	}

	// 全部折扣碼
	@GetMapping("/backstage/showDiscountCode")
	public String showDiscountCode(Model model) {
		List<DiscountCodes> codeList = ordService.showAllDiscountCode();
		model.addAttribute("codeList", codeList);
		return "/backstage/discountManage";
	}

	// 使用折扣碼
	@PostMapping("/backstage/insertDiscountCode")
	public String insertDiscountCode(@RequestParam("discount") Integer discount,
			@RequestParam("discountCode") String dCode, @RequestParam("quantity") Integer quantity,
			@RequestParam("startTime") String startTime, @RequestParam("endTime") String endTime,
			@RequestParam("note") String note, Model model) {
		System.out.println(startTime);
		System.out.println(discount);
		DiscountCodes ndc = new DiscountCodes();
		ndc.setDiscount(discount);
		ndc.setDiscountCode(dCode);
		ndc.setQuantity(quantity);
		ndc.setStartTime(startTime);
		ndc.setEndTime(endTime);
		ndc.setNote(note);

		ordService.insertDiscountCode(ndc);

		return "redirect:/backstage/showDiscountCode";
	}

	// 刪除折扣碼
	@GetMapping("/deleteDiscount/{id}")
	public String deleteDiscountCode(@PathVariable Integer id) {
		ordService.deleteById(id);
		return "redirect:/backstage/showDiscountCode";
	}

	// 更新折扣碼
	@PostMapping("/updateDiscount/{id}")
	public String editDiscountCode(@PathVariable Integer id, @RequestParam("discount") Integer discount,
			@RequestParam("discountCode") String discountCode, @RequestParam("quantity") Integer quantity,
			@RequestParam("startTime") String startTime, @RequestParam("endTime") String endTime,
			@RequestParam("note") String note, Model model) {
		System.out.println(discount);

		ordService.updateById(discount, discountCode, quantity, startTime, endTime, note, id);

		return "redirect:/backstage/showDiscountCode";
	}

	// 綠界//未完
	@PostMapping("/order/ecpay")
	@ResponseBody
	public String genAioCheckOutOneTime(HttpSession session, @RequestParam("courseId") int[] courseId,
			@RequestParam("totalPrice") Integer totalPrice, @RequestParam("note") String note,
			@RequestParam("discountCode") String discountCode ) {
		
		UserInformation userInformation = (UserInformation) session.getAttribute("userInformation");
		if (userInformation == null) {
			return "member/login";
		}

		Orders newOrder = new Orders();
		int userId = userInformation.getId();

		newOrder.setUserInformation(userInformation);
		newOrder.setTotalPrice(totalPrice);
		newOrder.setNote(note);
		
		System.out.println(discountCode);

		// 購買 折扣碼數量-1 用完的話不會報錯 我懶得寫 ouo b
		if (!discountCode.equals("")) {
			DiscountCodes fdc = ordService.findDiscountCode(discountCode);
			Integer q = fdc.getQuantity();
			newOrder.setDiscountCode(fdc);
			fdc.setQuantity(q - 1);
		}

		ordService.insertNewOrder(newOrder);

		for (int i = 0; i < courseId.length; i++) {

			OrderItems newOrderItems = new OrderItems();
			newOrderItems.setOrder(newOrder);
			CourseProfiles c = cService.findCourseProfileById(courseId[i]);
			newOrderItems.setCourseProfile(c);
			newOrderItems.setQuantity(1);

			ordService.insertNewOrderItems(newOrderItems);
		}
		
		
		AllInOne aio = new AllInOne("");
		Integer aa = (int) (Math.random() * 1000000);
		String aaa = aa.toString();
		AioCheckOutOneTime obj = new AioCheckOutOneTime();

		String tp = totalPrice.toString();
		System.out.println(tp);

		obj.setMerchantTradeNo("codegym" + aaa);
		obj.setMerchantTradeDate("2017/01/01 08:05:23");
		obj.setTotalAmount(tp);
		obj.setTradeDesc("test Description");
		obj.setItemName("CodeGym線上課程");
		obj.setReturnURL("http://211.23.128.214:5000");
		obj.setOrderResultURL("http://localhost:8080/courseWeb/paymentSuccess");
		obj.setNeedExtraPaidInfo("N");
		obj.setRedeem("Y");
		System.out.println(userId);

		String form = aio.aioCheckOut(obj, null);
		
		System.out.println(userId);
		return form;
	}
}
