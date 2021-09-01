package Ttonamade.dao;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import Ttonamade.dto.Product_infoDto;

@Repository
public class Product_infoDao {
	
	@Inject
	private SqlSession ss;
	
	private static final String NameSpace = "product_infoMapper.";
	
	public void setSs(SqlSession ss) {
		this.ss = ss;
	}
	
	public List<Product_infoDto> selectAll() throws Exception {
		return ss.selectList(NameSpace + "selectAll");
	}
	
	public Product_infoDto selectOne(String prod_id) throws Exception {
		return ss.selectOne(NameSpace + "selectOne", prod_id);
	}
	
	public void insertOne(Product_infoDto prodDto) throws Exception {
		ss.insert(NameSpace + "insertOne", prodDto);
	}
	
	public void update(Product_infoDto prodDto) throws Exception{
		ss.update(NameSpace + "updateOne", prodDto);
	}
	
	public void deleteOne(String prod_id) throws Exception {
		ss.delete(NameSpace + "deleteOne", prod_id);
	}
}
