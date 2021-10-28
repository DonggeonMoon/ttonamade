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
import org.springframework.web.bind.annotation.RequestMapping;
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
import Ttonamade.dto.Cart_infoDto;
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
			System.out.println("로그인 해주세요.");
			return "redirect:/login";
		}
	}

	@RequestMapping("/cancelOrder")
	public String cancelOrder(@RequestParam String order_id, HttpSession session) throws Exception {
		// 주문삭제 시/주문Flag/주문금액을 가지고 등급 update한다.
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
			// 주문저장하고 사용자 USER 등급을 UPDATE, 저장한 값 까지 해서 TOTAL금액을 가지고UPDATE한다.
			log.info("고객등급" + Ranking);
			if (Ranking != 'M') {
				// 고객의 주문값을 이용하여 등급을 업데이트 한다.
				// 주문저장하고 사용자 USER 등급을 UPDATE, 저장한 값 까지 해서 TOTAL금액을 가지고UPDATE한다.
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

	//////////////////////////// 관리///////////////////////////////////////////
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
		// 해당 주문에 해당값 수정
		log.info("로그값을 찍어라 " + Gubun);
		if (session.getAttribute("customer") != null) {
			char resultRank = ((Customer_infoDto) (session.getAttribute("customer"))).getCust_manager();

			if (resultRank == 'M') {// 관리자만 수정및 삭제가 가능하다.

				if (Gubun.equals("M")) {
					// 수정페이지로 이동한다.
					// model.addAttribute("order_id", order_id);
					// 예약일자, 배송일자, 배송메모를 던져준다.
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

	// 주문확정을 누르면~
	@RequestMapping("/orderSuccess") // 주문저장
	public String orderSuccess(@ModelAttribute Order_infoDto dto, HttpSession session, Model model) throws Exception {

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
		order_totalAmount = cartdao.sumMoney(cust_id);// 주문총금액

		String orderId = OrderNoReturn();// 주문번호 생성

		// 주문 저장 전에 cart테 이블의 data값을 수량을 check하라
		// 만약 재고가 부족한 값이 있으면 주문할 수 없다.
		// 재고 확인
		int Equalscount = 0;
		Equalscount = pidao.selectData(cust_id); // 상품재고파악 // 0:주문가능 0보다 크면 재고부족으로 주문불가능

		//////////////// 주문저장////////////////////////////
		log.info("  orderId : " + orderId);
		log.info("  order_totalAmount : " + order_totalAmount);
		log.info("  getOrder_add1 : " + dto.getOrder_add1());
		log.info("  getOrder_add2 : " + dto.getOrder_add2());
		log.info("  getOrder_zipcode : " + dto.getOrder_telephone());
		log.info("  Equalscount : " + Equalscount);

		if (Equalscount == 0) { // 재고가 있다면 주문저장 및 상품재고 정리

			model.addAttribute("data", "재고가 부족합니다.");
			model.addAttribute("url", "cartView");
			return "cartView";

		} else {

			// 주문금액을 등급별 dc을 해준다
			// 주문금액이 total 10만원이상이면 실버 : 5% : 디스카운트
			// 주문금액 total 20만원이상이면 골드 : 10% 디스카운트
			char resultRank = ((Customer_infoDto) (session.getAttribute("customer"))).getCust_manager();

			if (resultRank == 'G' || resultRank == 'M') {// 등급이 골드이거나 관리자는 10%
				order_totalAmount = (int) (order_totalAmount - (order_totalAmount * 0.1));

			} else if (resultRank == 'S') {// 등급이 실버이면 5%
				order_totalAmount = (int) (order_totalAmount - (order_totalAmount * 0.05));

			}

			// 당일주문금액 : total
			dto.setOrder_totalAmount(order_totalAmount);
			dto.setCust_id(cust_id);
			dto.setOrder_id(orderId);

			Date resDate = dto.getReservation_date();// 예약일자
			Date sendDate = dto.getSend_date(); // 배송일자

			LocalDate now = LocalDate.now();
			Date now1 = Date.valueOf(now);

			int result = resDate.compareTo(now1); // 예약된날짜가 오늘보다 크다면 ok
			int resultSend = sendDate.compareTo(now1);
			if ((result == -1) || (resultSend == -1)) {
				oidao.insertReservationEx(dto); // 주문성공
			} else {
				oidao.insertOne(dto); // 주문성공
			}
			char Ranking = (((Customer_infoDto) session.getAttribute("customer")).getCust_manager());
			// 주문저장하고 사용자 USER 등급을 UPDATE, 저장한 값 까지 해서 TOTAL금액을 가지고UPDATE한다.
			if (Ranking != 'M') {
				int ResultValue = oidao.selectCustOrder(cust_id);
				if (ResultValue >= 100000 && ResultValue < 200000) {
					// 고개등급을 Update 한다.
					cudao.updateOne(cust_id, "S");
				} else if (ResultValue >= 200000) {
					cudao.updateOne(cust_id, "G");

				} else {
					cudao.updateOne(cust_id, "B");
				}
			}
			pidao.UpdateProductCount(cust_id);// 재고정리

			/////////////// 주문디테일저장/////////////////////////////

			oddao.insertOne(orderId, cust_id);// 주문디테일성공
			log.info("  주문DETAIL : " + "저장 ");
			cartdao.deleteAll(cust_id);// 장바구니 비우기

			model.addAttribute("data", "주문이 정상적으로 이루어졌습니다..");
			model.addAttribute("url", "prodList");
			return "prodList";
		}

	}

	public String OrderNoReturn() {
		//////////////////////////// order table에 값을 저장하기 위한 구문.////////////////////////
		// 주문번호 생성
		Calendar cal = Calendar.getInstance();
		int year = cal.get(Calendar.YEAR);
		String ym = year + new DecimalFormat("00").format(cal.get(Calendar.MONTH) + 1);
		String ymd = ym + new DecimalFormat("00").format(cal.get(Calendar.DATE));
		String subNum = "";

		for (int i = 1; i <= 6; i++) {
			subNum += (int) (Math.random() * 10);
		}
		String orderId = ymd + "_" + subNum; // 주문번호 생성

		return orderId;
	}
	// 카트에 담지않고 주문저장을 바로 눌렸을 경우 해당값을 catt_info table에 저장한다.

	@RequestMapping("/insertOrder")
	public String directOrder(Product_infoDto dto, HttpSession session) throws Exception {

		String cust_id = "";

		if (session.getAttribute("customer") != null) {
			cust_id = (((Customer_infoDto) session.getAttribute("customer")).getCust_id());

		} else {
			System.out.println("로그인 해주세요.");
			return "redirect:/login";
		}

		log.info("상품이름 :" + dto.getProd_name());
		log.info(" 상품 아이디 :" + dto.getProd_id());

		Cart_infoDto cartDto = new Cart_infoDto();
		cartDto.setCart_id(0);
		cartDto.setCust_id(cust_id); // 세션을 통한 cust_id값을 가지고 와야한다.
		cartDto.setProd_id(dto.getProd_id());

		cartDto.setProd_name(dto.getProd_name());
		cartDto.setProd_count(dto.getProd_count());

		int prodprice = (int) dto.getProd_count() * (int) dto.getProd_price();
		cartDto.setProd_price(prodprice);

		int count = 0;
		count = cartdao.countCart(cartDto.getProd_id(), cartDto.getCust_id());

		if (count == 0) {
			// 없는 상품이라면 상품을 저장한다.
			cartdao.insertOne(cartDto);
		} else {// 카트에 정보를 업데이트 한다.
			cartdao.updateCart(cartDto);
		}

		return "redirect:/CartContainView";

	}
}
