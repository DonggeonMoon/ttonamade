package Ttonamade.dto;

import java.sql.Date;

import org.springframework.web.multipart.MultipartFile;

public class Product_infoDto {
	
	private int prod_id;
	private String prod_name;
	private int prod_price;
	private float prod_rating;
	private String prod_desc;
	private String prod_imgsrc;
	private int prod_count; 
	private Date prod_date;
	private MultipartFile picture;
	
	public Product_infoDto() {
		super();
	}

	public Product_infoDto(int prod_id, String prod_name, int prod_price, float prod_rating, String prod_desc,
			String prod_imgsrc, int prod_count, Date prod_date, MultipartFile picture) {
		super();
		this.prod_id = prod_id;
		this.prod_name = prod_name;
		this.prod_price = prod_price;
		this.prod_rating = prod_rating;
		this.prod_desc = prod_desc;
		this.prod_imgsrc = prod_imgsrc;
		this.prod_count = prod_count;
		this.prod_date = prod_date;
		this.picture = picture;
	}

	public int getProd_id() {
		return prod_id;
	}

	public void setProd_id(int prod_id) {
		this.prod_id = prod_id;
	}

	public String getProd_name() {
		return prod_name;
	}

	public void setProd_name(String prod_name) {
		this.prod_name = prod_name;
	}

	public int getProd_price() {
		return prod_price;
	}

	public void setProd_price(int prod_price) {
		this.prod_price = prod_price;
	}

	public float getProd_rating() {
		return prod_rating;
	}

	public void setProd_rating(float prod_rating) {
		this.prod_rating = prod_rating;
	}

	public String getProd_desc() {
		return prod_desc;
	}

	public void setProd_desc(String prod_desc) {
		this.prod_desc = prod_desc;
	}

	public String getProd_imgsrc() {
		return prod_imgsrc;
	}

	public void setProd_imgsrc(String prod_imgsrc) {
		this.prod_imgsrc = prod_imgsrc;
	}

	public int getProd_count() {
		return prod_count;
	}

	public void setProd_count(int prod_count) {
		this.prod_count = prod_count;
	}

	public Date getProd_date() {
		return prod_date;
	}

	public void setProd_date(Date prod_date) {
		this.prod_date = prod_date;
	}

	public MultipartFile getPicture() {
		return picture;
	}

	public void setPicture(MultipartFile picture) {
		this.picture = picture;
	}
}
