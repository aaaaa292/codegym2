package com.ispan.codegym.member.controller;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

public class testteacher {
	
	@GetMapping("/member/testteacher")
	public String member1() {
		return "member/teacher1";
	}
}
