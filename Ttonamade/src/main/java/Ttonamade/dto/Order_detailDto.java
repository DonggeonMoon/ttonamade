package Ttonamade.dto;

public class Order_detailDto {
	
	private int order_seq; 
    private String order_id;
    private int prod_id; 
    private String prod_name;
    private int prod_price;
    private int order_count;
    
	public Order_detailDto() {
		super();
	}

	public Order_detailDto(int order_seq, String order_id, int prod_id, String prod_name, int prod_price, int order_count) {
		super();
		this.order_seq = order_seq;
		this.order_id = order_id;
		this.prod_id = prod_id;
		this.prod_name = prod_name;
		this.prod_price = prod_price;
		this.order_count = order_count;
	}

	public int getOrder_seq() {
		return order_seq;
	}

	public void setOrder_seq(int order_seq) {
		this.order_seq = order_seq;
	}

	public String getOrder_id() {
		return order_id;
	}

	public void setOrder_id(String order_id) {
		this.order_id = order_id;
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

	public int getOrder_count() {
		return order_count;
	}

	public void setOrder_count(int order_count) {
		this.order_count = order_count;
	}
}
