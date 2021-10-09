package Ttonamade.control;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.inject.Inject;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.security.crypto.bcrypt.BCrypt;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

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
import Ttonamade.dto.Product_choiceDto;
import Ttonamade.dto.Product_infoDto;
import Ttonamade.dto.Product_reviewDto;
import net.sf.json.JSONArray;


@Controller
public class TtonamadeController {

	private static final Log log = LogFactory.getLog(TtonamadeProductController.class);

 	@Inject
	Customer_infoDao cudao;
	
	@Inject
	Order_infoDao oidao;
	
	@Inject
	Order_detailDao oddao;
	
	@Inject
	Product_infoDao pidao;
	
	@Inject
	Cart_infoDao cadao;
	
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
	//홈 화면
	@RequestMapping("/")
	public String home(Model model) throws Exception {
		//홈에서 카테고리에 값을 넎어주어야 하나?
		List<Category_Dto> category = catedao.selectAll();
		model.addAttribute("category", JSONArray.fromObject(category));
	
		return "home";
	}
	
	//로그인 화면
	@RequestMapping(value="/login", method=RequestMethod.GET)
	public String getLogin(Model model) throws Exception {
		
		List<Category_Dto> category = catedao.selectAll();
		model.addAttribute("category", JSONArray.fromObject(category));
	
		return "login";
	}
	
	// 회원가입 동의 화면
	@RequestMapping("/registerAgree")
	public String registerAgree() {
		return "registerAgree";
	}
	
	//회원가입 화면
	@RequestMapping("/insertCustInfo")
	public String insertCustInfo(Model model) throws Exception {
		List<Category_Dto> category = catedao.selectAll();
		model.addAttribute("category", JSONArray.fromObject(category));
	
		return "insertCustInfo";
	}
	
	//아이디, 비밀번호 찾기 화면
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
			System.out.println("로그인 해주세요.");
			return "redirect:/login";
		}
	}
	
	
	////////////////////////////////////////////////////////////////////////////
	/* 상품 관련 */
	// 상품 목록
	@ModelAttribute("list")
	@RequestMapping("/prodList")
	public List<Product_infoDto> prodList(Model model) throws Exception {
		//여기에서 추가해주어야 할것이 드랍다운 메뉴
		 
		List<Category_Dto> category = catedao.selectAll();
		model.addAttribute("category", JSONArray.fromObject(category));
		return pidao.selectAll();
	}
	
	//상품 목록	 
	@RequestMapping("/prodList1")
	public String prodListCondition(Model model, @RequestParam String catecoderef, @RequestParam String catecode) throws Exception {
		//여기에서 추가해주어야 할것이 드랍다
		log.info("catecoderef: catecode : "+ catecoderef+ ""+ catecode);
		List<Product_infoDto> list = pidao.selectAllGubun(catecoderef, catecode);
		model.addAttribute("list", list);
		List<Category_Dto> category = catedao.selectAll();
		model.addAttribute("category", JSONArray.fromObject(category));
	
		return "prodList";
		
	}
		
	@RequestMapping("/prodListCate")
	public String prodListCate(Model model) throws Exception {
		List<Category_Dto> category = catedao.selectAll();
		model.addAttribute("category", JSONArray.fromObject(category));
	
		return "header";
	}
	
	// 상품 보기 화면 
	@ModelAttribute("product" )
	@RequestMapping("/prodView")
	public Product_infoDto prodView(int prod_id, Model model, HttpSession session) throws Exception {
		List<Category_Dto> category = catedao.selectAll();
		model.addAttribute("category", JSONArray.fromObject(category));
	
		List <Product_reviewDto> list = prodReDao.selectProdData( prod_id);
		char managergubun  ='/';
		
		if (session.getAttribute("customer") != null) {
			  managergubun = ((Customer_infoDto) session.getAttribute("customer")).getCust_manager();
		}
		
		System.out.println("managergubun 구분값을 알고싶다. "+managergubun);
		//여기에서 만일 관리자 유무에 따라 다른 뷰를 보여준다.
		//customer cust_manager =='M'이라면 
		model.addAttribute("list", list);
		model.addAttribute("cust",managergubun );
		return pidao.selectOne(prod_id);	
	}
	
	
	////////////////////////////////////////////////////////////////////////////
	//회원정보 수정/삭제 화면
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
	
	@RequestMapping("/deleteCustInfo")
	public String deleteCustInfo(HttpSession session) throws Exception {
		String cust_id = ((Customer_infoDto) session.getAttribute("customer")).getCust_id();
		cudao.deleteOne(cust_id);
		return "redirect:/logout";		
	}
	
	//회원정보 수정/삭제 화면 수정 버튼 클릭 시
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
	
	//회원가입 화면 제출 버튼 클릭 시
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
	
	@RequestMapping(value="/idCheck", method=RequestMethod.POST)
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
	 
	
	//아이디, 비밀번호 찾기 화면 찾기 버튼 클릭 시
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
	
	//아이디, 비밀번호 찾기 화면 찾기 버튼 클릭 시
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
	/* 주문 조회/취소 관련 */
	// 주문 조회/취소 화면
	/*
	@RequestMapping("/findOrderAndCancel")
	public String findOrderAndCancel(Model model, HttpSession session) throws Exception {
		if (session.getAttribute("customer") != null) {
			List<Order_infoDto> list = oidao.selectAll(((Customer_infoDto) session.getAttribute("customer")).getCust_id());
			model.addAttribute("list", list);
			Map<String, List<Order_detailDto>> map = new HashMap<String, List<Order_detailDto>>();
		for (Order_infoDto i : list) {
			map.put(i.getOrder_id(), oddao.selectAll(i.getOrder_id()));
		}
			model.addAttribute("map", map);
			return "findOrderAndCancel";
		} else {
			System.out.println("로그인해주세요.");
			return "redirect:/login";
		}
	}*/
	
	//주문 조회/취소 화면
	@RequestMapping("/findOrderAndCancel")
	public String findOrderAndCancel(Model model, HttpSession session) throws Exception {
			List<Category_Dto> category = catedao.selectAll();
			model.addAttribute("category", JSONArray.fromObject(category));
		
			if (session.getAttribute("customer") != null) {
				
				List<Order_infoDto> list = oidao.selectAll(((Customer_infoDto) session.getAttribute("customer")).getCust_id());
				model.addAttribute("list", list);
				
				
				Map<String, List<Order_DetailReview>> map = new HashMap<String, List<Order_DetailReview>>();
				
				//Map<String, List<Order_detailDto>> map = new HashMap<String, List<Order_detailDto>>();
				//Map<String, List<Product_infoDto>> map1 = new HashMap<String ,  List<Product_infoDto>>();
				
				//for (Order_infoDto i:list) {
				//		map.put(i.getOrder_id(), oddao.selectAll(i.getOrder_id()));	
				//}	
				
				for (Order_infoDto i:list) {
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
	public String cancelOrder(@RequestParam String order_id,  HttpSession session  ) throws Exception {
		 
		//주문삭제시 //주문Flag//주문금액을 가지고 등급 update한다. 
		if (session.getAttribute("customer") != null) {
			
			String cust_id = ((Customer_infoDto) session.getAttribute("customer")).getCust_id();
				
			Order_infoDto oidto = oidao.selectOne(order_id);
			
			oidto.setOrder_status('F');
			oidao.updateOne(oidto);
			
			List<Order_detailDto> list = oddao.selectAll(order_id);
			for (Order_detailDto i: list) {
				Product_infoDto pidto = pidao.selectOne(i.getProd_id());
				pidto.setProd_count(pidto.getProd_count() + i.getOrder_count());
				pidao.updateOne(pidto);
				
			}
			char Ranking =  (((Customer_infoDto) session.getAttribute("customer")).getCust_manager());
		 	//주문저장하고 사용자 USER 등급을 UPDATE,  저장한 값 까지 해서 TOTAL금액을 가지고UPDATE한다.
		 	log.info("고객등급" + Ranking);
			if (Ranking != 'M') {		
					//고객의 주문값을 이용하여 등급을 업데이트 한다. 
					//주문저장하고 사용자 USER 등급을 UPDATE,  저장한 값 까지 해서 TOTAL금액을 가지고UPDATE한다.
					int ResultValue = oidao.selectCustOrder(cust_id);	
					log.info("금액 " + ResultValue);
					if ( ResultValue >= 100000 &&  ResultValue < 200000 ) {
						//고개등급을 Update 한다. 
						cudao.updateOne(cust_id, String.valueOf('S'));
						}else if(ResultValue >= 200000 ) {
							cudao.updateOne(cust_id, "G");
						}else {
							cudao.updateOne(cust_id, "B");
						}
		 	}
			 
		}
		
		return "redirect:/findOrderAndCancel";
	}
	
	//주문 조회/취소 화면 버튼 클릭 시
	@RequestMapping(value="/insertProd2", method=RequestMethod.POST)
	public String insertProd2(MultipartHttpServletRequest request, @ModelAttribute Product_infoDto pidto, HttpSession session) throws Exception {
		if (session.getAttribute("customer") != null) {
			if (((Customer_infoDto) session.getAttribute("customer")).getCust_manager() == 'M') {
				ServletContext sc = request.getServletContext();
				
				System.out.println(sc.getRealPath("/"));
				System.out.println(sc.getContextPath());
				
				String originalFileName = pidto.getPicture().getOriginalFilename(); //파일이름을 수정해보자
				
				UUID uid = UUID.randomUUID();

				String createdFileName = uid.toString() + "_" + originalFileName;	
				String path = sc.getRealPath("/img")+ "\\" + createdFileName;
				
				System.out.println(path);
				
				pidto.getPicture().transferTo(new File(path));
				pidto.setProd_imgsrc("img/" + createdFileName);
				pidao.insertOne(pidto);
				return "redirect:/prodList";
			} else {
				System.out.println("관리자가 아닙니다.");
				return "redirect:/prodList";
			}
		} else {
			System.out.println("로그인 해주세요.");
			return "redirect:/login";
		}
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
	
	////////////////////////////////////////////////////////////////////////////
	/* 자동완성 관련 */
	// 자동 완성 기능 ajax
	@RequestMapping(value = "/autocomplete", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> autocomplete(@RequestBody String keyword) throws Exception {
		List<Product_infoDto> result = pidao.searchProduct(keyword);
		Map<String, Object> map = new HashMap<String, Object>();
		for (Product_infoDto i : result) {
			map.put(String.valueOf(i.getProd_id()), i.getProd_name());
		}
		return map;
	}
	
	////////////////////////////////////////////////////////////////////////////
	/* 로그인 관련 */
	// 로그인 화면 로그인 버튼 클릭 시
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public String postLogin(@ModelAttribute Customer_infoDto cudto, HttpSession session) throws Exception {
		if (cudto.getCust_id().equals("")) {
			System.out.println("아이디를 입력해주세요.");
			return "redirect:/login";
		}

		Customer_infoDto result = cudao.selectOne(cudto.getCust_id());
		if (result == null) {
			System.out.println("존재하지 않는 아이디입니다.");
			return "redirect:/login";
		}

		if (BCrypt.checkpw(cudto.getCust_password(), result.getCust_password())) {
			session.setAttribute("customer", result);
			System.out.println("로그인 성공.");
			return "redirect:/prodList";
		} else {
			System.out.println("비밀번호가 일치하지 않습니다.");
			return "redirect:/login";
		}
	}
	
	@RequestMapping("/logout")
	public String logout(HttpSession  session,Model model) throws Exception {
		List<Category_Dto> category = catedao.selectAll();
		model.addAttribute("category", JSONArray.fromObject(category));
	
		session.removeAttribute("customer");
		return "redirect:/prodList";
	}
}
