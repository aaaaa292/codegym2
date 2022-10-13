package com.ispan.codegym.learning.model.dto;

import java.util.Date;

public class CourseScoreDto {
	public CourseScoreDto() {
	}
	
	public CourseScoreDto(Date time, String userName, int score, String comment) {
		super();
		this.time = time;
		this.userName = userName;
		this.score = score;
		this.comment = comment;
	}

	private Date time;
	
	private String userName;
	
	private int score;
	
	private String comment;

	public Date getTime() {
		return time;
	}

	public void setTime(Date time) {
		this.time = time;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public int getScore() {
		return score;
	}

	public void setScore(int score) {
		this.score = score;
	}

	public String getComment() {
		return comment;
	}

	public void setComment(String comment) {
		this.comment = comment;
	}
	
}
