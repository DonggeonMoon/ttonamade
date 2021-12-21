package Ttonamade.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import Ttonamade.dto.Product_reviewDto;

@Repository
public class Product_reviewDao {
	@Inject
	private SqlSession ss;

	private static final String NameSpace = "product_ReviewMapper.";

	public void setSs(SqlSession ss) {
		this.ss = ss;
	}

	public void insertOne(Product_reviewDto dto) throws Exception {
		ss.insert(NameSpace + "insertOne", dto);
	}

	public int selectOne(int prod_id, int order_seq) throws Exception {
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("prod_id", prod_id);
		map.put("order_seq", order_seq);

		return ss.selectOne(NameSpace + "selectOne", map);
	}

	public Product_reviewDto selectOneData(int prod_id, int order_seq) throws Exception {
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("prod_id", prod_id);
		map.put("order_seq", order_seq);

		return ss.selectOne(NameSpace + "selectOneData", map);
	}

	public List<Product_reviewDto> selectProdData(int prod_id) throws Exception {
		return ss.selectList(NameSpace + "selectProdData", prod_id);
	}

	public void updateSet(Product_reviewDto dto) throws Exception {
		ss.update(NameSpace + "updateData", dto);
	}

	public void deleteOne(Product_reviewDto dto) throws Exception {
		ss.delete(NameSpace + "deleteOne", dto);
	}

	public void deleteOne(int order_seq, int prod_id) throws Exception {
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("order_seq", order_seq);
		map.put("prod_id", prod_id);

		ss.delete(NameSpace + "deleteReviewOne", map);
	}
}
