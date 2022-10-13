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

@Entity
@Table(name="CourseTags")
public class CourseTags {
	
	public CourseTags() {
	}
	
	public CourseTags(CourseProfiles courseProfile, String tag) {
		this.courseProfile = courseProfile;
		this.tag = tag;
	}

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name="id")
	private Long id;
	
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "courseId")
	private CourseProfiles courseProfile;
	
	@Column(name = "tag")
	private String tag;
	
	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public CourseProfiles getCourseProfiles() {
		return courseProfile;
	}

	public void setCourseProfiles(CourseProfiles courseProfile) {
		this.courseProfile = courseProfile;
	}

	public String getTag() {
		return tag;
	}

	public void setTag(String tag) {
		this.tag = tag;
	}
	
}
