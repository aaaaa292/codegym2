package com.ispan.codegym.customerservice.model.bean;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import com.ispan.codegym.member.model.bean.UserInformation;

@Entity
@Table(name = "QuestionScore")
public class QuestionScore {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id")
	private Integer id;

	@Column(name = "score")
	public int Score;

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "questionAnswerId")
	private QuestionAnswer questionAnswer;

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "userId")
	private UserInformation userInformation;

	public QuestionScore() {
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public int getScore() {
		return Score;
	}

	public void setScore(int score) {
		Score = score;
	}

	public QuestionAnswer getQuestionAnswer() {
		return questionAnswer;
	}

	public void setQuestionAnswer(QuestionAnswer questionAnswer) {
		this.questionAnswer = questionAnswer;
	}

	public UserInformation getUserInformation() {
		return userInformation;
	}

	public void setUserInformation(UserInformation userInformation) {
		this.userInformation = userInformation;
	}

}
