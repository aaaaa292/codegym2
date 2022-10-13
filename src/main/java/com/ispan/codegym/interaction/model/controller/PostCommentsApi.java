package com.ispan.codegym.interaction.model.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ispan.codegym.interaction.model.bean.PostComments;
import com.ispan.codegym.interaction.model.bean.Posts;
import com.ispan.codegym.interaction.model.service.PostCommentsService;
import com.ispan.codegym.interaction.model.service.PostsService;
import com.ispan.codegym.member.model.bean.UserInformation;

@Controller
public class PostCommentsApi {

	@Autowired
	private PostsService pService;
	
	@Autowired
	private PostCommentsService pcService;
	
	// 拿 ID 參數到 回文頁面
	@GetMapping("/comment/addComment/{id}")
	public String addComment(HttpSession session,@PathVariable Integer id, Model model) {
		
		//若未登入轉跳登入頁面
				UserInformation userInformation = (UserInformation) session.getAttribute("userInformation");
				if (userInformation == null) {
					return "member/login";
				}
		
		Posts post = pService.findPostById(id);
		model.addAttribute("post", post);
		
		return "interaction/addComment";
	}
	
	// 回覆發文
	@PostMapping("/comment/insertComment")
	public String addComment(HttpSession session
			 , @RequestParam("postId") int postId
			 , @RequestParam("comment") String comment, Model model) {
		
		UserInformation userInformation = (UserInformation) session.getAttribute("userInformation");
		if (userInformation == null) {
			return "member/login";
		}
			
		Posts post = pService.findPostById(postId);
		
		PostComments newComment = new PostComments();
		newComment.setComment(comment);
		newComment.setPost(post);
		newComment.setUserInformation(userInformation);
		
		pcService.insertComment(newComment);
		
		model.addAttribute("newComment", newComment);
		
		return "redirect:/post/showOnePost/" + postId ;
	}
	
		// 最新回文
		@GetMapping("/comment/latest")
		@ResponseBody
		public PostComments findLastestComment() {
			return pcService.lastsetComment();
		}
		
		// 分頁顯示
		@GetMapping("/comment/showAllComments")
		public String PostComments(
				  @RequestParam(name="c",defaultValue = "1") Integer pageNumber
				, Model model) {
			
			Page<PostComments> commentPage = pcService.findCommentByPage(pageNumber);
			model.addAttribute("commentPage", commentPage); 
					
			//00
			PostComments lastsetComment = pcService.lastsetComment();
			//00
			model.addAttribute("lastsetComment", lastsetComment);
			
			return "interaction/showAllComments";
		}
		
		
		
		
	
}
