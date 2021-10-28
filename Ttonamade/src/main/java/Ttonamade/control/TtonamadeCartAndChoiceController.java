package Ttonamade.control;

import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.databind.ObjectMapper;

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
import Ttonamade.dto.Product_choiceDto;
import Ttonamade.dto.Product_infoDto;
import net.sf.json.JSONArray;

@Controller
public class TtonamadeCartAndChoiceController {
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

	// 장바구니 담기
	@RequestMapping("/orderAddCart")
	public String ProdAddCartMethod(Product_infoDto dto, HttpSession session, HttpServletRequest request, HttpServletResponse response) throws Exception {
		String cust_id = "";

		if (session.getAttribute("customer") != null) {
			cust_id = (((Customer_infoDto) session.getAttribute("customer")).getCust_id());

			System.out.println((((Customer_infoDto) session.getAttribute("customer")).getCust_id()));

			Cart_infoDto cartDto = new Cart_infoDto();
			cartDto.setCart_id(0);
			cartDto.setCust_id(cust_id); // 세션을 통한 cust_id 값을 가지고 와야 한다.
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
			return "redirect:/prodList";

		} else {
			Cookie[] storedCookies = request.getCookies();
			Boolean hasTtonamadeCart = false;
			Map<String, String> nestedMap = new HashMap<String, String>();
			nestedMap.put("prod_id", String.valueOf(dto.getProd_id()));
			nestedMap.put("prod_name", dto.getProd_name());
			nestedMap.put("prod_count", String.valueOf(dto.getProd_count()));
			nestedMap.put("prod_price", String.valueOf(dto.getProd_price()));
			for (Cookie i : storedCookies) {
				if (i.getName().equals("TtonamadeCart")) {
					hasTtonamadeCart = true;
					ObjectMapper mapper = new ObjectMapper();
					@SuppressWarnings("unchecked")
					Map<String, Object> map = mapper.readValue(URLDecoder.decode(i.getValue(), "UTF-8"), Map.class);
					map.put(String.valueOf(dto.getProd_id()), nestedMap);
					String json = mapper.writeValueAsString(map);
					Cookie cookie = new Cookie("TtonamadeCart", URLEncoder.encode(json, "UTF-8"));
					response.addCookie(cookie);
				}
			}
			if (!hasTtonamadeCart) {
				Map<String, Object> map = new HashMap<String, Object>();
				map.put(String.valueOf(dto.getProd_id()), nestedMap);
				ObjectMapper mapper = new ObjectMapper();
				String json = mapper.writeValueAsString(map);
				Cookie cookie = new Cookie("TtonamadeCart", URLEncoder.encode(json, "UTF-8"));
				response.addCookie(cookie);
			}
			return "redirect:/cartView";
		}
	}

	// 장바구니 보기
	@RequestMapping("/CartContainView")
	public ModelAndView CartViewPage(ModelAndView mav, Model model, HttpSession session) throws Exception {

		List<Category_Dto> category = catedao.selectAll();
		model.addAttribute("category", JSONArray.fromObject(category));

		String cust_id = "";
		if (session.getAttribute("customer") != null) {
			cust_id = (((Customer_infoDto) session.getAttribute("customer")).getCust_id());

		} else {

			System.out.println("로그인 해주세요.");
			mav.setViewName("redirect:/login");
			return mav;
		}

		Map<String, Object> map = new HashMap<String, Object>();
		List<Cart_infoDto> list = cartdao.selectAll(cust_id);

		// 장바구니에 총 금액
		int sumMoney = 0;
		sumMoney = cartdao.sumMoney(cust_id);

		map.put("list", list);
		map.put("count", list.size());
		map.put("sumMoney", sumMoney);
		map.put("custid", cust_id);
		mav.setViewName("cartView");
		mav.addObject("map", map);

		return mav;
	}

	// 주소페이지로 이동
	// 예약일자, 배송일자 입력하기
	@RequestMapping(value = "/cartTransOrder", method = RequestMethod.POST)
	public String cartSaveOrder(Model model, HttpSession session) throws Exception {
		List<Category_Dto> category = catedao.selectAll();
		model.addAttribute("category", JSONArray.fromObject(category));

		if (session.getAttribute("customer") != null) {

			return "addressPage";
		} else {
			return "redirect:/login";
		}
	}

	///////////////////////////////////////////////////////////////////////////
	// 2021-10-19
	// cartView.jsp도 수정함(삭제 버튼 url 매개 변수 수정)
	// header에 장바구니 버튼도 추가 필요
	@RequestMapping("/cartDeleteAll")
	public String cartDeleteAll(String cust_id, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
		if ((Customer_infoDto) session.getAttribute("customer") != null) {
			cartdao.deleteAll(cust_id);
			return "redirect:/cartView";
		} else {
			Cookie[] cookie = request.getCookies();

			for (int i = 0; i < cookie.length; i++) {
				if (cookie[i].getName().equals("TtonamadeCart")) {
					cookie[i].setMaxAge(0);
					response.addCookie(cookie[i]);
					break;
				}
			}
		}
		return "redirect:/cartView";
	}

	@RequestMapping("/cartDelete")
	public String cartinfoDelete(int cart_id, int prod_id, HttpSession session, HttpServletResponse response, HttpServletRequest request) throws Exception {
		if ((Customer_infoDto) session.getAttribute("customer") != null) {
			cartdao.deleteOne(cart_id);
			return "redirect:/cartView";
		} else {
			Cookie[] cookie = request.getCookies();
			String str = "";
			for (Cookie i : cookie) {
				if (i.getName().equals("TtonamadeCart")) {
					str = i.getValue();
				}
			}

			String str2 = URLDecoder.decode(str, "UTF-8");
			ObjectMapper mapper = new ObjectMapper();
			@SuppressWarnings("unchecked")
			Map<String, Object> map2 = mapper.readValue(str2, Map.class);
			map2.remove(String.valueOf(prod_id));
			System.out.println("아아: " + map2);
			String json = mapper.writeValueAsString(map2);
			Cookie cookie2 = new Cookie("TtonamadeCart", URLEncoder.encode(json, "UTF-8"));
			response.addCookie(cookie2);

			return "redirect:/cartView";
		}
	}

	// 장바구니 보기
	@SuppressWarnings("unchecked")
	@RequestMapping("/cartView")
	public ModelAndView cartView(HttpServletRequest request, ModelAndView mav, HttpSession session) throws Exception {
		String cust_id = "";
		Map<String, Object> map = new HashMap<String, Object>();
		List<Cart_infoDto> list = new ArrayList<Cart_infoDto>();
		int sumMoney = 0;
		if (session.getAttribute("customer") != null) {
			cust_id = ((Customer_infoDto) session.getAttribute("customer")).getCust_id();

			list = cartdao.selectAll(cust_id);

			// 장바구니에 총 금액
			sumMoney = cartdao.sumMoney(cust_id);

		} else {
			Cookie[] cookie = request.getCookies();
			String str = "";
			for (Cookie i : cookie) {
				if (i.getName().equals("TtonamadeCart")) {
					str = i.getValue();
				}
			}

			if (!str.equals("")) {
				String str2 = URLDecoder.decode(str, "UTF-8");
				ObjectMapper mapper = new ObjectMapper();
				Map<String, Object> map2 = mapper.readValue(str2, Map.class);
				System.out.println("아아: " + map2);

				for (Object i : map2.values()) {
					Cart_infoDto cidto = new Cart_infoDto();
					cidto.setProd_count(Integer.parseInt(((Map<String, String>) i).get("prod_count")));
					cidto.setProd_id(Integer.parseInt(((Map<String, String>) i).get("prod_id")));
					cidto.setProd_name(((Map<String, String>) i).get("prod_name"));
					cidto.setProd_price(Integer.parseInt(((Map<String, String>) i).get("prod_price")));
					sumMoney += Integer.parseInt(((Map<String, String>) i).get("prod_price"));
					list.add(cidto);
				}
			}
		}

		map.put("list", list);
		map.put("count", list.size());
		map.put("sumMoney", sumMoney);
		map.put("custid", cust_id);
		mav.setViewName("cartView");
		mav.addObject("map", map);

		log.info("sumMoney: " + sumMoney + "");
		log.info("count: " + list.size() + "");
		return mav;
	}

	////////////////////////////////////////////////////////////////////////////
	/* 찜하기 관련 */
	// 찜하기 추가
	@RequestMapping(value = "/addChoice")
	@ResponseBody
	public Map<String, String> addChoice(@RequestBody int prod_id, HttpSession session) throws Exception {
		Map<String, String> map = new HashMap<String, String>();
		if (session.getAttribute("customer") != null) {
			String cust_id = ((Customer_infoDto) session.getAttribute("customer")).getCust_id();
			Product_choiceDto pcdto = new Product_choiceDto();
			pcdto.setCust_id(cust_id);
			pcdto.setProd_id(prod_id);

			int result = pcdao.insertOne(pcdto);

			if (result > 0) {
				map.put("isSuceeded", "suceeded");
				return map;
			} else if (result == 0) {
				map.put("isSuceeded", "already");
				return map;
			} else {
				map.put("isSuceeded", "failed");
				return map;
			}
		} else {
			System.out.println("로그인해주세요.");
			map.put("isSuceeded", "login");
			return map;
		}
	}

	// 찜하기 화면
	@RequestMapping("/choiceView")
	public ModelAndView choiceView(ModelAndView mav, HttpSession session) throws Exception {
		if (session.getAttribute("customer") != null) {
			String cust_id = ((Customer_infoDto) session.getAttribute("customer")).getCust_id();
			Map<String, Object> map = new HashMap<String, Object>();
			List<Product_choiceDto> list = pcdao.selectAll(cust_id);
			List<Product_infoDto> list2 = new ArrayList<Product_infoDto>();
			for (Product_choiceDto i : list) {
				list2.add(pidao.selectOne(i.getProd_id()));
			}
			map.put("list", list2);
			return new ModelAndView("choiceView", "map", map);

		} else {
			System.out.println("로그인해주세요.");
			return new ModelAndView("login");
		}
	}

	// 찜하기 삭제
	@RequestMapping(value = "/deleteChoice")
	public String deleteChoice(@RequestParam int prod_id, HttpSession session) throws Exception {
		if (session.getAttribute("customer") != null) {
			String cust_id = ((Customer_infoDto) session.getAttribute("customer")).getCust_id();
			Product_choiceDto pcdto = new Product_choiceDto(cust_id, prod_id);
			pcdao.deleteOne(pcdto);
		} else {
			System.out.println("로그인해주세요.");
			return "redirect:/login";
		}
		return "redirect:/choiceView";
	}

	// 찜하기 전체 삭제
	@RequestMapping(value = "/deleteAllChoice")
	public String deleteAllChoice(HttpSession session) throws Exception {
		if (session.getAttribute("customer") != null) {
			String cust_id = ((Customer_infoDto) session.getAttribute("customer")).getCust_id();
			pcdao.deleteAll(cust_id);
			return "redirect:/choiceView";
		} else {
			System.out.println("로그인해주세요.");
			return "redirect:/login";
		}
	}
}
