package com.inherit.part01_inherit.model.vo;

import java.util.Date;


public class Product {

	private String brand;				//제조사
	private String productNumber;		//상품번호
	private String productCode;  		//상품코드
	private String productName;  		//상품명
	private int price;  				//가격
	private Date date;  				//제조일자(java.util)
	
	
	//기본생성자
	public Product() {}
	
	//매개변수 생성자
	public Product(String brand,String productNumber,String productCode,String productName,int price,Date date) {
		this.brand = brand;
		this.productNumber = productNumber;
		this.productCode = productCode;
		this.productName = productName;
		this.price = price;
		this.date =date;
	}

	//getter & setter
	public String getBrand() {
		return brand;
	}

	public void setBrand(String brand) {
		this.brand = brand;
	}

	
	
	public String getProductNumber() {
		return productNumber;
	}

	public void setProductNumber(String productNumber) {
		this.productNumber = productNumber;
	}

	
	
	public String getProductCode() {
		return productCode;
	}

	public void setProductCode(String productCode) {
		this.productCode = productCode;
	}

	
	
	public String getProductName() {
		return productName;
	}

	public void setProductName(String productName) {
		this.productName = productName;
	}

	
	
	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	
	
	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
	}
	


	public String prnInfo() {
		return brand+", "+productNumber+", "+productCode+", "
				+productName+", "+price+", "+date;
	
	}
	
	
}
