package Ttonamade.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import Ttonamade.dto.Order_infoDto;
import Ttonamade.dto.ProductSearchDto;

@Repository
public class Order_infoDao {

	@Inject
	private SqlSession ss;

	private static final String NameSpace = "order_infoMapper.";

	public void setSs(SqlSession ss) {
		this.ss = ss;
	}

	public List<Order_infoDto> selectAll(String cust_id) throws Exception {
		return ss.selectList(NameSpace + "selectAll", cust_id);
	}

	public Order_infoDto selectOne(String order_id) throws Exception {
		return ss.selectOne(NameSpace + "selectOne", order_id);
	}

	public void insertOne(Order_infoDto oiDto) throws Exception {
		ss.insert(NameSpace + "insertOne", oiDto);
	}

	public void insertReservationEx(Order_infoDto oiDto) throws Exception {
		ss.insert(NameSpace + "insertReservationEx", oiDto);
	}

	public void updateOne(Order_infoDto oiDto) throws Exception {
		ss.update(NameSpace + "updateOne", oiDto);
	}

	public void deleteOne(String order_id) throws Exception {
		ss.delete(NameSpace + "deleteOne", order_id);
	}

	public int selectCustOrder(String cust_id) throws Exception {
		return ss.selectOne(NameSpace + "selectCustOrder", cust_id);
	}

	public List<Order_infoDto> selectOrderSearch(ProductSearchDto PSDto) throws Exception {
		return ss.selectList(NameSpace + "selectOrderSearch", PSDto);
	}

	public void UpdateReservation(String order_id, String reservation_date, String send_date, String reservation_memo)
			throws Exception {
		Map<String, String> map = new HashMap<String, String>();

		map.put("order_id", order_id);
		map.put("reservation_date", reservation_date);
		map.put("send_date", send_date);
		map.put("reservation_memo", reservation_memo);

		ss.update(NameSpace + "UpdateReservation", map);
	}

	public void deleteReservation(String order_id) throws Exception {
		ss.update(NameSpace + "deleteReservation", order_id);
	}
}
