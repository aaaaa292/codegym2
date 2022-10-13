package com.ispan.codegym.customerservice.controller;

import javax.servlet.http.HttpSession;

import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.Payload;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.messaging.simp.SimpMessageHeaderAccessor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import com.ispan.codegym.customerservice.model.bean.ChatMessage;
import com.ispan.codegym.member.model.bean.UserInformation;

/**
 * 接收Client送來的WebSocket訊息及推送給前端的訊息
 */
@Controller
public class ChatController {
	
	// websocket測試1
	@GetMapping("/customerservice/chat")
	public String chat() {
		return "customerservice/index";
	}
	
	// websocket測試2
	@GetMapping("/customerservice/chat/{userName}")
	public String chat2(HttpSession session, @PathVariable String userName, Model model) {
		UserInformation userInformation = (UserInformation) session.getAttribute("userInformation");
		if (userInformation == null) {
			return "member/login";
		}
		return "customerservice/index";
	}
    
    /**
     * 處理前端加入聊天室的訊息，並把訊息推送給前端
     */
    @MessageMapping("/join")
    @SendTo("/topic/customerservice")
    public ChatMessage addUser(@Payload ChatMessage chatMessage, 
            SimpMessageHeaderAccessor headerAccessor) {
        // 把username加入WebSocket的Session
        headerAccessor.getSessionAttributes().put("username", chatMessage.getSender());
        return chatMessage; // 返回時會將訊息送至/topic/customerservice
    }
    
    /**
     * 處理前端送來的聊天訊息，並把訊息推送給前端
     */
    @MessageMapping("/chat")
    @SendTo("/topic/customerservice")
    public ChatMessage sendMessage(@Payload ChatMessage chatMessage) {
        return chatMessage; // 返回時會將訊息送至/topic/customerservice
    }

}