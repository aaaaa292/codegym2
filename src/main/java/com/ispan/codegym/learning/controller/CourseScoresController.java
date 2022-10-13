package com.ispan.codegym.learning.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ispan.codegym.learning.model.bean.CourseProfiles;
import com.ispan.codegym.learning.model.bean.CourseScores;
import com.ispan.codegym.learning.model.dto.CourseScoreDto;
import com.ispan.codegym.learning.service.CourseScoresService;
import com.ispan.codegym.learning.service.CoursesService;
import com.ispan.codegym.member.model.bean.UserInformation;

@Controller
public class CourseScoresController {
	@Autowired
	private CoursesService cService;
	
	@Autowired
	private CourseScoresService csService;
	
	@GetMapping("/course/score/show/{courseId}")
	@ResponseBody
	public List<CourseScoreDto> showCourseScore(@PathVariable int courseId) {
		List<CourseScoreDto> list = new ArrayList<>(); 
		for(CourseScores element : csService.findByCourseId(courseId)) {
			list.add(new CourseScoreDto(element.getTime(), element.getUserInformation().getName(), element.getScore(), element.getComment()));
	    }
		return list;
	}
			
	@PostMapping("/course/score/add/{courseId}")
	@ResponseBody
	public void addCourseScore(HttpSession session, @PathVariable int courseId, 
			@RequestParam("score") int score, 
			@RequestParam("comment") String comment) {
		UserInformation userInformation = (UserInformation) session.getAttribute("userInformation");
		if(userInformation != null) {
			CourseProfiles courseProfile = cService.findCourseProfileById(courseId);
			CourseScores courseScores = csService.findByUserIdAndCourseId(userInformation.getId(), courseId);
			// 更新課程評分及評論
			if (courseScores != null) {
				courseScores.setScore(score);
				courseScores.setComment(comment);
				csService.saveScoreAndComment(courseScores);
	
			}
			// 增加全新課程評分及評論
			else {
				csService.saveScoreAndComment(new CourseScores(userInformation, courseProfile, score, comment));
			}
		}
	}
}
