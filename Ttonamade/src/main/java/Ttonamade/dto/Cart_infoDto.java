package Ttonamade.dto;

public class Cart_infoDto {
	
	private int cart_id ;
	private int cust_id ; ;
	private int prod_id;
	private int prod_name ;
	private int prod_count;
	private int prod_price ;
	public int getCart_id() {
		return cart_id;
	}
	
	
	public Cart_infoDto() {
		super();
		// TODO Auto-generated constructor stub
	}


	public Cart_infoDto(int cart_id, int cust_id, int prod_id, int prod_name, int prod_count, int prod_price) {
		super();
		this.cart_id = cart_id;
		this.cust_id = cust_id;
		this.prod_id = prod_id;
		this.prod_name = prod_name;
		this.prod_count = prod_count;
		this.prod_price = prod_price;
	}


	public void setCart_id(int cart_id) {
		this.cart_id = cart_id;
	}
	public int getCust_id() {
		return cust_id;
	}
	public void setCust_id(int cust_id) {
		this.cust_id = cust_id;
	}
	public int getProd_id() {
		return prod_id;
	}
	public void setProd_id(int prod_id) {
		this.prod_id = prod_id;
	}
	public int getProd_name() {
		return prod_name;
	}
	public void setProd_name(int prod_name) {
		this.prod_name = prod_name;
	}
	public int getProd_count() {
		return prod_count;
	}
	public void setProd_count(int prod_count) {
		this.prod_count = prod_count;
	}
	public int getProd_price() {
		return prod_price;
	}
	public void setProd_price(int prod_price) {
		this.prod_price = prod_price;
	}
	
	
	 

}
