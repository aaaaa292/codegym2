package com.ispan.codegym.member.model.bean;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.OneToOne;
import javax.persistence.PrimaryKeyJoinColumn;
import javax.persistence.Table;

@Entity
@Table(name = "UserInterest")
public class UserInterest {
	
	public UserInterest() {
	}
	
	@Id
    @Column(name="userId")
    private Integer userId;
    
    @OneToOne
    @PrimaryKeyJoinColumn(name="userId", referencedColumnName="id")
    private UserInformation userInformation;
	
	@Column(name = "Interestcourses")
	private String Interestcourses;
	
	@Column(name = "learningexperience")
	private String learningexperience;
	
	public UserInformation getUserInformation() {
		return userInformation;
	}

	public void setUserInformation(UserInformation userInformation) {
		this.userInformation = userInformation;
	}

	public Integer getUserId() {
		return userId;
	}

	public void setUserId(Integer integer) {
		this.userId = integer;
	}

	public String getInterestcourses() {
		return Interestcourses;
	}

	public void setInterestcourses(String interestcourses) {
		Interestcourses = interestcourses;
	}

	public String getLearningexperience() {
		return learningexperience;
	}

	public void setLearningexperience(String learningexperience) {
		this.learningexperience = learningexperience;
	}

	@Override
	public String toString() {
		return "UserInterest [userId=" + userId  + ", Interestcourses="
				+ Interestcourses + ", learningexperience=" + learningexperience + "]";
	}

	
}