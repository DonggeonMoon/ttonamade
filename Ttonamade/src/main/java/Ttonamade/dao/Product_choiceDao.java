package Ttonamade.dao;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import Ttonamade.dto.Product_choiceDto;

@Repository
public class Product_choiceDao {
	@Inject
	SqlSession ss;

	private static final String NameSpace = "product_choiceMapper.";

	public void setSs(SqlSession ss) {
		this.ss = ss;
	}

	public List<Product_choiceDto> selectAll(String cust_id) throws Exception {
		return ss.selectList(NameSpace + "selectAll", cust_id);
	}

	public Product_choiceDto selectOne(String cust_id) throws Exception {
		return ss.selectOne(NameSpace + "selectOne", cust_id);
	}

	public int insertOne(Product_choiceDto dto) throws Exception {
		return ss.insert(NameSpace + "insertOne", dto);
	}

	public int deleteOne(Product_choiceDto dto) throws Exception {
		return ss.delete(NameSpace + "deleteOne", dto);
	}

	public int deleteAll(String cust_id) throws Exception {
		return ss.delete(NameSpace + "deleteAll", cust_id);
	}
}
