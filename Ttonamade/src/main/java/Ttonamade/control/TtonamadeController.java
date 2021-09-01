package Ttonamade.control;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class TtonamadeController {
	
	@RequestMapping("/")
	public String home() {
		return "home";
	}
	
	@RequestMapping("/cartView")
	public String cartView() {
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
	public String login() {
		return "login";
	}
	
	
	@RequestMapping("/myPage")
	public String myPage() {
		return "myPage";
	}
	
	@RequestMapping("/orderSuccess")
	public String orderSuccess() {
		return "orderSuccess";
	}
	
	@RequestMapping("/prodList")
	public String prodList() {
		return "prodList";
	}
	
	@RequestMapping("/prodView")
	public String prodView() {
		return "prodView";
	}
}
