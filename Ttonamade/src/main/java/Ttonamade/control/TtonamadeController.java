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
import Ttonamade.dao.Customer_infoDao;
import Ttonamade.dao.Order_detailDao;
import Ttonamade.dao.Order_infoDao;
import Ttonamade.dao.Product_choiceDao;
import Ttonamade.dao.Product_infoDao;
import Ttonamade.dto.Cart_infoDto;
import Ttonamade.dto.Customer_infoDto;
import Ttonamade.dto.Order_detailDto;
import Ttonamade.dto.Order_infoDto;
import Ttonamade.dto.Product_choiceDto;
import Ttonamade.dto.Product_infoDto;

@Controller
public class TtonamadeController {
	
	@Inject
	Cart_infoDao cadao;
	
	@Inject
	Customer_infoDao cudao;
	
	@Inject
	Order_infoDao oidao;
	
	@Inject
	Order_detailDao oddao;
	
	@Inject
	Product_infoDao pidao;
	
	@Inject
	Product_choiceDao pcdao;
	
	//홈 화면
	@RequestMapping("/")
	public String home() {
		return "home";
	}
	
	//로그인 화면
	@RequestMapping("/login")
	public String getLogin() {
		return "login";
	}
	
	//회원가입 동의 화면
	@RequestMapping("/registerAgree")
	public String registerAgree() {
		return "registerAgree";
	}
	
	//회원가입 화면
	@RequestMapping("/insertCustInfo")
	public String insertCustInfo() {
		return "insertCustInfo";
	}
	
	//아이디, 비밀번호 찾기 화면
	@RequestMapping("/findIdAndPw")
	public String findIdAndPw() {
		return "findIdAndPw";
	}
	
	
	
	////////////////////////////////////////////////////////////////////////////
	
	//상품 목록
	@ModelAttribute("list")
	@RequestMapping("/prodList")
	public List<Product_infoDto> prodList() throws Exception {
		return pidao.selectAll();
	}
	
	// 상품 보기 화면
	@ModelAttribute("product")
	@RequestMapping("/prodView")
	public Product_infoDto prodView(int prod_id) throws Exception {
		return pidao.selectOne(prod_id);
	}
	
	////////////////////////////////////////////////////////////////////////////
	//마이 페이지 화면
	@RequestMapping("/myPage")
	public String myPage(HttpSession session) {
		if (session.getAttribute("customer") != null) {
			return "myPage";
		} else {
			System.out.println("로그인 해주세요.");
			return "redirect:/login";
		}
	}
	
	//회원정보 수정/삭제 화면
	@RequestMapping("/editCustInfo")
	public String editCustInfo(HttpSession session, Model model) throws Exception {
		if (session.getAttribute("customer") != null) {
			String cust_id = ((Customer_infoDto) session.getAttribute("customer")).getCust_id();
			Customer_infoDto list = cudao.selectOne(cust_id);
			model.addAttribute("list", list);
			return "editCustInfo";
		} else {
			System.out.println("로그인 해주세요.");
			return "redirect:/login";
		}
	}
	
	//회원정보 수정/삭제 화면 삭제 버튼 클릭 시
	@RequestMapping("/deleteCustInfo")
	public String deleteCustInfo(HttpSession session) throws Exception {
		String cust_id = ((Customer_infoDto) session.getAttribute("customer")).getCust_id();
		cudao.deleteOne(cust_id);
		return "redirect:/logout";		
	}
	
	//회원정보 수정/삭제 화면 수정 버튼 클릭 시
	@RequestMapping(value="/editCustInfo2", method=RequestMethod.POST)
	public String editCustInfo2(@ModelAttribute Customer_infoDto cudto, HttpSession session) throws Exception {
		if (session.getAttribute("customer") != null) {
			if(BCrypt.checkpw(cudto.getCust_password(), ((Customer_infoDto) session.getAttribute("customer")).getCust_password())) {
				cudto.setCust_password(((Customer_infoDto) session.getAttribute("customer")).getCust_password());
				cudao.updateOne(cudto);
				return "redirect:/myPage";
			} else {
				System.out.println("비밀번호가 일치하지 않습니다.");
				return "redirect:/editCustInfo";
			}
		} else {
			System.out.println("로그인 해주세요.");
			return "redirect:/login";
		}
	}
	
	//회원가입 화면 제출 버튼 클릭 시
	@RequestMapping(value="/insertCustInfo2", method=RequestMethod.POST)
	public String insertCustInfo2(@ModelAttribute Customer_infoDto custdto, HttpSession session, String cust_manager_id, String cust_manager_pw) throws Exception{
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
	
	//아이디 중복 검사
	@RequestMapping(value="/idCheck", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Boolean> idCheck(@RequestBody String cust_id) throws Exception {
		Map<String, Boolean> map = new HashMap<String, Boolean>();
		if (cudao.selectOne(cust_id) != null) {
			map.put("isUnique", false);
		} else {
			map.put("isUnique", true);
		}
		return map;
	}
	

	//아이디, 비밀번호 찾기 화면 찾기 버튼 클릭 시
	@RequestMapping(value="/findId", method=RequestMethod.POST)
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

	/*
	@RequestMapping(value="/findId", method=RequestMethod.POST)
	public void findId(@ModelAttribute Customer_infoDto custdto, HttpServletResponse response) throws Exception {
		HashMap<String, Object> map = new HashMap<String, Object>();	
		map.put("custdto", custdto);
		Customer_infoDto result = cudao.selectOneByNTB(map);
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		if (result != null) {
			out.println("<meta charset='UTF-8'><script>alert('회원님의 아이디는 "+ result.getCust_id() +"입니다.'); history.go(-1);</script>");
		} else {
			out.println("<meta charset='UTF-8'><script>alert('일치하는 회원 정보가 없습니다.'); history.go(-1);</script>");
		}
        out.flush();
	}
	*/
	
	
	//아이디, 비밀번호 찾기 화면 찾기 버튼 클릭 시
	@RequestMapping(value="/findPw", method=RequestMethod.POST)
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
			String temp_cust_pw = String.valueOf((int) Math.random()*1000);
			System.out.println(temp_cust_pw);
			custdto.setCust_password(BCrypt.hashpw(temp_cust_pw, BCrypt.gensalt()));
			cudao.updateOne(custdto);
			map2.put("temp_cust_pw", temp_cust_pw);
		} else {
			map2.put("temp_cust_pw", null);
		}
		return map2;
	} 
	/*
	
	public void findPw(@ModelAttribute Customer_infoDto custdto, HttpServletResponse response) throws Exception {
		
	}
	public void findPw(@ModelAttribute Customer_infoDto custdto, HttpServletResponse response) throws Exception {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("custdto", custdto);
		Customer_infoDto result = cudao.selectOneByNTBI(map);
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		if (result != null) {
			out.println("<meta charset='UTF-8'><script>alert('회원님의 비밀번호는 "+ result.getCust_password() +"입니다.'); history.go(-1);</script>");
		} else {
			out.println("<meta charset='UTF-8'><script>alert('회원 정보가 일치하지 않습니다.'); history.go(-1);</script>");
		}
        out.flush();
	}*/
	
	//주문 조회/취소 화면
	@RequestMapping("/findOrderAndCancel")
	public String findOrderAndCancel(Model model, HttpSession session) throws Exception {
		if (session.getAttribute("customer") != null) {
			List<Order_infoDto> list = oidao.selectAll(((Customer_infoDto) session.getAttribute("customer")).getCust_id());
			model.addAttribute("list", list);
			Map<String, List<Order_detailDto>> map = new HashMap<String, List<Order_detailDto>>();
			for (Order_infoDto i:list) {
					map.put(i.getOrder_id(), oddao.selectAll(i.getOrder_id()));
			}
			model.addAttribute("map", map);
			return "findOrderAndCancel";
		} else {
			System.out.println("로그인 해주세요.");
			return "redirect:/login";
		}
	}
	
	@RequestMapping("/cancelOrder")
	public String cancelOrder(@RequestParam String order_id) throws Exception {
		Order_infoDto oidto = oidao.selectOne(order_id);
		oidto.setOrder_status('F');
		oidao.updateOne(oidto);
		List<Order_detailDto> list = oddao.selectAll(order_id);
		for (Order_detailDto i: list) {
			Product_infoDto pidto = pidao.selectOne(i.getProd_id());
			pidto.setProd_count(pidto.getProd_count() + i.getOrder_count());
			pidao.updateOne(pidto);
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
				
				String originalFileName = pidto.getPicture().getOriginalFilename(); //파일 이름을 수정해보자
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
	
	//찜하기 추가
	@RequestMapping(value="/addChoice")
	@ResponseBody
	public Map<String, Object> addChoice(@RequestBody int prod_id, HttpSession session) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		if (session.getAttribute("customer") != null) {
			
			String cust_id = ((Customer_infoDto) session.getAttribute("customer")).getCust_id();
			Product_choiceDto pcdto = new Product_choiceDto();
			pcdto.setCust_id(cust_id);
			pcdto.setProd_id(prod_id);
			
			int result = pcdao.insertOne(pcdto);
			
			if (result > 0) {
				map.put("isSuceeded", true);
				return map;
			}
			else if (result == 0)  {
				map.put("isSuceeded", "already");
				return map;
			}
			else {
				map.put("isSuceeded", false);
				return map;
			}
		} else {
			System.out.println("로그인 해주세요.");
			map.put("isSuceeded", "login");
			return map; 
		}
	}
	
	//찜하기 화면
	@RequestMapping("/choiceView")
	public ModelAndView choiceView(ModelAndView mav, HttpSession session)throws Exception {
		if (session.getAttribute("customer") != null) {
			String cust_id = ((Customer_infoDto) session.getAttribute("customer")).getCust_id();
		 	Map<String, Object> map = new HashMap<String, Object>();
			List<Product_choiceDto> list = pcdao.selectAll(cust_id);
			List<Product_infoDto> list2 = new ArrayList<Product_infoDto>();
			for (Product_choiceDto i: list) {
				list2.add(pidao.selectOne(i.getProd_id()));
			}
			
			map.put("list", list2);			
			mav.setViewName("choiceView");
			mav.addObject("map", map);
			
			return mav;
			
		} else {
			System.out.println("로그인 해주세요.");
			return mav;
		}
	}
	
	//찜하기 삭제
	@RequestMapping(value="/deleteChoice", method=RequestMethod.POST)
	public void deleteChoice() {
		
	}
	
	//찜하기 전체 삭제
	@RequestMapping(value="/deleteAllChoice", method=RequestMethod.POST)
	public void deleteAllChoice() {
		
	}
	
	//로그인 화면 로그인 버튼 클릭 시
	@RequestMapping(value="/login", method=RequestMethod.POST)
	public String postLogin(@ModelAttribute Customer_infoDto cudto, HttpSession session) throws Exception {
		if(cudto.getCust_id().equals("")) {
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
			System.out.println(cudto.getCust_password());
			System.out.println("비밀번호가 일치하지 않습니다.");
			return "redirect:/login";
		}
	}
	
	@RequestMapping("/logout")
	public String logout(HttpSession session) {
		session.removeAttribute("customer");
		return "redirect:/prodList";
	}
}
