package com.ispan.codegym.customerservice.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.ispan.codegym.customerservice.model.bean.ReceiptMessageTypes;
import com.ispan.codegym.customerservice.model.bean.ReceiptMessages;
import com.ispan.codegym.customerservice.service.CustomerserviceService;
import com.ispan.codegym.member.model.bean.UserInformation;

@Controller
public class ReceiptMessagesController {

	@Autowired
	private CustomerserviceService cusService;
	
	
	/* ----- 前台使用者 -----*/
	// fronted 到新增頁
	@GetMapping("/customerservice/addCusMessage")
	public String addRcptMessage(HttpSession session, Model model) {
		UserInformation userInformation = (UserInformation) session.getAttribute("userInformation");
		if (userInformation == null) {
			return "member/login";
		}
		ReceiptMessages newMsg = new ReceiptMessages();
		
		model.addAttribute("ReceiptMessages", newMsg);
		return "customerservice/addCusMsg";
	}
	
	//  fronted 送出新增 
	@PostMapping("/postMessage")
	public String postMessage(HttpSession session, 
			@RequestParam String receiptTypeValue,
			@ModelAttribute ReceiptMessages msg, 
			Model model) {
		UserInformation userInformation = (UserInformation) session.getAttribute("userInformation");
		if (userInformation == null) {
			return "member/login";
		}
		
		ReceiptMessageTypes receiptTypes = new ReceiptMessageTypes();
		receiptTypes.setType(receiptTypeValue);
		
		// 先去查有沒有存在
		receiptTypes = cusService.checkReceiptTypeExist(receiptTypes.getType());
		
		if(receiptTypes == null) {			
			// 沒有就新增
			receiptTypes = new ReceiptMessageTypes();
			receiptTypes.setType(receiptTypeValue);
			cusService.insertReceiptType(receiptTypes);

			// 新增完 再查一次 取得id
			receiptTypes = cusService.checkReceiptTypeExist(receiptTypes.getType());
        }
        else {
        	// 已存在不需要做任何動作
        }
		
		msg.setReceiptMessageTypes(receiptTypes);
		cusService.insertReceiptMsg(msg);
		ReceiptMessages newMsg = new ReceiptMessages();
		
		model.addAttribute("ReceiptMessages", newMsg);
		return "redirect:/customerservice/allMessages";
	}
	
//	// fronted 使用者訊息顯示在訊息記錄頁面
//	@GetMapping("/customerservice/allMessages")
//	public String findAllMessages(HttpSession session, Model model) {	
//		UserInformation userInformation = (UserInformation) session.getAttribute("userInformation");
//		if (userInformation == null) {
//			return "member/login";
//		}
//		
//		List<ReceiptMessages> receiptList = cusService.findByUserId(userInformation.getId());
//		
//		model.addAttribute("ReceiptMessages", receiptList);
//        return "customerservice/frontedAllMsg";
//	}
	
	// fronted 使用者訊息顯示在訊息記錄頁面，只顯示前5筆
	@GetMapping("/customerservice/allMessages")
	public String findAllMessages(@RequestParam(name="p",defaultValue = "1") Integer pageNumber, Model model) {
		Page<ReceiptMessages> page = cusService.findByReceiptMsgPage(pageNumber);
		
		model.addAttribute("page", page);			
		return "customerservice/frontedAllMsg";
	}
	
	// fronted 拿ID參數到 單發文頁面
	@GetMapping("/customerservice/oneMessage/{id}")
	public String findOneMessage(@PathVariable Integer id, Model model) {
		ReceiptMessages rMsg = cusService.findByReceiptMsgId(id);	
		
		model.addAttribute("receiptMessages", rMsg);
		return "customerservice/frontedOneMsg";
	}
	
	
	/* ----- 後台使用者 -----*/
	// backstage 列出所有收到訊息
	@GetMapping("/customerservice/viewMessages")
	public String findAllReceipt(Model model) {		
		List<ReceiptMessages> receiptList = cusService.findAllReceipt();
		
		model.addAttribute("ReceiptMessages", receiptList);
        return "customerservice/backstageMsg";
	}
	
	// backstage 拿ID參數到 單發文頁面
	@GetMapping("/customerservice/viewOneMessage/{id}")
	public String viewOneMessage(@PathVariable Integer id, Model model) {
		ReceiptMessages rMsg = cusService.findByReceiptMsgId(id);	
		
		model.addAttribute("receiptMessages", rMsg);
		return "customerservice/backstageOneMsg";
	}
	
	// backstage 刪除
	@GetMapping("/customerservice/deleteReceipt/{id}")
	public String deleteReceipt(@PathVariable Integer id, Model model) {
		cusService.deleteReceiptById(id);
		
		return "redirect:/customerservice/viewMessages";
	}
}
