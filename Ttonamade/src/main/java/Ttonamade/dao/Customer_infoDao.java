package Ttonamade.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import Ttonamade.dto.Customer_infoDto;

@Repository
public class Customer_infoDao {

	@Inject
	SqlSession ss;

	private static final String NameSpace = "customer_infoMapper.";

	public void setSs(SqlSession ss) {
		this.ss = ss;
	}

	public List<Customer_infoDto> selectAll(String cust_id) throws Exception {
		return ss.selectList(NameSpace + "selectAll", cust_id);
	}

	public Customer_infoDto selectOne(String cust_id) throws Exception {
		return ss.selectOne(NameSpace + "selectOne", cust_id);
	}

	public Customer_infoDto selectOneByNTB(HashMap<String, Object> map) {
		return ss.selectOne(NameSpace + "selectOneByNTB", map);
	}

	public Customer_infoDto selectOneByNTBI(HashMap<String, Object> map) {
		return ss.selectOne(NameSpace + "selectOneByNTBI", map);
	}

	public void insertOne(Customer_infoDto custDto) throws Exception {
		ss.insert(NameSpace + "insertOne", custDto);
	}

	public void updateOne(Customer_infoDto custDto) throws Exception {
		ss.update(NameSpace + "updateOne", custDto);
	}

	public void updateOne(String cust_id, String cust_manager) throws Exception {
		Map<String, String> map = new HashMap<String, String>();
		map.put("cust_id", cust_id);
		map.put("cust_manager", cust_manager);

		ss.update(NameSpace + "updateRankOne", map);
	}

	public void deleteOne(String cust_id) throws Exception {
		ss.delete(NameSpace + "deleteOne", cust_id);
	}
}
