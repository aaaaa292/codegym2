package com.ispan.codegym.member.controller;

import java.util.Base64;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.ispan.codegym.member.model.bean.TeacherExpertise;
import com.ispan.codegym.member.model.bean.UserInformation;
import com.ispan.codegym.member.model.bean.UserInterest;
import com.ispan.codegym.member.model.dao.MemberDao;
import com.ispan.codegym.member.model.dao.TeacherexpertiesDao;
import com.ispan.codegym.member.model.dao.UserinterestDao;
import com.ispan.codegym.member.service.LoginService;
import com.ispan.codegym.member.service.TeacherExpertiseService;
import com.ispan.codegym.member.service.UserInterestService;

@Controller
public class LoginController {
	@Autowired
	private LoginService lService;
	@Autowired
	private TeacherExpertiseService tService;
	@Autowired
	private  UserInterestService uService;
	@Autowired
	private MemberDao mdao;
	
	@Autowired
	private TeacherexpertiesDao tDao;
	
	@Autowired
	private UserinterestDao iDao;
	
	@GetMapping("/member/testteacher")
	public String member1() {
		return "member/teacher1";
	}

	@GetMapping("/member/login")
	public String loginPage() {
		return "member/login";
	}

	@PostMapping("/member/login/check")
	public String login(HttpSession session, @RequestParam("email") String email,
			@RequestParam("password") String password,Model model) {

		// 將帳號密碼拿去查詢看是否有資料
		UserInformation userInformation = lService.findMemberByEmailAndPassword(email, password);
		if (userInformation == null) {
			return "/member/Loginfailed";
		}
		System.out.println("userInformation"+userInformation.toString());
		String base64String = Base64.getEncoder().encodeToString(userInformation.getPhoto());
		session.setAttribute("userInformation", userInformation);
		session.setAttribute("base64String", base64String);
		if (userInformation.getRole() == 1) {
			TeacherExpertise teacherExpertise = tService.findByUserId(userInformation.getId());
			session.setAttribute("teacherExpertise", teacherExpertise);				
		}
		if (userInformation.getRole() == 2) {
			UserInterest userInterest = uService.findByUserId(userInformation.getId());
			System.out.println("userInterest:"+userInterest.toString());
			session.setAttribute("userInterest", userInterest);
			//學習課程要另外存，前端撈資料才不會有問題
			session.setAttribute("Interestcourses", userInterest.getInterestcourses());
		}
		// 如果有撈到資料去首頁
		return "index";
	
	}

	@GetMapping("/member/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "index";
	}
	
	@GetMapping("/member/loginVerification/{verification}")
	public String loginVerification(HttpSession session,@PathVariable("verification") String verification) {
		System.out.println("進來了loginVerification");
		// 將帳號密碼拿去查詢看是否有資料
		UserInformation userInformation = lService.findMemberByVerification(verification);
		// 如果有撈到資料去首頁，將資料圖片存進seesion
		if (userInformation != null) {
			String base64String = Base64.getEncoder().encodeToString(userInformation.getPhoto());
			session.setAttribute("userInformation", userInformation);
			session.setAttribute("base64String", base64String);
			System.out.println("userInformation,,"+userInformation.toString());
//			存完seesion驗證碼刪除並更新資料下次無法登入
			// 開通權限
			userInformation.setVerification("OK");
			
			mdao.save(userInformation);
			//學生興趣
			
			if (userInformation.getRole() == 1) {
				TeacherExpertise teacherExpertise = tService.findByUserId(userInformation.getId());
				session.setAttribute("teacherExpertise", teacherExpertise);				
			}
			if (userInformation.getRole() == 2) {
				UserInterest userInterest = uService.findByUserId(userInformation.getId());
				System.out.println("userInterest:"+userInterest.toString());
				session.setAttribute("userInterest", userInterest);
				//學習課程要另外存，前端撈資料才不會有問題
				session.setAttribute("Interestcourses", userInterest.getInterestcourses());
				
			}
			return "member/login";
		}else {
			// 沒有撈到資料去去登入錯誤頁
			return "member/loginError";
		}
		
		
	}

	private TeacherExpertise findByUserId(Integer id) {
		// TODO Auto-generated method stub
		return null;
	}

	@GetMapping("/member/loginVerification1")
	public String loginVerification1(HttpSession sessionn) {
	
			return "member/login";
	
		
	}
}
