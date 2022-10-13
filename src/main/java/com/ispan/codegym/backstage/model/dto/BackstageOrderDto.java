package com.ispan.codegym.backstage.model.dto;

public class BackstageOrderDto {
	
	public BackstageOrderDto(){
		
	}
	
	public BackstageOrderDto(String courseProfileName, int totalPrice) {
		super();
		this.courseProfileName = courseProfileName;
		this.totalPrice = totalPrice;
	}

	private String courseProfileName;
	
	private int totalPrice;

	public String getCourseProfileName() {
		return courseProfileName;
	}

	public void setCourseProfileName(String courseProfileName) {
		this.courseProfileName = courseProfileName;
	}

	public int getTotalPrice() {
		return totalPrice;
	}

	public void setTotalPrice(int totalPrice) {
		this.totalPrice = totalPrice;
	}
	
	
}
