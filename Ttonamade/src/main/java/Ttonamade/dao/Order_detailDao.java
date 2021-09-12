package Ttonamade.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import Ttonamade.dto.Order_detailDto; 

@Repository
public class Order_detailDao {
	
	@Inject
	SqlSession ss;
	
	private static final String NameSpace = "order_detailMapper.";
	
	public void setSs(SqlSession ss) {
		this.ss = ss;
	}
	
	public List<Order_detailDto> selectAll(String order_id) throws Exception {
		return ss.selectList(NameSpace +"selectAll", order_id);
	}
	
	public Order_detailDto selectOne(String order_id) throws Exception {	
		return ss.selectOne(NameSpace + "selectOne", order_id);
	}
	
	public int selectOne(int prod_id) throws Exception{
		
		return ss.selectOne(NameSpace + "prodSelectCount", prod_id);
	}
	
	public void deleteOne(int prod_id) throws Exception {
		ss.delete(NameSpace + "deleteOne", prod_id);
	} 
	
	public void insertOne(Order_detailDto odDto) throws Exception {
		ss.insert(NameSpace + "insertOne", odDto);
	}
	 
	
	public void updateOne(Order_detailDto odDto) throws Exception {
		ss.update(NameSpace + "updateOne", odDto);
	}
	
	public void insertOne(String order_id, String cust_id ) throws Exception{
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("cust_id", cust_id);
		map.put("order_id", order_id);
		
		ss.insert(NameSpace + "insertOne", map);
		
	}
	
	
}
