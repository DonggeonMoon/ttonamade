package Ttonamade.dao;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import Ttonamade.dto.Order_DetailReview;

@Repository
public class Order_DetailReviewDao {
	@Inject
	SqlSession ss;

	private static final String NameSpace = "order_DetailReviewMapper.";

	public void setSs(SqlSession ss) {
		this.ss = ss;
	}

	public List<Order_DetailReview> selectAllDetail(String Cust_id) throws Exception {
		return ss.selectList(NameSpace + "selectAllDetail", Cust_id);
	}

	public List<Order_DetailReview> selectProdDetail(String order_id) throws Exception {
		return ss.selectList(NameSpace + "selectGubun", order_id);
	}
}
