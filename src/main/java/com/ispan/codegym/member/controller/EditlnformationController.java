package com.ispan.codegym.member.controller;

import java.util.Optional;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.ispan.codegym.member.model.bean.TeacherExpertise;
import com.ispan.codegym.member.model.bean.UserInformation;
import com.ispan.codegym.member.model.bean.UserInterest;
import com.ispan.codegym.member.model.dao.MemberDao;
import com.ispan.codegym.member.model.dao.TeacherexpertiesDao;
import com.ispan.codegym.member.model.dao.UserinterestDao;

@Controller
public class EditlnformationController {
	@Autowired
	private MemberDao mdao;
	@Autowired
	private TeacherexpertiesDao tDao;
	@Autowired
	private UserinterestDao iDao;
	
	@GetMapping("/member/edit")
	public String EditInformation(HttpSession session, Model model) {
		UserInformation userInformation = (UserInformation) session.getAttribute("userInformation");
		if (userInformation == null) {
			return "member/login";
		}
		if (userInformation.getRole() == 1) {
			return "member/EditTeacherInformation";
		}
		return "member/EditInformation";
	}
	
	//編輯學生資料
	@PostMapping("/member/edit/editStudentInfo")
	public String editStudentInfo(HttpSession session, 	
			@RequestParam("userId") Integer userId,
			@RequestParam("password") String password,
			@RequestParam("name") String name, 
			@RequestParam("phone") String phone,
			@RequestParam("Interestcourses") String Interestcourses,
			@RequestParam("learningexperience") String  learningexperience,
			@RequestParam("idInterest") Integer  idInterest,
			Model model) {
		System.out.println("id"+userId);
		Optional<UserInformation> OptionalUserInfor =mdao.findById(userId);
		UserInformation userInformation  =  OptionalUserInfor.get();
		userInformation.setPassword(password);
		userInformation.setName(name);
		userInformation.setPhone(phone);
		Optional<UserInterest> OptionalUserInterest =iDao.findByUserId(userId);
		UserInterest userInterest =  OptionalUserInterest.get();
		userInterest.setInterestcourses(Interestcourses);
		userInterest.setLearningexperience(learningexperience);
	
		try {
			//將編輯過的資料存入資料庫
			mdao.save(userInformation);
			iDao.save(userInterest);
			session.setAttribute("userInformation", userInformation);
			session.setAttribute("userInterest", userInterest);
			//學習課程要另外存，前端撈資料才不會有問題
			session.setAttribute("Interestcourses", userInterest.getInterestcourses());
		} catch (Exception e) {
			// TODO: handle exception
		}
		if (userInformation.getRole() == 1) {
			return "member/EditTeacherInformation";
		}
		return "member/EditInformation";
	}
	
	//編輯老師資料
	@PostMapping("/member/edit/editTeacherInfo")
	public String editTeacherInfo(HttpSession session, 	
			@RequestParam("userId") Integer userId,
			@RequestParam("password") String password,
			@RequestParam("name") String name, 
			@RequestParam("phone") String phone, 
			@RequestParam("expertise") String expertise, 
			@RequestParam("experience") String experience, 
			@RequestParam("teaching") String teaching, 
			Model model) {
		System.out.println("id"+userId);
		Optional<UserInformation> OptionalUserInfor =mdao.findById(userId);
		UserInformation userInformation  =  OptionalUserInfor.get();
		userInformation.setPassword(password);
		userInformation.setName(name);
		userInformation.setPhone(phone);
		Optional<TeacherExpertise> OptionalTeacherExpertise =tDao.findByUserId(userId);
		TeacherExpertise teacherExpertise  =  OptionalTeacherExpertise.get();
		teacherExpertise.setExperience(experience);
		teacherExpertise.setExpertise(expertise);
		teacherExpertise.setTeaching(teaching);
		try {
			//將註冊自料存入資料庫
			mdao.save(userInformation);
			tDao.save(teacherExpertise);
			session.setAttribute("userInformation", userInformation);
			session.setAttribute("teacherExpertise", teacherExpertise);
		} catch (Exception e) {
			// TODO: handle exception
		}
		if (userInformation.getRole() == 1) {
			return "member/EditTeacherInformation";
		}
		return "member/EditInformation";
	}
	
}
