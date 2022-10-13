package com.ispan.codegym.learning.model.bean;

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
import com.ispan.codegym.member.model.bean.UserInformation;
import com.ispan.codegym.order.model.bean.OrderItems;

@Entity
@Table(name="CourseProfiles")
public class CourseProfiles {
	
	public CourseProfiles() {
	}
	
	public CourseProfiles(int userId, String name, int price, String introduction, String photoPath) {
		UserInformation userInformation = new UserInformation();
		userInformation.setId(userId);
		this.userInformation = userInformation;
		this.name = name;
		this.price = price;
		this.introduction = introduction;
		this.photoPath = photoPath;
	}

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name="id")
	private Long id;
	
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
	
	@Column(name = "name")
	private String name;
	
	@Column(name = "price")
	private int price;
	
	@Column(name = "introduction", columnDefinition = "nvarchar(max)")
	private String introduction;
	
	@Column(name = "photoPath")
	private String photoPath;
	
	@Column(name = "status")
	private int status;
	
	@OneToMany(fetch = FetchType.LAZY, mappedBy = "courseProfile", cascade = CascadeType.ALL)
	private Set<CourseTags> courseTags = new LinkedHashSet<CourseTags>();
	
	@OneToMany(fetch = FetchType.LAZY, mappedBy = "courseProfile", cascade = CascadeType.ALL)
	private Set<CourseChapters> courseChapters = new LinkedHashSet<CourseChapters>();
	
	@OneToMany(fetch = FetchType.LAZY, mappedBy = "courseProfile", cascade = CascadeType.ALL)
	private Set<CourseComments> courseComments = new LinkedHashSet<CourseComments>();
	
	@OneToMany(fetch = FetchType.LAZY, mappedBy = "courseProfile", cascade = CascadeType.ALL)
	private Set<CourseScores> courseScores = new LinkedHashSet<CourseScores>();
	
	@OneToMany(fetch = FetchType.LAZY, mappedBy = "courseProfile", cascade = CascadeType.ALL)
	private Set<OrderItems> orderItems = new LinkedHashSet<OrderItems>();
	
	public Long getId() {
		return id;
	}

	public void setId(Long id) {
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

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getPrice() {
		return price;
	}
	
	public String getIntroduction() {
		return introduction;
	}

	public void setIntroduction(String introduction) {
		this.introduction = introduction;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public String getPhotoPath() {
		return photoPath;
	}

	public void setPhotoPath(String photoPath) {
		this.photoPath = photoPath;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public Set<CourseTags> getCourseTags() {
		return courseTags;
	}

	public void setCourseTags(Set<CourseTags> courseTags) {
		this.courseTags = courseTags;
	}
	
	public Set<CourseChapters> getCourseChapters() {
		return courseChapters;
	}

	public void setCourseChapters(Set<CourseChapters> courseChapters) {
		this.courseChapters = courseChapters;
	}

	public Set<CourseComments> getCourseComments() {
		return courseComments;
	}

	public void setCourseComments(Set<CourseComments> courseComments) {
		this.courseComments = courseComments;
	}
	
	public Set<CourseScores> getCourseScores() {
		return courseScores;
	}

	public void setCourseScores(Set<CourseScores> courseScores) {
		this.courseScores = courseScores;
	}

	public Set<OrderItems> getOrderItems() {
		return orderItems;
	}

	public void setOrderItems(Set<OrderItems> orderItems) {
		this.orderItems = orderItems;
	}
	
}
