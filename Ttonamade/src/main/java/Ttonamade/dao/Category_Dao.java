package Ttonamade.dao;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import Ttonamade.dto.Category_Dto;

@Repository
public class Category_Dao {
	@Inject
	SqlSession ss;

	private static final String NameSpace = "category_Mapper.";

	public void setSs(SqlSession ss) {
		this.ss = ss;
	}

	public List<Category_Dto> selectAll() throws Exception {
		return ss.selectList(NameSpace + "selectAll");
	}

	public Category_Dto selectOne() throws Exception {
		return ss.selectOne(NameSpace + "selectOne");
	}
}
