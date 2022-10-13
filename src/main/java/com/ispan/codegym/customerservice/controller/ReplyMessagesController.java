package com.ispan.codegym.customerservice.controller;

import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.ispan.codegym.customerservice.model.bean.ReceiptMessages;
import com.ispan.codegym.customerservice.model.bean.ReplyMessages;
import com.ispan.codegym.customerservice.service.CustomerserviceService;

@Controller
public class ReplyMessagesController {
	
	@Autowired
	private CustomerserviceService cusService;
	@Autowired
	private JavaMailSender mailSender;
	
	@GetMapping("/customerservice/replayMessage")
	public String addReMessage( Model model) {
		ReplyMessages newReMsg = new ReplyMessages();
		
		model.addAttribute("ReplyMessages", newReMsg);
		return "customerservice/addReMsg";
	}
	
	// 回覆訊息頁面
	@GetMapping("/customerservice/reMessage/{id}")
	public String reMsgById(@PathVariable Integer id, Model model) {
		
		ReceiptMessages cusMsg = cusService.findByReceiptMsgId(id);
		
		model.addAttribute("cusMsg", cusMsg);
		model.addAttribute("cusMsgId", cusMsg.getId());
		return "customerservice/addReMsg";
	}
	
	// 回覆訊息
	@PostMapping("customerservice/postReMessage")
	public String postReMessage(@RequestParam("replyMsgId") int replyMsgId, 
								@RequestParam("userEmail") String userEmail,
								@RequestParam("status") String status,
								@RequestParam("message") String message, Model model) {

		ReceiptMessages rcptMsg = cusService.findByReceiptMsgId(replyMsgId);
		ReplyMessages newReMsg = new ReplyMessages();

		newReMsg.setMessage(message);
		rcptMsg.setStatus(status);
		rcptMsg.setReplyMessages(newReMsg);		
		cusService.insertReplyMsg(newReMsg);
		
		// 更新ReceiptMessages 的 replyMessagesId欄位
		rcptMsg.setReplyMessages(newReMsg);
		
		cusService.insertReceiptMsg(rcptMsg);
		
		model.addAttribute("ReceiptMessages", rcptMsg);
		return "redirect:/customerservice/viewOneMessage/" + replyMsgId;
	}
	
	// 回覆訊息
	@PostMapping("customerservice/postReMessage2")
	public String postReMessage2(@RequestParam("replyMsgId") int replyMsgId, 
				 @RequestParam("userName") String userName,
				 @RequestParam("userEmail") String userEmail,
				 @RequestParam("receiptTitle") String receiptTitle,
				 @RequestParam("receiptMsg") String receiptMsg,
				 @RequestParam("status") String status,
				 @RequestParam("message") String message, Model model) {

		ReceiptMessages rcptMsg = cusService.findByReceiptMsgId(replyMsgId);
		ReplyMessages newReMsg = new ReplyMessages();
		SimpleMailMessage emailMsg = new SimpleMailMessage();
		
		newReMsg.setMessage(message);
		rcptMsg.setStatus(status);
		rcptMsg.setReplyMessages(newReMsg);		
		cusService.insertReplyMsg(newReMsg);
		
		/*回復內容寄信通知使用者*/
		//收件人的Email
		emailMsg.setTo(userEmail);
		//主旨
		emailMsg.setSubject("codegym已回覆您的留言");
		//信件內容
		emailMsg.setText("親愛的 " + userName + " 你好，CodeGym 很高興能夠收到你的來信，你所提供的建議，CodeGym 都十分重視及感激。以下為你提供的訊息：\n\n" +
						"標題：" + receiptTitle + "\n" + receiptMsg + "\n\n ---------- 回覆內容 ----------\n\n" +
						message + "\n\n 以上回覆，CodeGym 再次謝謝您的留言，如還有任何問題，歡迎至「客服中心」為您服務，謝謝。" + 
						"http://localhost:8080/courseWeb/customerservice");
		//把信發出去
		mailSender.send(emailMsg);
		System.out.println("已回覆給 " + emailMsg);
		
		// 更新ReceiptMessages 的 replyMessagesId欄位
		rcptMsg.setReplyMessages(newReMsg);
		cusService.insertReceiptMsg(rcptMsg);
		
		model.addAttribute("ReceiptMessages", rcptMsg);
		return "redirect:/customerservice/viewOneMessage/" + replyMsgId;
	}
	
	// 編輯已回覆訊息
	@PostMapping("customerservice/editReMessage")
	public String editReMessage(@RequestParam("receiptId") Integer receiptId,
			@RequestParam("replyMsgId") int replyMsgId, 
			@RequestParam("userName") String userName,
			@RequestParam("userEmail") String userEmail,
			@RequestParam("receiptTitle") String receiptTitle,
			@RequestParam("receiptMsg") String receiptMsg,
			@RequestParam("message") String message, Model model) {
		
		ReplyMessages editReMsg = new ReplyMessages();
		SimpleMailMessage emailMsg = new SimpleMailMessage();
		
		Date date = new Date();
		
		editReMsg.setId(replyMsgId);
		editReMsg.setMessage(message);
		editReMsg.setTime(date);
		cusService.insertReplyMsg(editReMsg);
		
		/*回復內容寄信通知使用者*/
		//收件人的Email
		emailMsg.setTo(userEmail);
		//主旨
		emailMsg.setSubject("codegym已回覆您的留言(回覆更新)");
		//信件內容
		emailMsg.setText("親愛的 " + userName + " 你好，CodeGym 很高興能夠收到你的來信，你所提供的建議，CodeGym 都十分重視及感激。以下為你提供的訊息：\n\n" +
						"標題：" + receiptTitle + "\n" + receiptMsg + "\n\n ---------- 回覆內容 ----------\n\n" +
						message + "\n\n 以上回覆，CodeGym 再次謝謝您的留言，如還有任何問題，歡迎至「客服中心」為您服務，謝謝。" + 
						"http://localhost:8080/courseWeb/customerservice");
		//把信發出去
		mailSender.send(emailMsg);
		System.out.println("已回覆給 " + emailMsg);
		
		return "redirect:/customerservice/viewOneMessage/" + receiptId;
	}
}
