package com.ispan.codegym.member.controller;

import java.io.IOException;
import java.util.Base64;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.repository.query.Param;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.ispan.codegym.member.model.bean.TeacherExpertise;

import com.ispan.codegym.member.model.bean.UserInformation;
import com.ispan.codegym.member.model.bean.UserInterest;
import com.ispan.codegym.member.model.dao.MemberDao;
import com.ispan.codegym.member.service.TeacherExpertiseService;
import com.ispan.codegym.member.service.UserInterestService;

@Controller
public class SignUpController {
	@Autowired
	private MemberDao mdao;
	@Autowired
	private UserInterestService iService;
	@Autowired
	private TeacherExpertiseService tService;
	

	@Autowired
	private JavaMailSender mailSender;

	@GetMapping("/member/add")
	public String member(Model model) {
		return "member/signup";
	}
	//註冊資料
	@PostMapping("/member/add/result")
	public String postMessage(HttpSession session, 
			@Param("email") String email, 
			@Param("password") String password,
			@Param("name") String name, 
			@Param("phone") String phone, 
			@Param("birthday") String birthday,
			@Param("gender") String gender, 
			@Param("role") int role, 
			@Param("expertise")String expertise,
			@Param("experience")String  experience,
			@Param("teaching")String teaching,
			@Param("Interestcourses") String Interestcourses,
			@Param("learningexperience") String learningexperience,
			@RequestParam("photo") MultipartFile photo,
			Model model) {
		

		
		
		System.out.println("photo" + photo);
		UserInformation userInformation = new UserInformation();
		
		
		userInformation.setEmail(email);
		userInformation.setPassword(password);
		userInformation.setName(name);
		userInformation.setPhone(phone);
		userInformation.setBirthday(birthday);
		userInformation.setGender(gender);
		userInformation.setRole(role);
		
		//設定隨機變數驗證碼50碼
		String verification = getRandomString(50);
		userInformation.setVerification(verification);
		
		try {// 圖片拿到BYTE
			System.out.println("圖片:"+(photo.getBytes()));
			userInformation.setPhoto(photo.getBytes());
			String base64Photo = Base64.getEncoder().encodeToString(photo.getBytes());
			userInformation.setBase64Photo(base64Photo);
		} catch (IOException e) {
			e.printStackTrace();
		}
		try {
			//將註冊自料存入資料庫
			mdao.save(userInformation);
			
			if (role == 1) {
				TeacherExpertise teacherexpertise = new  TeacherExpertise();
				teacherexpertise.setUserId(userInformation.getId());
				teacherexpertise.setExperience(experience);
				teacherexpertise.setExpertise(expertise);
				teacherexpertise.setTeaching(teaching);
				tService.save(teacherexpertise);
				
			}
			else if (role == 2) {
				UserInterest UserInterestData = new UserInterest();
				UserInterestData.setUserId(userInformation.getId());
				UserInterestData.setInterestcourses(Interestcourses);
				UserInterestData.setLearningexperience(learningexperience);
				// 將註冊自料存入資料庫
				iService.save(UserInterestData);
			}
			
			Integer newusers = userInformation.getId();
			System.out.println(newusers);
		
			//發信
			SimpleMailMessage message = new SimpleMailMessage();
			//收件人
			message.setTo(email);
			//主旨
			message.setSubject("Gmail 發信");
			//信件內容
			message.setText("歡迎加入 codegym 會員！\r\n"
					+ "請點擊以下連結，立即開通您的會員帳號吧。點我開通:http://localhost:8080/courseWeb/member/loginVerification/"+verification);
			//把信發出去
			mailSender.send(message);
			// 判斷權限是老師還是學生(導頁要再更改)
			
		} catch (Exception e) {
			// TODO: handle exception
		}
		return "member/login";
	}

	@GetMapping("/viewmember")
	public String viewMessagesPage(@RequestParam(name = "p", defaultValue = "1") Integer UserInformation, Model model) {		
//		model.addAttribute("page", page);
		return "viewMessage";
	}

	// 註冊成功會發mail
	@GetMapping("/sendToGmail")
	public void sendToGmail() {
		System.out.println("sendToGmail");
		SimpleMailMessage message = new SimpleMailMessage();
		message.setTo("mod20130613@gmail.com");
		message.setSubject("測試透過 Gmail 去發信");
		message.setText("hi org.springframework.mail.SimpleMailMessage 透過 Gmail 發信。");
		mailSender.send(message);
	}
	//隨機產生英文家數字亂數的方法
	static String getRandomString(int i) {
		String theAlphaNumericS;
		StringBuilder builder;

		theAlphaNumericS = "ABCDEFGHIJKLMNOPQRSTUVWXYZ" + "0123456789";

		// create the StringBuffer
		builder = new StringBuilder(i);

		for (int m = 0; m < i; m++) {

			// generate numeric
			int myindex = (int) (theAlphaNumericS.length() * Math.random());

			// add the characters
			builder.append(theAlphaNumericS.charAt(myindex));
		}
		System.out.println("隨機產生50碼驗證碼: " +builder.toString());
		return builder.toString();
	}
}
