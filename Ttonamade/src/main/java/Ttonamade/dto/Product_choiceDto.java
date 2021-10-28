package Ttonamade.dto;

public class Product_choiceDto {
	private String cust_id;
	private int prod_id;

	public Product_choiceDto() {
		super();
	}

	public Product_choiceDto(String cust_id, int prod_id) {
		super();
		this.cust_id = cust_id;
		this.prod_id = prod_id;
	}

	public String getCust_id() {
		return cust_id;
	}

	public void setCust_id(String cust_id) {
		this.cust_id = cust_id;
	}

	public int getProd_id() {
		return prod_id;
	}

	public void setProd_id(int prod_id) {
		this.prod_id = prod_id;
	}
}
