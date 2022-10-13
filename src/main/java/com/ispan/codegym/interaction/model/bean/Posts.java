package com.ispan.codegym.interaction.model.bean;

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
import javax.persistence.Lob;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.PrePersist;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.springframework.format.annotation.DateTimeFormat;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.ispan.codegym.member.model.bean.UserInformation;

@Entity
@Table(name = "Posts")
public class Posts {

	public Posts() {
	}

	public Posts(UserInformation userInformation, String title, String postContent) {
		super();
		this.userInformation = userInformation;
		this.title = title;
		this.postContent = postContent;
//		this.photo = photo;
	}

	public Posts(UserInformation userInformation, String title, String postContent, String imgPath) {
		super();
		this.userInformation = userInformation;
		this.title = title;
		this.postContent = postContent;
		this.imgPath = imgPath;
	}

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id")
	private Integer id;

	@JsonFormat(pattern = "yyyy/MM/dd HH:mm:ss", timezone = "GMT+8") // JSON
	@DateTimeFormat(pattern = "yyyy/MM/dd HH:mm:ss") // SpringMVC
	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "time")
	private Date time;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "userId")
	private UserInformation userInformation;

	@Column(name = "title")
	private String title;

	@Column(name = "postContent", columnDefinition = "NVARCHAR(MAX)")
	private String postContent;

	@Column(name = "likeCount")
	private Integer likeCount;

	@Column(name = "imgPath")
	private String imgPath;

//	@Lob // 跟 Hibernate 說明是 Large Object 的檔案
//	@Column(name = "photo")
//	private byte[] photo;

	@OneToMany(mappedBy = "posts", fetch = FetchType.LAZY, cascade = CascadeType.ALL)
	private Set<PostComments> postComments = new LinkedHashSet<PostComments>();

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "posts", cascade = CascadeType.ALL)
	private Set<PostTags> postTags = new LinkedHashSet<PostTags>();

	@PrePersist // 物件轉換成 Persistent 狀態以前要執行的方法
	public void onCreate() {
		if (time == null) {
			time = new Date();
		}
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
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

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getPostContent() {
		return postContent;
	}

	public void setPostContent(String postContent) {
		this.postContent = postContent;
	}

	public Integer getLikeCount() {
		return likeCount;
	}

	public void setLikeCount(Integer likeCount) {
		this.likeCount = likeCount;
	}

//	public byte[] getPhoto() {
//		return photo;
//	}
//
//	public void setPhoto(byte[] photo) {
//		this.photo = photo;
//	}

	public Set<PostComments> getPostComments() {
		return postComments;
	}

	public void setPostComments(Set<PostComments> postComments) {
		this.postComments = postComments;
	}

	public Set<PostTags> getPostTags() {
		return postTags;
	}

	public void setPostTags(Set<PostTags> postTags) {
		this.postTags = postTags;
	}

	public String getImgPath() {
		return imgPath;
	}

	public void setImgPath(String imgPath) {
		this.imgPath = imgPath;
	}

}
