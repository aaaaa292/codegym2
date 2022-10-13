package com.ispan.codegym.learning.model.bean;

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
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
@Table(name="CourseChapters")
public class CourseChapters {
	
	public CourseChapters() {
	}

	public CourseChapters(CourseProfiles courseProfile, String name) {
		super();
		this.courseProfile = courseProfile;
		this.name = name;
	}
	
	public CourseChapters(CourseProfiles courseProfile, int number, String name) {
		super();
		this.courseProfile = courseProfile;
		this.number = number;
		this.name = name;
	}

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name="id")
	private Long id;
	
	@JsonIgnore
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "courseId")
	private CourseProfiles courseProfile;

	@Column(name = "number")
	private int number;
	
	@Column(name = "name")
	private String name;
	
	@JsonIgnore
	@OneToMany(fetch = FetchType.LAZY, mappedBy = "courseChapter", cascade = CascadeType.ALL)
	private Set<CourseDetails> courseDetails = new LinkedHashSet<CourseDetails>();
	
	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public CourseProfiles getCourseProfile() {
		return courseProfile;
	}

	public void setCourseProfile(CourseProfiles courseProfile) {
		this.courseProfile = courseProfile;
	}
	
	public int getNumber() {
		return number;
	}

	public void setNumber(int number) {
		this.number = number;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Set<CourseDetails> getCourseDetails() {
		return courseDetails;
	}

	public void setCourseDetails(Set<CourseDetails> courseDetails) {
		this.courseDetails = courseDetails;
	}
}
