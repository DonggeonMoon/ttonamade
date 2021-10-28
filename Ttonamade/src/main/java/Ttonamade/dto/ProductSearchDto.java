package Ttonamade.dto;

public class ProductSearchDto {
	private String SearchOption;
	private String keyword;
	private String keyword2;

	public ProductSearchDto() {
		super();
	}

	public ProductSearchDto(String searchOption, String keyword, String keyword2) {
		super();
		SearchOption = searchOption;
		this.keyword = keyword;
		this.keyword2 = keyword2;
	}

	public String getSearchOption() {
		return SearchOption;
	}

	public void setSearchOption(String searchOption) {
		SearchOption = searchOption;
	}

	public String getKeyword() {
		return keyword;
	}

	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}

	public String getKeyword2() {
		return keyword2;
	}

	public void setKeyword2(String keyword2) {
		this.keyword2 = keyword2;
	}
}
