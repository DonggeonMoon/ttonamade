package Ttonamade.dto;

import java.util.Date;

import org.springframework.web.multipart.MultipartFile;

public class Product_reviewDto {
	private String order_seq;
	private String prod_id;
	private String cust_id;
	private String prod_review;
	private int prod_rating;
	private String review_imgsrc;
	private Date review_date;
	private MultipartFile picture;

	public Product_reviewDto() {
		super();
	}

	public Product_reviewDto(String order_seq, String prod_id, String cust_id, String prod_review, int prod_rating, String review_imgsrc, Date review_date, MultipartFile picture) {
		super();
		this.order_seq = order_seq;
		this.prod_id = prod_id;
		this.cust_id = cust_id;
		this.prod_review = prod_review;
		this.prod_rating = prod_rating;
		this.review_imgsrc = review_imgsrc;
		this.review_date = review_date;
		this.picture = picture;
	}

	public String getOrder_seq() {
		return order_seq;
	}

	public void setOrder_seq(String order_seq) {
		this.order_seq = order_seq;
	}

	public String getProd_id() {
		return prod_id;
	}

	public void setProd_id(String prod_id) {
		this.prod_id = prod_id;
	}

	public String getCust_id() {
		return cust_id;
	}

	public void setCust_id(String cust_id) {
		this.cust_id = cust_id;
	}

	public String getProd_review() {
		return prod_review;
	}

	public void setProd_review(String prod_review) {
		this.prod_review = prod_review;
	}

	public int getProd_rating() {
		return prod_rating;
	}

	public void setProd_rating(int prod_rating) {
		this.prod_rating = prod_rating;
	}

	public String getReview_imgsrc() {
		return review_imgsrc;
	}

	public void setReview_imgsrc(String review_imgsrc) {
		this.review_imgsrc = review_imgsrc;
	}

	public Date getReview_date() {
		return review_date;
	}

	public void setReview_date(Date review_date) {
		this.review_date = review_date;
	}

	public MultipartFile getPicture() {
		return picture;
	}

	public void setPicture(MultipartFile picture) {
		this.picture = picture;
	}
}
