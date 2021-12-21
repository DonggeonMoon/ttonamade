package Ttonamade.control;

import java.sql.Date;
import java.text.DecimalFormat;
import java.time.LocalDate;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import Ttonamade.dao.Cart_infoDao;
import Ttonamade.dao.Category_Dao;
import Ttonamade.dao.Customer_infoDao;
import Ttonamade.dao.Order_DetailReviewDao;
import Ttonamade.dao.Order_detailDao;
import Ttonamade.dao.Order_infoDao;
import Ttonamade.dao.Product_choiceDao;
import Ttonamade.dao.Product_infoDao;
import Ttonamade.dao.Product_reviewDao;
import Ttonamade.dto.Category_Dto;
import Ttonamade.dto.Customer_infoDto;
import Ttonamade.dto.Order_DetailReview;
import Ttonamade.dto.Order_detailDto;
import Ttonamade.dto.Order_infoDto;
import Ttonamade.dto.ProductSearchDto;
import Ttonamade.dto.Product_infoDto;
import net.sf.json.JSONArray;

@Controller
public class TtonamadeOrderController {
	private static final Log log = LogFactory.getLog(TtonamadeProductController.class);

	@Inject
	Customer_infoDao cudao;

	@Inject
	Product_infoDao pidao;

	@Inject
	Cart_infoDao cartdao;

	@Inject
	Order_infoDao oidao;

	@Inject
	Order_detailDao oddao;

	@Inject
	Product_choiceDao pcdao;

	@Inject
	Product_reviewDao prodReDao;

	@Inject
	Category_Dao catedao;

	@Inject
	Order_DetailReviewDao detailReviewDao;

	////////////////////////////////////////////////////////////////////////////
	/* 주문 조회/취소 관련 */
	// 주문 조회/취소 화면
	@RequestMapping("/findOrderAndCancel")
	public String findOrderAndCancel(Model model, HttpSession session) throws Exception {
		List<Category_Dto> category = catedao.selectAll();
		model.addAttribute("category", JSONArray.fromObject(category));

		if (session.getAttribute("customer") != null) {
			List<Order_infoDto> list = oidao.selectAll(((Customer_infoDto) session.getAttribute("customer")).getCust_id());
			model.addAttribute("list", list);

			Map<String, List<Order_DetailReview>> map = new HashMap<String, List<Order_DetailReview>>();

			for (Order_infoDto i : list) {
				map.put(i.getOrder_id(), detailReviewDao.selectProdDetail(i.getOrder_id()));
			}

			model.addAttribute("map", map);

			return "findOrderAndCancel";
		} else {
			System.out.println("로그인해주세요.");
			return "redirect:/login";
		}
	}

	@RequestMapping("/cancelOrder")
	public String cancelOrder(@RequestParam String order_id, HttpSession session) throws Exception {
		if (session.getAttribute("customer") != null) {

			String cust_id = ((Customer_infoDto) session.getAttribute("customer")).getCust_id();

			Order_infoDto oidto = oidao.selectOne(order_id);

			oidto.setOrder_status('F');
			oidao.updateOne(oidto);

			List<Order_detailDto> list = oddao.selectAll(order_id);
			for (Order_detailDto i : list) {
				Product_infoDto pidto = pidao.selectOne(i.getProd_id());
				pidto.setProd_count(pidto.getProd_count() + i.getOrder_count());
				pidao.updateOne(pidto);

			}
			char Ranking = (((Customer_infoDto) session.getAttribute("customer")).getCust_manager());

			log.info("고객등급" + Ranking);
			if (Ranking != 'M') {
				int ResultValue = oidao.selectCustOrder(cust_id);
				log.info("금액 " + ResultValue);
				if (ResultValue >= 100000 && ResultValue < 200000) {
					// 고개등급을 Update 한다.
					cudao.updateOne(cust_id, String.valueOf('S'));
				} else if (ResultValue >= 200000) {
					cudao.updateOne(cust_id, "G");
				} else {
					cudao.updateOne(cust_id, "B");
				}
			}

		}

		return "redirect:/findOrderAndCancel";
	}

	///////////////////////////////////////////////////////////////////////
	/* 예약 관련 */
	@RequestMapping("/reservationOrder")
	public String reservationOrder(Model model, HttpSession session) throws Exception {
		if (session.getAttribute("customer") != null) {

			char resultRank = ((Customer_infoDto) (session.getAttribute("customer"))).getCust_manager();
			if (resultRank == 'M') {
				return "reservationOrder";
			} else {

				model.addAttribute("data", "로그인해주세요.");
				model.addAttribute("url", "login");
				return "reservationOrder";
			}

		} else {

			model.addAttribute("data", "로그인해주세요.");
			model.addAttribute("url", "login");
			return "reservationOrder";
		}
	}

	@RequestMapping("/reservationOrderS")
	public String reservationOrderS(ProductSearchDto dto, Model model, HttpSession session) throws Exception {
		List<Category_Dto> category = catedao.selectAll();
		model.addAttribute("category", JSONArray.fromObject(category));
		if (session.getAttribute("customer") == null) {
			model.addAttribute("data", "로그인해주세요.");
			model.addAttribute("url", "login");
			return "reservationOrder";
		}

		LocalDate now = LocalDate.now();
		String now1 = String.valueOf(now);

		if (dto.getSearchOption() == null)
			dto.setSearchOption("order_date");

		if (dto.getKeyword() == null)
			dto.setKeyword(now1);// 시작일자

		if (dto.getKeyword2() == null)
			dto.setKeyword2(now1);// 종료일자

		HashMap<String, Object> map = new HashMap<String, Object>();

		List<Order_infoDto> list = oidao.selectOrderSearch(dto);
		model.addAttribute("list", list);

		for (Order_infoDto i : list) {
			map.put(i.getOrder_id(), detailReviewDao.selectProdDetail(i.getOrder_id()));
		}

		model.addAttribute("map", map);
		return "reservationOrder";
	}

	@RequestMapping("/ResOrderUpdate")
	public String ResOrderUpdate(Model model, @RequestParam String Gubun, @RequestParam String order_id, HttpSession session) throws Exception {
		log.info("로그값을 찍어라 " + Gubun);
		if (session.getAttribute("customer") != null) {
			char resultRank = ((Customer_infoDto) (session.getAttribute("customer"))).getCust_manager();

			if (resultRank == 'M') {

				if (Gubun.equals("M")) {
					Order_infoDto dto = oidao.selectOne(order_id);
					model.addAttribute("orderDto", dto);
					return "reservationUpdate";

				} else {

					oidao.deleteReservation(order_id);

					model.addAttribute("data", "예약정보를 삭제하였습니다.");
					model.addAttribute("url", "reservationOrder");
					return "reservationOrder";

				}

			} else {
				model.addAttribute("data", "관리자만 수정가능.");
				model.addAttribute("url", "reservationOrder");
				return "reservationOrder";
			}

		} else {

			model.addAttribute("data", "로그인해주세요.");
			model.addAttribute("url", "login");
			return "reservationOrder";
		}

	}

	@RequestMapping("/Reservation_Save")
	public String Reservation_Save(Model model, String reservation_date, String send_date, String order_id, String reservation_memo, HttpSession session) throws Exception {
		oidao.UpdateReservation(order_id, reservation_date, send_date, reservation_memo);
		model.addAttribute("data", " 예약정보가 수정되었습니다.");
		model.addAttribute("url", "reservationOrder");
		return "reservationOrder";
	}
	
	///////////////////////////////////////////////////////////////////////
	// 주문 확정을 누를 시
	@RequestMapping(value = "/orderSuccess", method = RequestMethod.POST)
	public String orderSuccess(@ModelAttribute Order_infoDto dto, HttpSession session, Model model, @RequestBody String res_cd) throws Exception {

		List<Category_Dto> category = catedao.selectAll();
		model.addAttribute("category", JSONArray.fromObject(category));

		String cust_id = "";
		if (session.getAttribute("customer") != null) {
			cust_id = ((Customer_infoDto) session.getAttribute("customer")).getCust_id();

		} else {

			model.addAttribute("data", "로그인해주세요.");
			model.addAttribute("url", "login");
			return "cartView";
		}

		int order_totalAmount = 0;
		order_totalAmount = cartdao.sumMoney(cust_id);

		String orderId = OrderNoReturn();

		int Equalscount = 0;
		Equalscount = pidao.selectData(cust_id);

		log.info("  orderId : " + orderId);
		log.info("  order_totalAmount : " + order_totalAmount);
		log.info("  getOrder_add1 : " + dto.getOrder_add1());
		log.info("  getOrder_add2 : " + dto.getOrder_add2());
		log.info("  getOrder_zipcode : " + dto.getOrder_telephone());
		log.info("  Equalscount : " + Equalscount);

		if (Equalscount == 0) {

			model.addAttribute("data", "재고가 부족합니다.");
			model.addAttribute("url", "cartView");
			return "cartView";

		} else {
			// 주문금액을 등급별로 할인해준다.
			// 주문금액 total 10만원 이상이면 실버: 5% 할인
			// 주문금액 total 20만원 이상이면 골드: 10% 할인

			char resultRank = ((Customer_infoDto) (session.getAttribute("customer"))).getCust_manager();

			if (resultRank == 'G' || resultRank == 'M') {
				order_totalAmount = (int) (order_totalAmount - (order_totalAmount * 0.1));

			} else if (resultRank == 'S') {
				order_totalAmount = (int) (order_totalAmount - (order_totalAmount * 0.05));

			}

			dto.setOrder_totalAmount(order_totalAmount);
			dto.setCust_id(cust_id);
			dto.setOrder_id(orderId);

			Date resDate = dto.getReservation_date();
			Date sendDate = dto.getSend_date();

			LocalDate now = LocalDate.now();
			Date now1 = Date.valueOf(now);

			int result = resDate.compareTo(now1);
			int resultSend = sendDate.compareTo(now1);
			if ((result == -1) || (resultSend == -1)) {
				oidao.insertReservationEx(dto);
			} else {
				oidao.insertOne(dto);
			}
			char Ranking = (((Customer_infoDto) session.getAttribute("customer")).getCust_manager());
			if (Ranking != 'M') {
				int ResultValue = oidao.selectCustOrder(cust_id);
				if (ResultValue >= 100000 && ResultValue < 200000) {
					cudao.updateOne(cust_id, "S");
				} else if (ResultValue >= 200000) {
					cudao.updateOne(cust_id, "G");

				} else {
					cudao.updateOne(cust_id, "B");
				}
			}
			pidao.UpdateProductCount(cust_id);
			oddao.insertOne(orderId, cust_id);
			log.info("  주문DETAIL : " + "저장 ");
			cartdao.deleteAll(cust_id);

			model.addAttribute("data", "주문이 정상적으로 이루어졌습니다..");
			model.addAttribute("url", "prodList");
			model.addAttribute("res_cd", res_cd);
			return "orderSuccess";
		}

	}

	public String OrderNoReturn() {
		Calendar cal = Calendar.getInstance();
		int year = cal.get(Calendar.YEAR);
		String ym = year + new DecimalFormat("00").format(cal.get(Calendar.MONTH) + 1);
		String ymd = ym + new DecimalFormat("00").format(cal.get(Calendar.DATE));
		String subNum = "";

		for (int i = 1; i <= 6; i++) {
			subNum += (int) (Math.random() * 10);
		}
		String orderId = ymd + "_" + subNum;

		return orderId;
	}
}
