package Ttonamade.dto;

public class Category_Dto {
	private String cateName;
	private String cateCode;
	private String cateCodeRef;
	private int level;

	public Category_Dto() {
		super();

	}

	public Category_Dto(String cateName, String cateCode, String cateCodeRef, int level) {
		super();
		this.cateName = cateName;
		this.cateCode = cateCode;
		this.cateCodeRef = cateCodeRef;
		this.level = level;
	}

	public String getCateName() {
		return cateName;
	}

	public void setCateName(String cateName) {
		this.cateName = cateName;
	}

	public String getCateCode() {
		return cateCode;
	}

	public void setCateCode(String cateCode) {
		this.cateCode = cateCode;
	}

	public String getCateCodeRef() {
		return cateCodeRef;
	}

	public void setCateCodeRef(String cateCodeRef) {
		this.cateCodeRef = cateCodeRef;
	}

	public int getLevel() {
		return level;
	}

	public void setLevel(int level) {
		this.level = level;
	}
}
