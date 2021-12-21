package Ttonamade.dto;

import java.util.Date;

public class QnaDto {
	private int qna_id;
	private int child_level;
	private int parent_level;
	private String title;
	private String content;
	private String cust_id;
	private Date writerDate;
	private char privateFlag;
	private String password;
	private String rownum;

	public QnaDto() {
		super();
	}

	public QnaDto(int qna_id, int child_level, int parent_level, String title, String content, String cust_id, Date writerDate, char privateFlag, String password, String content2, String rownum) {
		super();
		this.qna_id = qna_id;
		this.child_level = child_level;
		this.parent_level = parent_level;
		this.title = title;
		this.content = content;
		this.cust_id = cust_id;
		this.writerDate = writerDate;
		this.privateFlag = privateFlag;
		this.password = password;
		this.rownum = rownum;
	}

	public int getQna_id() {
		return qna_id;
	}

	public void setQna_id(int qna_id) {
		this.qna_id = qna_id;
	}

	public int getChild_level() {
		return child_level;
	}

	public void setChild_level(int child_level) {
		this.child_level = child_level;
	}

	public int getParent_level() {
		return parent_level;
	}

	public void setParent_level(int parent_level) {
		this.parent_level = parent_level;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getCust_id() {
		return cust_id;
	}

	public void setCust_id(String cust_id) {
		this.cust_id = cust_id;
	}

	public Date getWriterDate() {
		return writerDate;
	}

	public void setWriterDate(Date writerDate) {
		this.writerDate = writerDate;
	}

	public char getPrivateFlag() {
		return privateFlag;
	}

	public void setPrivateFlag(char privateFlag) {
		this.privateFlag = privateFlag;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getRownum() {
		return rownum;
	}

	public void setRownum(String rownum) {
		this.rownum = rownum;
	}
}
