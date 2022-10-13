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

@Entity
@Table(name="CourseDetails")
public class CourseDetails {
	
	public CourseDetails() {
	}
	
	public CourseDetails(CourseChapters courseChapter, int section, String name, String videoPath) {
		super();
		this.courseChapter = courseChapter;
		this.section = section;
		this.name = name;
		this.videoPath = videoPath;
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
	
	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "courseChapterId")
	private CourseChapters courseChapter;
	
	@Column(name = "section")
	private int section;
	
	@Column(name = "name")
	private String name;
	
	@Column(name = "videoPath")
	private String videoPath;
	
	@Column(name = "status")
	private int status;
	
	@OneToMany(fetch = FetchType.LAZY, mappedBy = "courseDetail", cascade = CascadeType.ALL)
	private Set<UserFavoriteCourses> userFavoriteCourses = new LinkedHashSet<UserFavoriteCourses>();
	
	@OneToMany(fetch = FetchType.LAZY, mappedBy = "courseDetail", cascade = CascadeType.ALL)
	private Set<UserCourseProgressRate> userCourseProgressRate = new LinkedHashSet<UserCourseProgressRate>();
	
	@OneToMany(fetch = FetchType.LAZY, mappedBy = "courseDetail", cascade = CascadeType.ALL)
	private Set<UserCourseViews> userCourseViews = new LinkedHashSet<UserCourseViews>();
	
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

	public CourseChapters getCourseChapter() {
		return courseChapter;
	}

	public void setCourseChapter(CourseChapters courseChapter) {
		this.courseChapter = courseChapter;
	}

	public int getSection() {
		return section;
	}

	public void setSection(int section) {
		this.section = section;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getVideoPath() {
		return videoPath;
	}

	public void setVideoPath(String videoPath) {
		this.videoPath = videoPath;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public Set<UserFavoriteCourses> getUserFavoriteCourses() {
		return userFavoriteCourses;
	}

	public void setUserFavoriteCourses(Set<UserFavoriteCourses> userFavoriteCourses) {
		this.userFavoriteCourses = userFavoriteCourses;
	}

	public Set<UserCourseProgressRate> getUserCourseProgressRate() {
		return userCourseProgressRate;
	}

	public void setUserCourseProgressRate(Set<UserCourseProgressRate> userCourseProgressRate) {
		this.userCourseProgressRate = userCourseProgressRate;
	}

	public Set<UserCourseViews> getUserCourseViews() {
		return userCourseViews;
	}

	public void setUserCourseViews(Set<UserCourseViews> userCourseViews) {
		this.userCourseViews = userCourseViews;
	}
	
}
