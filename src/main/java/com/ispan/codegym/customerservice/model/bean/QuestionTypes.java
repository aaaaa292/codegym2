package com.ispan.codegym.customerservice.model.bean;

import java.util.LinkedHashSet;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

@Entity
@Table(name = "QuestionTypes")
public class QuestionTypes {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id")
	private Integer id;

	@Column(name = "type", columnDefinition = "NVARCHAR(MAX)")
	private String type;

	@Column(name = "imagePath", columnDefinition = "NVARCHAR(MAX)")
	private String imagePath;

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "questionTypeId", cascade = CascadeType.ALL)
	private Set<QuestionAnswer> questionAnswers = new LinkedHashSet<QuestionAnswer>();

	public QuestionTypes() {
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getImagePath() {
		return imagePath;
	}

	public void setImagePath(String imagePath) {
		this.imagePath = imagePath;
	}

	public Set<QuestionAnswer> getQuestionAnswers() {
		return questionAnswers;
	}

	public void setQuestionAnswers(Set<QuestionAnswer> questionAnswers) {
		this.questionAnswers = questionAnswers;
	}

}
