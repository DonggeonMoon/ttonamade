package Ttonamade.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import Ttonamade.dto.ProductSearchDto;
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

	public List<Product_infoDto> selectAllGubun(String cateCodeRef, String cateCode) throws Exception {
		Map<String, String> map = new HashMap<String, String>();
		map.put("cateCodeRef", cateCodeRef);
		map.put("cateCode", cateCode);

		return ss.selectList(NameSpace + "selectAllGubun", map);
	}

	public Product_infoDto selectOne(int prod_id) throws Exception {
		return ss.selectOne(NameSpace + "selectOne", prod_id);
	}

	public void insertOne(Product_infoDto prodDto) throws Exception {
		ss.insert(NameSpace + "insertOne", prodDto);
	}

	public void updateOne(Product_infoDto prodDto) throws Exception {
		ss.update(NameSpace + "updateOne", prodDto);
	}

	public void deleteOne(int prod_id) throws Exception {
		ss.delete(NameSpace + "deleteOne", prod_id);
	}

	public List<Product_infoDto> selectConditioS(ProductSearchDto PSDto) throws Exception {
		return ss.selectList(NameSpace + "selectConditioS", PSDto);
	}

	public void UpdateProductCount(String prod_id) throws Exception {
		ss.update(NameSpace + "prodCountUpdate", prod_id);
	}

	public int selectData(String cust_id) throws Exception {

		return ss.selectOne(NameSpace + "selectEqualsData", cust_id);
	}

	public void update(Product_infoDto prodDto) throws Exception {
		ss.update(NameSpace + "updateOne", prodDto);
	}

	public void updateProductRanking(String prod_id) throws Exception {
		ss.update(NameSpace + "updateProductRanking", prod_id);
	}

	public List<Product_infoDto> searchProduct(String keyword) {
		return ss.selectList(NameSpace + "searchProduct", keyword);
	}
}
