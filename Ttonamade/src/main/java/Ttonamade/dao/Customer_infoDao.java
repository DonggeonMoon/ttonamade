package Ttonamade.dao;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import Ttonamade.dto.Customer_infoDto;

@Repository
public class Customer_infoDao {
	
	@Inject
	SqlSession ss;
	
	private static final String NameSpace = "customer_infoMapper";
	
	public void setSss(SqlSession ss) {
		this.ss = ss;
	}
	
<<<<<<< HEAD
	public List<Customer_infoDto> selectAll() throws Exception{
		
		return ss.selectList(NameSpace + "selectAll");
	}
	
	public Customer_infoDto selectOne(int cust_id) throws Exception{
			
			return ss.selectOne(NameSpace + "select", cust_id);
		}
	
	public void insert(Customer_infoDto  custDto) throws Exception{
		
		ss.insert(NameSpace + "insert", custDto);
		
	}
	public void delete(int cust_id) throws Exception{
		
		ss.delete(NameSpace + "delete", cust_id);
		
	}
	
	public void update(Customer_infoDto custDto) throws Exception{
		
		ss.update(NameSpace + "update", custDto);
=======
	public List<Customer_infoDto> selectAll(int cust_id) throws Exception{
		
		return ss.selectList(NameSpace + "selectAll" + cust_id);
	}
	
	public Customer_infoDto selectOne(int cust_id) throws Exception{
			
			return ss.selectOne(NameSpace + "selectOne", cust_id);
		}
	
	public void insertOne(Customer_infoDto  custDto) throws Exception{
		
		ss.insert(NameSpace + "insertOne" + custDto);
		
	}
	public void deleteOne(int cust_id) throws Exception{
		
		ss.delete(NameSpace + "deleteOne", cust_id);
		
	}
	
	public void updateOne(Customer_infoDto custDto) throws Exception{
		
		ss.update(NameSpace + "updateOne", custDto);
>>>>>>> branch 'main' of https://github.com/DonggeonMoon/Ttonamade.git
	
}


}
