package Ttonamade.dao;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;

import Ttonamade.dto.Order_detailDto;


public class Order_DetailDao {
	
	@Inject
	SqlSession ss;
	
	private static final String NameSpace = "order_detailMapper.";
	
	public void setSs(SqlSession ss) {
		this.ss = ss;
	}
	
	public List<Order_detailDto> selectAll() throws Exception{
		
		return ss.selectList(NameSpace +"selectAll");
	}
	
	public void insert(Order_detailDto odDto) throws Exception{
		
		ss.insert(NameSpace + "insert", odDto);
		
	}
	
	public Order_detailDto selectOne(String order_id) throws Exception{
		
		return ss.selectOne(NameSpace + "select", order_id);
	}
	
	public void delete(String order_id) throws Exception{
		
		ss.delete(NameSpace + "delete", order_id);
		
	}
	
	public void update(Order_detailDto odDto) throws Exception{
		
		ss.update(NameSpace + "update", odDto);
		
	}
}
