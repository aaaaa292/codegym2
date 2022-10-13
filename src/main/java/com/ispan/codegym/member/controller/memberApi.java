package com.ispan.codegym.member.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.repository.query.Param;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

import com.ispan.codegym.member.model.dao.MemberDao;
import com.ispan.codegym.member.service.memberService;

@RestController
public class memberApi {
	
	@Autowired
	private memberService mService;
	//檢查帳號是否有誤
	@PostMapping("/member/checkEmail")
	public String checkEmailRepeat(@Param("email") String email) {
		System.out.println("email:"+email);
		if(mService.findMemberByEmail(email) != null) {
			return "重複";
		}
		return "不重複";	
	}

}
