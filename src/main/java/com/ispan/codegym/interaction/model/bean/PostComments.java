package com.ispan.codegym.interaction.model.bean;

import java.util.Date;

import javax.persistence.CascadeType;
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
import javax.persistence.Transient;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.ispan.codegym.member.model.bean.UserInformation;

@Entity
@Table(name = "PostComments")
public class PostComments {
	
	public PostComments() {
	}
	
	
	
	public PostComments(Integer id, Date time, UserInformation userInformation, String comment,
			Integer likeCount, Posts posts) {
		super();
		this.id = id;
		this.time = time;
		this.userInformation = userInformation;
		this.comment = comment;
		this.likeCount = likeCount;
		this.posts = posts;
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
	
	@Column(name = "comment")
	private String comment;
	
	@Column(name = "likeCount")
	private Integer likeCount;
	
//	@JsonBackReference
//	@ManyToOne(fetch = FetchType.EAGER, cascade = CascadeType.ALL)
//	@JoinColumn(name = "fk_post_id", referencedColumnName = "id")
//	private Posts post;
	
	@ManyToOne(fetch = FetchType.LAZY,cascade=CascadeType.MERGE)
    @JoinColumn(name="post_id")
	private Posts posts;
	
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

	public String getComment() {
		return comment;
	}

	public void setComment(String comment) {
		this.comment = comment;
	}

	public Integer getLikeCount() {
		return likeCount;
	}

	public void setLikeCount(Integer likeCount) {
		this.likeCount = likeCount;
	}

	public Posts getPost() {
		return posts;
	}

	public void setPost(Posts post) {
		this.posts = post;
	}

	public Posts getPosts() {
		return posts;
	}

	public void setPosts(Posts posts) {
		this.posts = posts;
	}

	public UserInformation getUserInformation() {
		return userInformation;
	}

	public void setUserInformation(UserInformation userInformation) {
		this.userInformation = userInformation;
	}
	
	
	
}
