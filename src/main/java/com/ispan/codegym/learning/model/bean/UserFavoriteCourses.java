package com.ispan.codegym.learning.model.bean;

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
@Table(name="UserFavoriteCourses")
public class UserFavoriteCourses {
	
	public UserFavoriteCourses() {
	}

	public UserFavoriteCourses(UserInformation userInformation, CourseDetails courseDetail) {
		super();
		this.userInformation = userInformation;
		this.courseDetail = courseDetail;
	}

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name="id")
	private int id;
	
	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "userId")
	private UserInformation userInformation;
	
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "courseDetailId")
	private CourseDetails courseDetail;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public UserInformation getUserInformation() {
		return userInformation;
	}

	public void setUserInformation(UserInformation userInformation) {
		this.userInformation = userInformation;
	}

	public CourseDetails getCourseDetail() {
		return courseDetail;
	}

	public void setCourseDetail(CourseDetails courseDetail) {
		this.courseDetail = courseDetail;
	}
	

}
