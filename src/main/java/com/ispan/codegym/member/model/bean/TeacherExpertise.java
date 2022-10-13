package com.ispan.codegym.member.model.bean;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.OneToOne;
import javax.persistence.PrimaryKeyJoinColumn;
import javax.persistence.Table;

@Entity
@Table(name = "TeacherExpertise")
public class TeacherExpertise {
	
	public TeacherExpertise() {
	}

	@Id
    @Column(name="userId")
    private Integer userId;
    
    @OneToOne
    @PrimaryKeyJoinColumn(name="userId", referencedColumnName="id")
    private UserInformation userInformation;
	
	@Column(name = "expertise")
	private String expertise;

	@Column(name = "experience")
	private String experience;

	@Column(name = "teaching")
	private String teaching;
	
	public Integer getUserId() {
		return userId;
	}

	public void setUserId(Integer userId) {
		this.userId = userId;
	}
	
	public UserInformation getUserInformation() {
		return userInformation;
	}

	public void setUserInformation(UserInformation userInformation) {
		this.userInformation = userInformation;
	}

	public String getExpertise() {
		return expertise;
	}

	public void setExpertise(String expertise) {
		this.expertise = expertise;
	}

	public String getExperience() {
		return experience;
	}

	public void setExperience(String experience) {
		this.experience = experience;
	}

	public String getTeaching() {
		return teaching;
	}

	public void setTeaching(String teaching) {
		this.teaching = teaching;
	}

}