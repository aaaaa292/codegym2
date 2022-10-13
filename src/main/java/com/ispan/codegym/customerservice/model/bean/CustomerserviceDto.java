package com.ispan.codegym.customerservice.model.bean;

import com.fasterxml.jackson.annotation.JsonProperty;

// 不需要下@Entity
public class CustomerserviceDto {

	@JsonProperty("score")
	private String score;
	
	@JsonProperty("questionAnswer")
	private String questionAnswer;
	
	@JsonProperty("user")
	private String user;
	
	public CustomerserviceDto() {
	}
	
	public String getScore() {
		return score;
	}
	public void setScore(String score) {
		this.score = score;
	}
	public String getQuestionAnswer() {
		return questionAnswer;
	}
	public void setQuestionAnswer(String questionAnswer) {
		this.questionAnswer = questionAnswer;
	}
	public String getUser() {
		return user;
	}
	public void setUser(String user) {
		this.user = user;
	}
}
