package Ttonamade.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import Ttonamade.dto.Cart_infoDto;

@Repository
public class Cart_infoDao {

	@Inject
	SqlSession ss;

	private static final String NameSpace = "cart_infoMapper.";

	public void setSs(SqlSession ss) {
		this.ss = ss;
	}

	public List<Cart_infoDto> selectAll(String cust_id) throws Exception {
		return ss.selectList(NameSpace + "selectAll", cust_id);

	}

	public Cart_infoDto selectOne(int cart_id) throws Exception {

		return ss.selectOne(NameSpace + "selectOne", cart_id);
	}

	public void insertOne(Cart_infoDto dto) throws Exception {
		ss.insert(NameSpace + "insertOne", dto);

	}

	public void updateCart(Cart_infoDto dto) throws Exception {
		ss.update(NameSpace + "updateCart", dto);
	}

	// 선택적으로 지우거나
	public void deleteOne(int cart_id) throws Exception {

		ss.delete(NameSpace + "deleteOne", cart_id);

	}

	// 전부지우거나
	public void deleteAll(String cust_id) throws Exception {
		ss.delete(NameSpace + "deleteAll", cust_id);
	}

	// 주문상품이 중복되는지 여부를 묻는다.
	public int countCart(int prod_id, String cust_id) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("cust_id", cust_id);
		map.put("prod_id", prod_id);

		return ss.selectOne(NameSpace + "countCart", map);
	}

	public int sumMoney(String cust_id) {
		return ss.selectOne(NameSpace + "sumMoney", cust_id);
	}
}
