package com.ispan.codegym.learning.model.bean;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.PrePersist;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.ispan.codegym.member.model.bean.UserInformation;

@Entity
@Table(name="UserCourseViews")
public class UserCourseViews {
	
	public UserCourseViews() {
	}

	public UserCourseViews(UserInformation userInformation, CourseDetails courseDetail) {
		super();
		this.userInformation = userInformation;
		this.courseDetail = courseDetail;
	}

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name="id")
	private int id;
	
	@JsonFormat(pattern = "yyyy/MM/dd HH:mm:ss") // JSON
	@DateTimeFormat(pattern = "yyyy/MM/dd HH:mm:ss") // SpringMVC
	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "time")
	private Date time;
	
	@PrePersist // 物件轉換成 Persistent 狀態以前要執行的方法
	public void onCreate() {
		if (time == null) {
			time = new Date();
		}
	}
	
	@ManyToOne(fetch = FetchType.LAZY)
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
	
	public Date getTime() {
		return time;
	}

	public void setTime(Date time) {
		this.time = time;
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
