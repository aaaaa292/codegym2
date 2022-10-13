package com.ispan.codegym.member.model.bean;

import java.util.Arrays;
import java.util.LinkedHashSet;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Lob;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import com.ispan.codegym.interaction.model.bean.PostComments;
import com.ispan.codegym.interaction.model.bean.Posts;
import com.ispan.codegym.learning.model.bean.CourseComments;
import com.ispan.codegym.learning.model.bean.CourseProfiles;
import com.ispan.codegym.learning.model.bean.UserFavoriteCourses;
import com.ispan.codegym.order.model.bean.Orders;
import com.ispan.codegym.customerservice.model.bean.QuestionScore;

@Entity
@Table(name = "UserInformation")
public class UserInformation {

	public UserInformation() {
		super();
	}

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id")
	private Integer id;

	@Column(name = "email")
	private String email;

	@Column(name = "password")
	private String password;

	@Column(name = "name")
	private String name;

	@Column(name = "phone")
	private String phone;

	@Column(name = "birthday")
	private String birthday;

	@Column(name = "gender")
	private String gender;

	@Column(name = "role")
	private Integer role;

	@Lob // 跟 Hibernate 說明是 Large Object 的檔案
	@Column(name = "photo")
	private byte[] photo;

	@Column(name = "base64Photo", columnDefinition = "nvarchar(max)")
	private String base64Photo;

	@Column(name = "verification")
	private String verification;

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "userInformation", cascade = CascadeType.ALL)
	private Set<CourseProfiles> courseProfiles = new LinkedHashSet<CourseProfiles>();

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "userInformation", cascade = CascadeType.ALL)
	private Set<CourseComments> courseComments = new LinkedHashSet<CourseComments>();

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "userInformation", cascade = CascadeType.ALL)
	private Set<UserFavoriteCourses> userFavoriteCourses = new LinkedHashSet<UserFavoriteCourses>();
	
	@OneToMany(fetch = FetchType.LAZY, mappedBy = "userInformation", cascade = CascadeType.ALL)
	private Set<Orders> orders = new LinkedHashSet<Orders>();
	
	@OneToMany(fetch = FetchType.LAZY, mappedBy = "userInformation", cascade = CascadeType.ALL)
	private Set<Posts> posts = new LinkedHashSet<Posts>();

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "userInformation", cascade = CascadeType.ALL)
	private Set<PostComments> postComments = new LinkedHashSet<PostComments>();
	
	@OneToMany(fetch = FetchType.LAZY, mappedBy = "userInformation", cascade = CascadeType.ALL)
	private Set<QuestionScore> questionScore = new LinkedHashSet<QuestionScore>();

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getBirthday() {
		return birthday;
	}

	public void setBirthday(String birthday) {
		this.birthday = birthday;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public Integer getRole() {
		return role;
	}

	public void setRole(Integer role) {
		this.role = role;
	}

	public byte[] getPhoto() {
		return photo;
	}

	public void setPhoto(byte[] photo) {
		this.photo = photo;
	}

	public String getBase64Photo() {
		return base64Photo;
	}

	public void setBase64Photo(String base64Photo) {
		this.base64Photo = base64Photo;
	}

	public String getVerification() {
		return verification;
	}

	public void setVerification(String verification) {
		this.verification = verification;
	}

	public Set<CourseProfiles> getCourseProfiles() {
		return courseProfiles;
	}

	public void setCourseProfiles(Set<CourseProfiles> courseProfiles) {
		this.courseProfiles = courseProfiles;
	}

	public Set<UserFavoriteCourses> getUserFavoriteCourses() {
		return userFavoriteCourses;
	}

	public void setUserFavoriteCourses(Set<UserFavoriteCourses> userFavoriteCourses) {
		this.userFavoriteCourses = userFavoriteCourses;
	}

	@Override
	public String toString() {
		return "UserInformation [id=" + id + ", email=" + email + ", password=" + password + ", name=" + name
				+ ", phone=" + phone + ", birthday=" + birthday + ", gender=" + gender + ", role=" + role + ", photo="
				+ Arrays.toString(photo) + ", verification=" + verification + ", courseProfiles=" + courseProfiles
				+ "]";
	}

}