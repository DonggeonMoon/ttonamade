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
	
	public void insertOne(Order_detailDto odDto) throws Exception{
		
		ss.insert(NameSpace + "insertOne", odDto);
		
	}
	
	public Order_detailDto selectOne(String order_id) throws Exception{
		
		return ss.selectOne(NameSpace + "selectOne", order_id);
	}
	
	public void deleteOne(String order_id) throws Exception{
		
		ss.delete(NameSpace + "deleteOne", order_id);
		
	}
	
	public void updateOne(Order_detailDto odDto) throws Exception{
		
		ss.update(NameSpace + "updateOne", odDto);
		
	}
}
