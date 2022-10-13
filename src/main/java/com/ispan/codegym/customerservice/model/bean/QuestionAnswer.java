package com.ispan.codegym.customerservice.model.bean;

import java.util.Date;
import java.util.LinkedHashSet;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.PrePersist;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;

@Entity
@Table(name = "QuestionAnswer")
public class QuestionAnswer {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id")
	private Integer id;

	@Column(name = "question", columnDefinition = "NVARCHAR(MAX)")
	private String question;

	@Column(name = "answer", columnDefinition = "NVARCHAR(MAX)")
	private String answer;
	
	@JsonFormat(pattern = "yyyy/MM/dd HH:mm:ss", timezone = "Asia/Taipei") // JSON
	@DateTimeFormat(pattern = "yyyy/MM/dd HH:mm:ss") // SpringMVC
	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "time")
	private Date time;
	
    @ManyToOne(fetch = FetchType.LAZY) 
    @JoinColumn(name = "questionTypeId")
    private QuestionTypes questionTypeId;
    
    @OneToMany(fetch = FetchType.LAZY, mappedBy = "questionAnswer", cascade = CascadeType.ALL)
	private Set<QuestionScore> questionScore = new LinkedHashSet<QuestionScore>();

	public QuestionAnswer() {
	}

	@PrePersist // 物件轉換成Persistent狀態前要執行的方法
	public void onCreate() {
		if (time == null) {
			time = new Date();
		}
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getQuestion() {
		return question;
	}

	public void setQuestion(String question) {
		this.question = question;
	}

	public String getAnswer() {
		return answer;
	}

	public void setAnswer(String answer) {
		this.answer = answer;
	}

	public Date getTime() {
		return time;
	}

	public void setTime(Date time) {
		this.time = time;
	}

	public QuestionTypes getQuestionTypeId() {
		return questionTypeId;
	}

	public void setQuestionTypeId(QuestionTypes questionTypeId) {
		this.questionTypeId = questionTypeId;
	}

	public Set<QuestionScore> getQuestionScore() {
		return questionScore;
	}

	public void setQuestionScore(Set<QuestionScore> questionScore) {
		this.questionScore = questionScore;
	}
	
}
