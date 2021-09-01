package Ttonamade.dto;

import java.util.Date;

public class Product_infoDto {
	
	private String prod_id;
	private int prod_price;
	private int prod_rating;
	private String prod_desc;
	private int prod_count; 
	private Date prod_date;
	
	public Product_infoDto() {
		super();
	}

	public Product_infoDto(String prod_id, int prod_price, int prod_rating, String prod_desc, int prod_count,
			Date prod_date) {
		super();
		this.prod_id = prod_id;
		this.prod_price = prod_price;
		this.prod_rating = prod_rating;
		this.prod_desc = prod_desc;
		this.prod_count = prod_count;
		this.prod_date = prod_date;
	}

	public String getProd_id() {
		return prod_id;
	}

	public void setProd_id(String prod_id) {
		this.prod_id = prod_id;
	}

	public int getProd_price() {
		return prod_price;
	}

	public void setProd_price(int prod_price) {
		this.prod_price = prod_price;
	}

	public int getProd_rating() {
		return prod_rating;
	}

	public void setProd_rating(int prod_rating) {
		this.prod_rating = prod_rating;
	}

	public String getProd_desc() {
		return prod_desc;
	}

	public void setProd_desc(String prod_desc) {
		this.prod_desc = prod_desc;
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
}
