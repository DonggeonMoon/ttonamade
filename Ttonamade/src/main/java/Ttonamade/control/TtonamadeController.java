package Ttonamade.control;

import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.security.crypto.bcrypt.BCrypt;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

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
import net.sf.json.JSONArray;

@Controller
public class TtonamadeController {
	@Inject
	Customer_infoDao cudao;

	@Inject
	Product_infoDao pidao;

	@Inject
	Cart_infoDao cadao;

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
	/* 단순 매핑 */
	// 홈 화면
	@RequestMapping("/")
	public String home(Model model) throws Exception {
		List<Category_Dto> category = catedao.selectAll();
		model.addAttribute("category", JSONArray.fromObject(category));
		return "home";
	}

	// 로그인 화면
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String getLogin(String error, Model model) throws Exception {
		List<Category_Dto> category = catedao.selectAll();
		model.addAttribute("category", JSONArray.fromObject(category));
		if (error != null) {
			switch (error) {
			case "1":
				model.addAttribute("error", "아이디를 입력해주세요.");
				break;
			case "2":
				model.addAttribute("error", "존재하지 않는 아이디입니다.");
				break;
			case "3":
				model.addAttribute("error", "탈퇴한 회원입니다.");
				break;
			case "4":
				model.addAttribute("error", "비밀번호가 일치하지 않습니다.");
				break;
			default:
				model.addAttribute("error", "");
				break;
			}
		} else {
			model.addAttribute("error", "");
		}
		return "login";
	}

	// 회원가입 동의 화면
	@RequestMapping("/registerAgree")
	public String registerAgree() {
		return "registerAgree";
	}

	// 회원가입 화면
	@RequestMapping("/insertCustInfo")
	public String insertCustInfo(Model model) throws Exception {
		List<Category_Dto> category = catedao.selectAll();
		model.addAttribute("category", JSONArray.fromObject(category));

		return "insertCustInfo";
	}

	// 아이디, 비밀번호 찾기 화면
	@RequestMapping("/findIdAndPw")
	public String findIdAndPw(Model model) throws Exception {
		List<Category_Dto> category = catedao.selectAll();
		model.addAttribute("category", JSONArray.fromObject(category));
		return "findIdAndPw";
	}

	////////////////////////////////////////////////////////////////////////////
	// 마이 페이지 화면
	@RequestMapping("/myPage")
	public String myPage(HttpSession session, Model model) throws Exception {
		List<Category_Dto> category = catedao.selectAll();
		model.addAttribute("category", JSONArray.fromObject(category));

		if (session.getAttribute("customer") != null) {
			return "myPage";
		} else {
			System.out.println("로그인해주세요.");
			return "redirect:/login";
		}
	}

	////////////////////////////////////////////////////////////////////////////
	// 회원가입 화면 제출 버튼 클릭 시
	@RequestMapping(value = "/insertCustInfo2", method = RequestMethod.POST)
	public String insertCustInfo2(@ModelAttribute Customer_infoDto custdto, HttpSession session, String cust_manager_id, String cust_manager_pw) throws Exception {
		custdto.setCust_password(BCrypt.hashpw(custdto.getCust_password(), BCrypt.gensalt()));
		Customer_infoDto result = cudao.selectOne(cust_manager_id);
		if (result != null) {
			custdto.setCust_manager('M');
			cudao.insertOne(custdto);
			System.out.println("관리자로 가입합니다.");
		} else {
			cudao.insertOne(custdto);
			System.out.println("회원으로 가입합니다.");
		}
		return "redirect:/login";
	}

	// 회원정보 수정/삭제 화면
	@RequestMapping("/editCustInfo")
	public String editCustInfo(HttpSession session, Model model) throws Exception {
		if (session.getAttribute("customer") != null) {
			String cust_id = ((Customer_infoDto) session.getAttribute("customer")).getCust_id();
			Customer_infoDto list = cudao.selectOne(cust_id);
			model.addAttribute("list", list);
			return "editCustInfo";
		} else {
			System.out.println("로그인해주세요.");
			return "redirect:/login";
		}
	}

	// 회원정보 수정/삭제 화면 수정 버튼 클릭 시
	@RequestMapping(value = "/editCustInfo2", method = RequestMethod.POST)
	public String editCustInfo2(@ModelAttribute Customer_infoDto cudto, HttpSession session) throws Exception {
		if (session.getAttribute("customer") != null) {
			if (BCrypt.checkpw(cudto.getCust_password(), ((Customer_infoDto) session.getAttribute("customer")).getCust_password())) {
				cudto.setCust_password(((Customer_infoDto) session.getAttribute("customer")).getCust_password());
				cudao.updateOne(cudto);
				return "redirect:/myPage";
			} else {
				System.out.println("비밀번호가 일치하지 않습니다.");
				return "redirect:/editCustInfo";
			}
		} else {
			System.out.println("로그인해주세요.");
			return "redirect:/login";
		}
	}

	@RequestMapping("/deleteCustInfo")
	public String deleteCustInfo(HttpSession session) throws Exception {
		String cust_id = ((Customer_infoDto) session.getAttribute("customer")).getCust_id();
		cudao.deleteOne(cust_id);
		return "redirect:/logout";
	}

	@RequestMapping(value = "/idCheck", method = RequestMethod.POST)
	@ResponseBody
	public Map<Object, Object> idCheck(@RequestBody String cust_id) throws Exception {
		Map<Object, Object> map = new HashMap<Object, Object>();

		if (cudao.selectOne(cust_id) != null) {
			map.put("isUnique", false);
		} else {
			map.put("isUnique", true);
		}

		return map;
	}

	// 아이디, 비밀번호 찾기 화면 찾기 버튼 클릭 시
	@RequestMapping(value = "/findId", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> findId(@RequestBody HashMap<String, String> json) throws Exception {
		HashMap<String, Object> map = new HashMap<String, Object>();
		System.out.println(json.get("cust_name"));
		System.out.println(json.get("cust_telephone"));
		System.out.println(json.get("cust_birthday"));
		Customer_infoDto custdto = new Customer_infoDto();
		custdto.setCust_name(json.get("cust_name"));
		custdto.setCust_telephone(json.get("cust_telephone"));
		custdto.setCust_birthday(json.get("cust_birthday"));
		map.put("custdto", custdto);
		Customer_infoDto result = cudao.selectOneByNTB(map);

		Map<String, Object> map2 = new HashMap<String, Object>();
		map2.put("cust_id", result.getCust_id());
		return map2;
	}

	// 아이디, 비밀번호 찾기 화면 찾기 버튼 클릭 시
	@RequestMapping(value = "/findPw", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> findPw(@RequestBody HashMap<String, String> json) throws Exception {
		HashMap<String, Object> map = new HashMap<String, Object>();
		System.out.println(json.get("cust_name"));
		System.out.println(json.get("cust_telephone"));
		System.out.println(json.get("cust_birthday"));
		System.out.println(json.get("cust_id"));
		Customer_infoDto custdto = new Customer_infoDto();
		custdto.setCust_name(json.get("cust_name"));
		custdto.setCust_telephone(json.get("cust_telephone"));
		custdto.setCust_birthday(json.get("cust_birthday"));
		custdto.setCust_id(json.get("cust_id"));
		map.put("custdto", custdto);
		Customer_infoDto result = cudao.selectOneByNTBI(map);

		Map<String, Object> map2 = new HashMap<String, Object>();
		if (result != null) {
			String temp_cust_pw = String.valueOf((int) Math.random() * 1000);
			System.out.println(temp_cust_pw);
			custdto.setCust_password(BCrypt.hashpw(temp_cust_pw, BCrypt.gensalt()));
			cudao.updateOne(custdto);
			map2.put("temp_cust_pw", temp_cust_pw);
		} else {
			map2.put("temp_cust_pw", null);
		}
		return map2;
	}

	////////////////////////////////////////////////////////////////////////////
	/* 로그인 관련 */
	// 로그인 화면 로그인 버튼 클릭 시
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public String postLogin(@ModelAttribute Customer_infoDto cudto, HttpSession session, HttpServletRequest request, Model model) throws Exception {
		if (cudto.getCust_id().equals("")) {
			System.out.println("아이디를 입력해주세요.");
			return "redirect:/login?error=1";
		}

		Customer_infoDto result = cudao.selectOne(cudto.getCust_id());
		if (result == null) {
			System.out.println("존재하지 않는 아이디입니다.");
			return "redirect:/login?error=2";
		}

		if (BCrypt.checkpw(cudto.getCust_password(), result.getCust_password())) {
			if (result.getCust_manager() != 'D') {
				session.setAttribute("customer", result);
				System.out.println("로그인 성공.");

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
					List<Cart_infoDto> list = new ArrayList<Cart_infoDto>();

					for (Object i : map2.values()) {
						Cart_infoDto cidto = new Cart_infoDto();
						cidto.setProd_count(Integer.parseInt(((Map<String, String>) i).get("prod_count")));
						cidto.setProd_id(Integer.parseInt(((Map<String, String>) i).get("prod_id")));
						cidto.setProd_name(((Map<String, String>) i).get("prod_name"));
						cidto.setProd_price(Integer.parseInt(((Map<String, String>) i).get("prod_price")));
						list.add(cidto);
					}

					for (Cart_infoDto i : list) {
						i.setCust_id(cudto.getCust_id());
						cadao.insertOne(i);
					}
				}
				return "redirect:/prodList";
			} else {
				System.out.println("탈퇴한 회원입니다.");
				return "redirect:/login?error=3";
			}
		} else {
			System.out.println("비밀번호가 일치하지 않습니다.");
			return "redirect:/login?error=4";
		}
	}

	@RequestMapping("/logout")
	public String logout(HttpSession session, Model model) throws Exception {
		List<Category_Dto> category = catedao.selectAll();
		model.addAttribute("category", JSONArray.fromObject(category));
		session.removeAttribute("customer");
		return "redirect:/prodList";
	}
}
