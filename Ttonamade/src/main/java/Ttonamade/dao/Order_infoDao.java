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
	
	public List<Order_infoDto> selectAll() throws Exception {
		return ss.selectList(NameSpace + "selectAll");
	}
	
	public Order_infoDto selectOne(int order_id) throws Exception {
		return ss.selectOne(NameSpace + "selectOne", order_id);
	}
	
	public void insert(Order_infoDto oiDto) throws Exception {
		ss.insert(NameSpace + "insert", oiDto);
	}
	
	public void update(Order_infoDto oiDto) throws Exception {
		ss.update(NameSpace + "update", oiDto);
	}
	
	public void delete(int order_id) throws Exception {
		ss.delete(NameSpace + "delete", order_id);
	}

}
