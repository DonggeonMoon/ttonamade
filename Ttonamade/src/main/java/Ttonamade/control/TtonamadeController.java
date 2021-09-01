package Ttonamade.control;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import Ttonamade.dao.Cart_infoDao;
import Ttonamade.dao.Customer_infoDao;
import Ttonamade.dao.Order_detailDao;
import Ttonamade.dao.Order_infoDao;
import Ttonamade.dao.Product_infoDao;
import Ttonamade.dto.Customer_infoDto;
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
	
	@RequestMapping("/")
	public String home() {
		return "home";
	}
	
	@ModelAttribute("list")
	@RequestMapping("/prodList")
	public List<Product_infoDto> prodList() throws Exception {
		
		List<Product_infoDto> list = pidao.selectAll();
		//model.addAttribute("prodList", list);
		return list;
	}
	
	@RequestMapping("/cartView")
	public String cartView(String cust_id, Model model) throws Exception {
		model.addAttribute("list", cadao.selectAll(cust_id));
		return "cartView";
	}
	
	@RequestMapping("/editCustInfo")
	public String editCustInfo(String cust_id, Model model) throws Exception {
		model.addAttribute(cust_id, cudao.selectOne(cust_id));
		return "editCustInfo";
	}
	
	@RequestMapping("/findIdAndPw")
	public String findIdAndPw() {
		// ajax로 해야하지 않나?(페이지 이동 없이 찾아야...)
		return "findIdAndPw";
	}
	
	@RequestMapping("/findOrderAndCancel")
	public String findOrderAndCancel(Model model, HttpSession session) throws Exception {
		List<Order_infoDto> list = oidao.selectAll(((Customer_infoDto) session.getAttribute("customer")).getCust_id());
		model.addAttribute("list", list);
		return "findOrderAndCancel";
	}
	
	@RequestMapping("/insertCustInfo")
	public String insertCustInfo() {
		
		return "insertCustInfo";
	}
	
	@RequestMapping("/insertOrder")
	public String insertOrder() {
		return "insertOrder";
	}
	
	@RequestMapping("/insertProd")
	public String insertProd() {
		return "insertProd";
	}
	
	@RequestMapping("/login")
	public String getlogin() {
		return "login";
	}
	
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
	
	
	@RequestMapping("/myPage")
	public String myPage() {
		return "myPage";
	}
	
	@RequestMapping("/orderSuccess")
	public String orderSuccess() {
		return "orderSuccess";
	}
	
	@RequestMapping("/prodView")
	public String prodView() {
		
		return "prodView";
	}
	
	@ExceptionHandler(Exception.class)
	public String error() {
		return "error";
	}
	
}
