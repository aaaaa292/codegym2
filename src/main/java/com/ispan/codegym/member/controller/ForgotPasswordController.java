package com.ispan.codegym.member.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.repository.query.Param;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.ispan.codegym.member.model.bean.UserInformation;
import com.ispan.codegym.member.model.dao.MemberDao;
import com.ispan.codegym.member.service.LoginService;

@Controller
public class ForgotPasswordController {
	@Autowired
	private LoginService lService;
	@Autowired
	private MemberDao mdao;

	@Autowired
	private JavaMailSender mailSender;

	@GetMapping("/member/forgotPassword")
	public String member(Model model) {
		return "/member/forgotPassword";
	}

	// email送出
	@PostMapping("/member/changepassword")
	public String postChangepassword(HttpSession session, @Param("email") String email, Model model) {
		//把前端丟給後端的eamil先印出來看一下正確
		System.out.println("email:"+email);
		// 設定隨機變數驗證碼6碼
		String password = getRandomString(6);

		// 將帳號密碼拿去查詢看是否有資料
		UserInformation userInformation = lService.findByEmail(email);
		//將亂數的值設定道密碼
		userInformation.setPassword(password);

		// System.out.println(userInformation.toString());

		try {
			// 將新的密碼存入資料庫
			mdao.save(userInformation);
			//把ID取出來印出來
			Integer newusers = userInformation.getId();
			System.out.println(newusers);

			// 發信0
			SimpleMailMessage message = new SimpleMailMessage();
			// 收件人
			message.setTo(email);
			// 主旨
			message.setSubject("Gmail 發信");
			// 信件內容

			message.setText("您好:以下是您補發的登入密碼" + (password)

					+ "請點擊以下連結:。:http://localhost:8080/courseWeb/member/loginVerification/");
			// 把信發出去
			mailSender.send(message);

		} catch (Exception e) {

		}
		return "member/login";
	}


	// 隨機產生英文家數字亂數的方法
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
		System.out.println("隨機產生6碼驗證碼: " + builder.toString());
		return builder.toString();
	}
}
