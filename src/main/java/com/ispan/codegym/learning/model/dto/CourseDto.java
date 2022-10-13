package com.ispan.codegym.learning.model.dto;

import java.util.ArrayList;
import java.util.Date;

public class CourseDto {
	
	public CourseDto() {
	}

	public CourseDto(Long id, String name, String introduction, Date time, String teacherName, int coursePrice, String photoPath,
			ArrayList<String> tags, ArrayList<Integer> scores, ArrayList<String> comment) {
		this.id = id;
		this.name = name;
		this.introduction = introduction;
		this.time = time;
		this.teacherName = teacherName;
		this.coursePrice = coursePrice;
		this.photoPath = photoPath;
		this.tags = tags;
		this.scores = scores;
		this.comment = comment;
	}
	
	private Long id;
	
	private String name;
	
	private String introduction;
	
	private Date time;
	
	private String teacherName;
	
	private int coursePrice;
	
	private String photoPath;
	
	private ArrayList<String> tags;
	
	private ArrayList<Integer> scores;
	
	private ArrayList<String> comment;
	
	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	public String getIntroduction() {
		return introduction;
	}

	public void setIntroduction(String introduction) {
		this.introduction = introduction;
	}

	public Date getTime() {
		return time;
	}

	public void setTime(Date time) {
		this.time = time;
	}

	public String getTeacherName() {
		return teacherName;
	}

	public void setTeacherName(String teacherName) {
		this.teacherName = teacherName;
	}

	public int getCoursePrice() {
		return coursePrice;
	}

	public void setCoursePrice(int coursePrice) {
		this.coursePrice = coursePrice;
	}

	public String getPhotoPath() {
		return photoPath;
	}

	public void setPhotoPath(String photoPath) {
		this.photoPath = photoPath;
	}

	public ArrayList<String> getTags() {
		return tags;
	}

	public void setTags(ArrayList<String> tags) {
		this.tags = tags;
	}

	public ArrayList<Integer> getScores() {
		return scores;
	}

	public void setScores(ArrayList<Integer> scores) {
		this.scores = scores;
	}

	public ArrayList<String> getComment() {
		return comment;
	}

	public void setComment(ArrayList<String> comment) {
		this.comment = comment;
	}
	
}
