package com.ispan.codegym.customerservice.model.bean;

import java.util.LinkedHashSet;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

@Entity
@Table(name = "ReceiptMessageTypes")
public class ReceiptMessageTypes {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id")
	private Integer id;
	
	@Column(name = "type")
	private String type;
	
	@OneToMany(fetch = FetchType.LAZY, mappedBy = "receiptMessageTypes", cascade = CascadeType.ALL)
	private Set<ReceiptMessages> receiptMessages = new LinkedHashSet<ReceiptMessages>();

	public ReceiptMessageTypes() {
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}
	
}
