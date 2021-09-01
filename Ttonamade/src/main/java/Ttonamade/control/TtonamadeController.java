package Ttonamade.control;

import java.util.List;

import javax.inject.Inject;
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
	
	@RequestMapping("/prodList")
	public String prodList(Model model) throws Exception {
		
		List<Product_infoDto> list = pidao.selectAll();
		model.addAttribute("list", list);
		return "prodList";
	}
	
	@RequestMapping("/cartView")
	public String cartView(int cust_id, Model model) throws Exception {
		List<Cart_infoDto> list = cadao.selectAll(cust_id);
		model.addAttribute("list", list);
		return "cartView";
	}
	
	@RequestMapping("/editCustInfo")
	public String editCustInfo() {
		return "editCustInfo";
	}
	
	@RequestMapping("/findIdAndPw")
	public String findIdAndPw() {
		return "findIdAndPw";
	}
	
	@RequestMapping("/findOrderAndCancel")
	public String findOrderAndCancel() {
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
			return "redirect:/menu";
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
}
