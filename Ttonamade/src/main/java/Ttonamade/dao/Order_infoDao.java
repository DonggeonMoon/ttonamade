package Ttonamade.dao;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import Ttonamade.dto.Order_infoDto;

@Repository
public class Order_infoDao {
	
	@Inject
	private SqlSession ss;
	
	private static final String NameSpace = "order_infoMapper.";
	
	public void setSs(SqlSession ss) {
		this.ss = ss;
	}
	
	public List<Order_infoDto> selectAll(String cust_id) throws Exception {
		return ss.selectList(NameSpace + "selectAll");
	}
	
	public Order_infoDto selectOne(String order_id) throws Exception {
		return ss.selectOne(NameSpace + "selectOne", order_id);
	}
	
	public void insertOne(Order_infoDto oiDto) throws Exception {
		ss.insert(NameSpace + "insertOne", oiDto);
	}
	
	public void updateOne(Order_infoDto oiDto) throws Exception {
		ss.update(NameSpace + "updateOne", oiDto);
	}
	
	public void deleteOne(String order_id) throws Exception {
		ss.delete(NameSpace + "deleteOne", order_id);
	}

}
