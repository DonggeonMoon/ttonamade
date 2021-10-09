package Ttonamade.dto;

import java.sql.Date;
import java.util.Optional;

public class Order_infoDto {
	
	private String order_id;
	private String cust_id;
	private int order_totalAmount;
	private Date order_date;
	private String order_zipcode;
	private String order_add1;
	private String order_add2;
	private String order_telephone;
	private char order_status;
	private Date reservation_date;
	private Date  send_date;
	private String reservation_memo;
	
	
	
	public Order_infoDto(String order_id, String cust_id, int order_totalAmount, Date order_date, String order_zipcode,
			String order_add1, String order_add2, String order_telephone, char order_status, Date reservation_date,
			Date send_date, String reservation_memo) {
		super();
		this.order_id = order_id;
		this.cust_id = cust_id;
		this.order_totalAmount = order_totalAmount;
		this.order_date = order_date;
		this.order_zipcode = order_zipcode;
		this.order_add1 = order_add1;
		this.order_add2 = order_add2;
		this.order_telephone = order_telephone;
		this.order_status = order_status;
		this.reservation_date = reservation_date;
		this.send_date = send_date;
		this.reservation_memo = reservation_memo;
	}
	public Order_infoDto() {
		super();
		// TODO Auto-generated constructor stub
	}
	public String getOrder_id() {
		return order_id;
	}
	public void setOrder_id(String order_id) {
		this.order_id = order_id;
	}
	public String getCust_id() {
		return cust_id;
	}
	public void setCust_id(String cust_id) {
		this.cust_id = cust_id;
	}
	public int getOrder_totalAmount() {
		return order_totalAmount;
	}
	public void setOrder_totalAmount(int order_totalAmount) {
		this.order_totalAmount = order_totalAmount;
	}
	public Date getOrder_date() {
		return order_date;
	}
	public void setOrder_date(Date order_date) {
		this.order_date = order_date;
	}
	public String getOrder_zipcode() {
		return order_zipcode;
	}
	public void setOrder_zipcode(String order_zipcode) {
		this.order_zipcode = order_zipcode;
	}
	public String getOrder_add1() {
		return order_add1;
	}
	public void setOrder_add1(String order_add1) {
		this.order_add1 = order_add1;
	}
	public String getOrder_add2() {
		return order_add2;
	}
	public void setOrder_add2(String order_add2) {
		this.order_add2 = order_add2;
	}
	public String getOrder_telephone() {
		return order_telephone;
	}
	public void setOrder_telephone(String order_telephone) {
		this.order_telephone = order_telephone;
	}
	public char getOrder_status() {
		return order_status;
	}
	public void setOrder_status(char order_status) {
		this.order_status = order_status;
	}
	public Date getReservation_date() {
		return reservation_date;
	}
	public void setReservation_date(Date reservation_date) {
		this.reservation_date = reservation_date;
	}
	public Date getSend_date() {
		return send_date;
	}
	public void setSend_date(Date send_date) {
		this.send_date = send_date;
	}
	public String getReservation_memo() {
		return reservation_memo;
	}
	public void setReservation_memo(String reservation_memo) {
		this.reservation_memo = reservation_memo;
	}
 
	
	
	
	
}
