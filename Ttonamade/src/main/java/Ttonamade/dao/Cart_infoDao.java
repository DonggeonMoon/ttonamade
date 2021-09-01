package Ttonamade.dao;
import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import Ttonamade.dto.Cart_infoDto; 


@Repository
public class Cart_infoDao {
	
	
	@Inject
	SqlSession ss;
	
	private static final String NameSpace ="CartMapper.";

	public void setSs(SqlSession ss) {
		this.ss = ss;
	}
	
	
	public  List<Cart_infoDto> selectAll(int cust_id) throws Exception {
		return ss.selectList(NameSpace+ "selectAll" + cust_id);
		
	} 
	
	
	public Cart_infoDto selectOne(int cart_id) throws Exception{
		
		return ss.selectOne(NameSpace + "selectOne", cart_id);
	}
	
	
	public void insertOne(Cart_infoDto cartDto) throws  Exception{
		ss.insert(NameSpace+ "insertOne"+ cartDto);
		
	}
		
	
	//   선택적으로 지우거나 
	public void deleteOne(int cart_id) throws Exception{
		
		ss.delete(NameSpace + "deleteOne", cart_id);
		
	}
	//전부지우거나 
	public void deleteAll(int cust_id) throws Exception {
		 ss.delete(NameSpace + "deleteAll" + cust_id);
	}
	

}
