package Ttonamade.control;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import Ttonamade.dao.Cart_infoDao;
import Ttonamade.dao.Customer_infoDao;
import Ttonamade.dao.Order_detailDao;
import Ttonamade.dao.Order_infoDao;
import Ttonamade.dao.Product_infoDao;
import Ttonamade.dto.Cart_infoDto;
import Ttonamade.dto.Customer_infoDto;
import Ttonamade.dto.Order_detailDto;
import Ttonamade.dto.Order_infoDto;
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
	
	//홈 화면
	@RequestMapping("/")
	public String home() {
		return "home";
	}
	
	//로그인 화면
	@RequestMapping("/login")
	public String getlogin() {
		return "login";
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
	
	// 주문 성공 화면
	@RequestMapping("/orderSuccess")
	public String orderSuccess() {
		return "orderSuccess";
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
	
	//상품 등록 화면
	@RequestMapping("/insertProd")
	public String insertProd(HttpSession session) {
		if (session.getAttribute("customer") != null) {
			if (((Customer_infoDto) session.getAttribute("customer")).getCust_manager() == 'M') {
				return "insertProd";
			} else {
				System.out.println("관리자가 아닙니다.");
				return "redirect:/prodList";
			}
		} else {
			System.out.println("로그인 해주세요.");
			return "redirect:/login";
		}
	}
		
	//장바구니 보기 화면
	@RequestMapping("/cartView")
	public String cartView(HttpSession session, Model model) throws Exception {
		
		if (session.getAttribute("customer") != null) {
			String cust_id = ((Customer_infoDto) session.getAttribute("customer")).getCust_id();
			List<Cart_infoDto> list = cadao.selectAll(cust_id);
			model.addAttribute("list", list);
			return "cartView";
		} else {
			System.out.println("로그인 해주세요.");
			return "redirect:/login";
		}
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
			System.out.println("로그인 해주세요.");
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
	@RequestMapping(value="/editCustInfo2", method=RequestMethod.POST)
	public String editCustInfo2(@ModelAttribute Customer_infoDto cudto, HttpSession session) throws Exception {
		if (session.getAttribute("customer") != null) {
			if(cudto.getCust_password().equals(((Customer_infoDto) session.getAttribute("customer")).getCust_password())) {
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
	@RequestMapping("/insertCustInfo2")
	public String insertSave(@ModelAttribute Customer_infoDto custDto, HttpSession session) throws Exception{
		cudao.insertOne(custDto);
		return "redirect:/login";
	}
	
	//아이디, 비밀번호 찾기 화면 찾기 버튼 클릭 시
	@RequestMapping(value="/findId", method=RequestMethod.POST)
	public String findId(@ModelAttribute Customer_infoDto cuDto, HttpServletResponse response) throws Exception {
		
		HashMap<String, String> map = new HashMap<String, String>();	
		map.put("name", cuDto.getCust_name());
		map.put("telephone", cuDto.getCust_telephone());
		map.put("birthday", cuDto.getCust_birthday());
		
		
		System.out.println("이름: "+map.get("name"));
		System.out.println("전화번호: "+map.get("telephone"));
		System.out.println("생년월일: "+map.get("birthday"));
				
		
		String cust_id = cudao.selectOneByNTB(map).getCust_id();
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF");
		PrintWriter out = response.getWriter();
		out.println("<meta charset='UTF-8'><script>alert('회원님의 아이디는 "+ cust_id +"입니다.'); history.go(-1);</script>");
        out.flush();		
		return "redirect:/findIdAndPw";
	}
	
	//아이디, 비밀번호 찾기 화면 찾기 버튼 클릭 시
		@RequestMapping(value="/findPw", method=RequestMethod.POST)
		public String findPw(@ModelAttribute Customer_infoDto cuDto, HttpServletResponse response) throws Exception {
			
			HashMap<String, String> map = new HashMap<String, String>();	
			System.out.println("이름: "+map.get("name"));
			System.out.println("전화번호: "+map.get("telephone"));
			System.out.println("생년월일: "+map.get("birthday"));
			System.out.println("아이디: "+map.get("id"));
			
			String cust_password = cudao.selectOneByNTB(map).getCust_password();
			response.setCharacterEncoding("UTF-8");
			response.setContentType("text/html; charset=UTF");
			PrintWriter out = response.getWriter();
			out.println("<meta charset='UTF-8'><script>alert('회원님의 비밀번호는 "+ cust_password +"입니다.'); history.go(-1);</script>");
	        out.flush();
			return "redirect:/findIdAndPw";
		}
	
	//주문 조회/취소 화면
	@RequestMapping("/findOrderAndCancel")
	public String findOrderAndCancel(Model model, HttpSession session) throws Exception {
		if (session.getAttribute("customer") != null) {
			List<Order_infoDto> list = oidao.selectAll(((Customer_infoDto) session.getAttribute("customer")).getCust_id());
			model.addAttribute("list", list);
			
			List<Order_detailDto> list2 = new ArrayList<Order_detailDto>();
			for (Order_infoDto i:list) {
				list2.add(oddao.selectOne(i.getOrder_id()));
			}
			model.addAttribute("list2", list2);
			
			return "findOrderAndCancel";
		} else {
			System.out.println("로그인 해주세요.");
			return "redirect:/login";
		}
	}
	
	@RequestMapping("/insertProd2")
	public String insertProd2(@ModelAttribute Product_infoDto pidto, HttpSession session) throws Exception {
		if (session.getAttribute("customer") != null) {
			if (((Customer_infoDto) session.getAttribute("customer")).getCust_manager() == 'M') {
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
	
	//주문 저장 화면
	@RequestMapping("/insertOrder")
	public String insertOrder(HttpSession session) throws Exception {
		if (session.getAttribute("customer") != null) {
			System.out.println(((Customer_infoDto) session.getAttribute("customer")).getCust_id());
			cadao.selectOne(((Customer_infoDto) session.getAttribute("customer")).getCust_id());
			return "insertOrder";
		} else {
			System.out.println("로그인 해주세요.");
			return "redirect:/login";
		}
	}
	
	@RequestMapping("/insertOrder2")
	public String insertOrder2(@ModelAttribute Order_detailDto oddto, @ModelAttribute Order_infoDto oidto, HttpSession session) throws Exception {
		if (session.getAttribute("customer") != null) {
			try {
				oddao.insertOne(oddto);
				oidao.insertOne(oidto);
				return "orderSuccess";
			} catch (Exception e) {
				e.printStackTrace();
				return "error";
			}
		} else {
			System.out.println("로그인 해주세요.");
			return "redirect:/login";
		}
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
			
		if (result.getCust_password().equals(cudto.getCust_password())) {
			System.out.println(result.getCust_manager());
			session.setAttribute("customer", result);
			return "redirect:/prodList";
		} else {
			System.out.println("비밀번호가 일치하지 않습니다.");
			return null;
		}
	}
	
	@RequestMapping("/logout")
	public String logout(HttpSession session) {
		session.removeAttribute("customer");
		return "redirect:/prodList";
	}
}
