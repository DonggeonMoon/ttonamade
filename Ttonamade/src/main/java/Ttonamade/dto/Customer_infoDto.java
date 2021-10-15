package Ttonamade.dto;

import java.sql.Date;

public class Customer_infoDto {

	private String cust_id;
	private String cust_name;
	private String cust_password;
	private char cust_sex;
	private String cust_birthday;
	private String cust_telephone;
	private char cust_manager;
	private Date cust_date;

	public Customer_infoDto() {
		super();
	}

	public Customer_infoDto(String cust_id, String cust_name, String cust_password, char cust_sex, String cust_birthday, String cust_telephone, char cust_manager, Date cust_date) {
		super();
		this.cust_id = cust_id;
		this.cust_name = cust_name;
		this.cust_password = cust_password;
		this.cust_sex = cust_sex;
		this.cust_birthday = cust_birthday;
		this.cust_telephone = cust_telephone;
		this.cust_manager = cust_manager;
		this.cust_date = cust_date;
	}

	public String getCust_id() {
		return cust_id;
	}

	public void setCust_id(String cust_id) {
		this.cust_id = cust_id;
	}

	public String getCust_name() {
		return cust_name;
	}

	public void setCust_name(String cust_name) {
		this.cust_name = cust_name;
	}

	public String getCust_password() {
		return cust_password;
	}

	public void setCust_password(String cust_password) {
		this.cust_password = cust_password;
	}

	public char getCust_sex() {
		return cust_sex;
	}

	public void setCust_sex(char cust_sex) {
		this.cust_sex = cust_sex;
	}

	public String getCust_birthday() {
		return cust_birthday;
	}

	public void setCust_birthday(String cust_birthday) {
		this.cust_birthday = cust_birthday;
	}

	public String getCust_telephone() {
		return cust_telephone;
	}

	public void setCust_telephone(String cust_telephone) {
		this.cust_telephone = cust_telephone;
	}

	public char getCust_manager() {
		return cust_manager;
	}

	public void setCust_manager(char cust_manager) {
		this.cust_manager = cust_manager;
	}

	public Date getCust_date() {
		return cust_date;
	}

	public void setCust_date(Date cust_date) {
		this.cust_date = cust_date;
	}
}
