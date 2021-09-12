package Ttonamade.control;

import java.io.File;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.inject.Inject;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import Ttonamade.dao.Cart_infoDao;
import Ttonamade.dao.Customer_infoDao;
import Ttonamade.dao.Order_detailDao;
import Ttonamade.dao.Order_infoDao;
import Ttonamade.dao.Product_infoDao;
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
	public String getLogin() {
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
	public String insertCustInfo2(@ModelAttribute Customer_infoDto custdto, HttpSession session) throws Exception{
		cudao.insertOne(custdto);
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
	
	//@RequestMapping("/insertOrder")
	//public String insertOrder() {
	//	return "insertOrder";		
	//}
	
	//아이디, 비밀번호 찾기 화면 찾기 버튼 클릭 시
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
			out.println("<meta charset='UTF-8'><script>alert('일치하는 정보가 없습니다.'); history.go(-1);</script>");
		}
        out.flush();		
		//return "redirect:/findIdAndPw";
	}
	
	//아이디, 비밀번호 찾기 화면 찾기 버튼 클릭 시
	@RequestMapping(value="/findPw", method=RequestMethod.POST)
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
		//return "redirect:/findIdAndPw";
	}
	
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
