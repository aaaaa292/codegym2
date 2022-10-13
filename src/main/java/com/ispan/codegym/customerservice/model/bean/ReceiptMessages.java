package com.ispan.codegym.customerservice.model.bean;

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
import javax.persistence.OneToOne;
import javax.persistence.PrePersist;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;

@Entity
@Table(name = "ReceiptMessages")
public class ReceiptMessages {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id")
	private Integer id;

	@JsonFormat(pattern = "yyyy/MM/dd HH:mm:ss", timezone = "Asia/Taipei") // JSON
	@DateTimeFormat(pattern = "yyyy/MM/dd HH:mm:ss") // SpringMVC
	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "time")
	private Date time;

	@Column(name = "userId")
	private int userId;

	@Column(name = "title")
	private String title;

	@Column(name = "message")
	private String message;

	@Column(name = "status")
	private String status;

	@OneToOne(cascade = CascadeType.ALL)
	@JoinColumn(name = "replyMessagesId")
	private ReplyMessages replyMessages;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "receiptMessageTypeId")
	private ReceiptMessageTypes receiptMessageTypes;

	public ReceiptMessages() {
	}

	@PrePersist // 物件轉換成Persistent狀態以前要執行的方法
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

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public ReplyMessages getReplyMessages() {
		return replyMessages;
	}

	public void setReplyMessages(ReplyMessages replyMessages) {
		this.replyMessages = replyMessages;
	}

	public ReceiptMessageTypes getReceiptMessageTypes() {
		return receiptMessageTypes;
	}

	public void setReceiptMessageTypes(ReceiptMessageTypes receiptMessageTypes) {
		this.receiptMessageTypes = receiptMessageTypes;
	}

}
