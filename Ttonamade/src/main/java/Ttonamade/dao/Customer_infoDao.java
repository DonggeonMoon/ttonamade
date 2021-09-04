package Ttonamade.dao;

import java.util.HashMap;
import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import Ttonamade.dto.Customer_infoDto;

@Repository
public class Customer_infoDao {
	
	@Inject
	SqlSession ss;
	
	private static final String NameSpace = "customer_infoMapper.";
	
	public void setSss(SqlSession ss) {
		this.ss = ss;
	}
	

	public List<Customer_infoDto> selectAll(String cust_id) throws Exception{
		return ss.selectList(NameSpace + "selectAll" + cust_id);
	}
	
	public Customer_infoDto selectOne(String cust_id) throws Exception{
		return ss.selectOne(NameSpace + "selectOne", cust_id);
	}
	
	public Customer_infoDto selectOneByNTB(HashMap<String, String> map) {
		return ss.selectOne(NameSpace + "selectOneByNTB");
	}
	
	public Customer_infoDto selectOneByNTBI(HashMap<String, String> map) {
		return ss.selectOne(NameSpace + "selectOneByNTBI");
	}
	
	public void insertOne(Customer_infoDto custDto) throws Exception{
		
		ss.insert(NameSpace + "insertOne", custDto);
		
	}
	public void deleteOne(String cust_id) throws Exception{
		
		ss.delete(NameSpace + "deleteOne", cust_id);
		
	}
	
	public void updateOne(Customer_infoDto custDto) throws Exception{
		
		ss.update(NameSpace + "updateOne", custDto);	
}


}
