package Ttonamade.dao;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import Ttonamade.dto.Product_infoDto;

public class Product_infoDao {
	@Repository
	public class UsersDao {

		@Inject
		private SqlSession ss;
		
		private static final String NameSpace = "productMapper.";
		
		public void setSs(SqlSession ss) {
			this.ss = ss;
		}
		
		public List<Product_infoDto> selectAll() throws Exception {
			return ss.selectList(NameSpace + "selectAll");
		}
		
		public Product_infoDto selectOne(String prod_id) throws Exception {
			return ss.selectOne(NameSpace + "selectOne", prod_id);
		}
		
		public void insert(Product_infoDto prodDto) throws Exception {
			ss.insert(NameSpace + "insert", prodDto);
		}
		
		public void update(Product_infoDto prodDto) throws Exception{
			ss.update(NameSpace + "update", prodDto);
		}
		
		public void delete(String prod_id) throws Exception {
			ss.delete(NameSpace + "delete", prod_id);
		}
	}
}
