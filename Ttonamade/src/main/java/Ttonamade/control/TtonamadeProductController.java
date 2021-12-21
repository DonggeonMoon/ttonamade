package Ttonamade.control;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.inject.Inject;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;

//장바구니
import Ttonamade.dao.Cart_infoDao;
import Ttonamade.dao.Category_Dao;
//고객정보 저장
import Ttonamade.dao.Customer_infoDao;
import Ttonamade.dao.Order_DetailReviewDao;
//주문디테일정보
import Ttonamade.dao.Order_detailDao;
//주문정보
import Ttonamade.dao.Order_infoDao;
//상품
import Ttonamade.dao.Product_infoDao;
import Ttonamade.dao.Product_reviewDao;
import Ttonamade.dto.Category_Dto; //카테고리 dto
import Ttonamade.dto.Customer_infoDto;
import Ttonamade.dto.Order_DetailReview; // 리뷰 dto 보여주기 뷰
import Ttonamade.dto.ProductSearchDto;
import Ttonamade.dto.Product_infoDto;
import Ttonamade.dto.Product_reviewDto;
import net.sf.json.JSONArray;

@Controller
public class TtonamadeProductController {
	private static final Log log = LogFactory.getLog(TtonamadeProductController.class);

	@Inject
	Customer_infoDao custdao;

	@Inject
	Product_infoDao pidao;

	@Inject
	Cart_infoDao cartdao;

	@Inject
	Order_infoDao orderdao;

	@Inject
	Order_detailDao detaildao;

	@Inject
	Product_reviewDao prodReDao;

	@Inject
	Order_DetailReviewDao detailReviewDao;

	@Inject
	Category_Dao catedao;

	////////////////////////////////////////////////////////////////////////////
	/* 자동 완성 관련 */
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
	/* 상품 관련 */
	// 상품 목록
	@ModelAttribute("list")
	@RequestMapping("/prodList")
	public List<Product_infoDto> prodList(Model model) throws Exception {
		List<Category_Dto> category = catedao.selectAll();
		model.addAttribute("category", JSONArray.fromObject(category));
		return pidao.selectAll();
	}

	// 상품 목록
	@RequestMapping("/prodList1")
	public String prodListCondition(Model model, @RequestParam String catecoderef, @RequestParam String catecode) throws Exception {
		log.info("catecoderef: catecode : " + catecoderef + "" + catecode);
		List<Product_infoDto> list = pidao.selectAllGubun(catecoderef, catecode);
		model.addAttribute("list", list);
		List<Category_Dto> category = catedao.selectAll();
		model.addAttribute("category", JSONArray.fromObject(category));
		return "prodList";
	}
	
	@RequestMapping("/prodList2")
	public String prodList2(Model model, HttpSession session) throws Exception {

		List<Category_Dto> category = catedao.selectAll();
		model.addAttribute("category", JSONArray.fromObject(category));

		String Cust_id = "";
		if (session.getAttribute("customer") != null) {
			Cust_id = (((Customer_infoDto) session.getAttribute("customer")).getCust_id());

		} else {

			model.addAttribute("data", "로그인해주세요.");
			model.addAttribute("url", "login");
			return "prodList2";
		}

		model.addAttribute("list", detailReviewDao.selectAllDetail(Cust_id));
		return "prodList2";
	}
	
	@RequestMapping("/prodListCate")
	public String prodListCate(Model model) throws Exception {
		List<Category_Dto> category = catedao.selectAll();
		model.addAttribute("category", JSONArray.fromObject(category));
		return "header";
	}

	// 상품 보기 화면
	@ModelAttribute("product")
	@RequestMapping("/prodView")
	public Product_infoDto prodView(int prod_id, Model model, HttpSession session) throws Exception {
		List<Category_Dto> category = catedao.selectAll();
		model.addAttribute("category", JSONArray.fromObject(category));

		List<Product_reviewDto> list = prodReDao.selectProdData(prod_id);
		char managergubun = '/';

		if (session.getAttribute("customer") != null) {
			managergubun = ((Customer_infoDto) session.getAttribute("customer")).getCust_manager();
		}

		System.out.println("managergubun 구분값을 알고싶다. " + managergubun);
		model.addAttribute("list", list);
		model.addAttribute("cust", managergubun);
		return pidao.selectOne(prod_id);
	}

	// 주문 조회/취소 화면 버튼 클릭 시
	@RequestMapping(value = "/insertProd2", method = RequestMethod.POST)
	public String insertProd2(MultipartHttpServletRequest request, @ModelAttribute Product_infoDto pidto, HttpSession session) throws Exception {
		if (session.getAttribute("customer") != null) {
			if (((Customer_infoDto) session.getAttribute("customer")).getCust_manager() == 'M') {
				ServletContext sc = request.getServletContext();

				System.out.println(sc.getRealPath("/"));
				System.out.println(sc.getContextPath());

				String originalFileName = pidto.getPicture().getOriginalFilename(); // 파일이름을 수정해보자

				UUID uid = UUID.randomUUID();

				String createdFileName = uid.toString() + "_" + originalFileName;
				String path = sc.getRealPath("/img") + "\\" + createdFileName;

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
			System.out.println("로그인해주세요.");
			return "redirect:/login";
		}
	}
	
	@RequestMapping(value = "/forReviewDelete", method = RequestMethod.POST)
	public String forReviewDelete(Model model, @ModelAttribute Product_reviewDto dto) throws Exception {
		log.info(dto.getProd_id());
		log.info(dto.getCust_id());

		List<Category_Dto> category = catedao.selectAll();
		model.addAttribute("category", JSONArray.fromObject(category));

		prodReDao.deleteOne(dto);
		model.addAttribute("data", "리뷰가 삭제되었습니다.");
		model.addAttribute("url", "prodList2");
		return "prodList2";
	}

	@RequestMapping(value = "/forReviewUD", method = RequestMethod.POST)
	public String forReviewUD(Model model, @ModelAttribute Product_reviewDto dto, MultipartHttpServletRequest request) throws Exception {
		List<Category_Dto> category = catedao.selectAll();
		model.addAttribute("category", JSONArray.fromObject(category));

		dto.setProd_review(dto.getProd_review().replaceAll("\\,", ""));

		if (!dto.getPicture().isEmpty()) {
			ServletContext sc = request.getServletContext();

			System.out.println("sc.getRealPath(\"/\") " + sc.getRealPath("/"));
			System.out.println("sc.getContextPath() " + sc.getContextPath());

			String originalFileName = dto.getPicture().getOriginalFilename(); // 파일이름을 수정해보자

			UUID uid = UUID.randomUUID();

			String createdFileName = uid.toString() + "_" + originalFileName;
			String path = sc.getRealPath("/reviewimg") + "\\" + createdFileName;

			dto.getPicture().transferTo(new File(path));
			dto.setReview_imgsrc("reviewimg/" + createdFileName);

		}

		prodReDao.updateSet(dto);
		pidao.updateProductRanking(dto.getProd_id());

		model.addAttribute("data", "리뷰가 수정되었습니다.");
		model.addAttribute("url", "prodList2");
		return "prodList2";

	}

	// 리뷰 삭제 권한
	@RequestMapping("/reviewDelete")
	public String reviewDelete(Model model, HttpSession session, @RequestParam int order_seq, @RequestParam int prod_id) throws Exception {

		List<Category_Dto> category = catedao.selectAll();
		model.addAttribute("category", JSONArray.fromObject(category));

		if (session.getAttribute("customer") == null) {
			model.addAttribute("data", "로그인해주세요.");
			model.addAttribute("url", "login");
			return "prodView";
		}

		char resultRank = ((Customer_infoDto) (session.getAttribute("customer"))).getCust_manager();
		String data = "";
		if (resultRank == 'M') {

			prodReDao.deleteOne(order_seq, prod_id);
			pidao.updateProductRanking(String.valueOf(prod_id)); // 리뷰업데이트
			data = "관리자 권한으로 리뷰내용를 삭제합니다.";

		} else {
			data = "삭제 권한이 없습니다.";

		}

		model.addAttribute("data", data);
		model.addAttribute("url", "prodView?prod_id=" + prod_id);

		return "prodView";
	}

	@RequestMapping("/forReview")
	public String forReview(Model model, @ModelAttribute Order_DetailReview dto, HttpSession session) throws Exception {
		List<Category_Dto> category = catedao.selectAll();
		model.addAttribute("category", JSONArray.fromObject(category));

		if (session.getAttribute("customer") != null) {

			dto.getProd_name();
			dto.getProd_imgsrc();
			dto.getOrder_seq();
			log.info(dto.getProd_id() + " : 상품번호 ");
			log.info(dto.getOrder_seq() + " : 고객번호 ");
			log.info(dto.getProd_name() + " : 상품명 ");
			log.info(dto.getProd_imgsrc() + " : 상품이미지 ");
			log.info(dto.getOrder_seq() + " : 주문seq ");
			log.info(dto.getCust_id() + " : 고객번호 ");
			int count = 0;
			count = prodReDao.selectOne(dto.getProd_id(), dto.getOrder_seq());
			model.addAttribute("dto", dto);
			log.info("수량 : " + "" + count);

			if (count != 0) {
				Product_reviewDto prdto = new Product_reviewDto();
				prdto = prodReDao.selectOneData(dto.getProd_id(), dto.getOrder_seq());

				model.addAttribute("PRDDto", prdto);
				return "forReviewModify";

			}

			return "forReview";

		} else {
			System.out.println("로그인해주세요.");
			return "redirect:/login";
		}
	}

	@RequestMapping("/forReviewSave")
	public String forReviewSave(Model model, HttpSession session, Product_reviewDto dto, MultipartHttpServletRequest request) throws Exception {
		List<Category_Dto> category = catedao.selectAll();
		model.addAttribute("category", JSONArray.fromObject(category));

		String cust_id = "";
		if (session.getAttribute("customer") != null) {
			cust_id = ((Customer_infoDto) session.getAttribute("customer")).getCust_id();

		} else {
			System.out.println("로그인해주세요.");
			return "redirect:/login";
		}

		dto.setCust_id(cust_id);

		if (!dto.getPicture().isEmpty()) {
			ServletContext sc = request.getServletContext();

			System.out.println("sc.getRealPath(\"/\") " + sc.getRealPath("/"));
			System.out.println("sc.getContextPath() " + sc.getContextPath());

			String originalFileName = dto.getPicture().getOriginalFilename();

			UUID uid = UUID.randomUUID();

			String createdFileName = uid.toString() + "_" + originalFileName;
			String path = sc.getRealPath("/reviewimg") + "\\" + createdFileName;

			dto.getPicture().transferTo(new File(path));
			dto.setReview_imgsrc("reviewimg/" + createdFileName);
		} else {
			dto.setReview_imgsrc("");

		}

		prodReDao.insertOne(dto);
		pidao.updateProductRanking(dto.getProd_id());

		model.addAttribute("data", "리뷰가 등록되었습니다.");
		model.addAttribute("url", "prodList2");

		return "prodList2";
	}

	// 상품 등록 화면
	@RequestMapping("/insertProd")
	public String insertProd(Model model, HttpSession session, HttpServletRequest request) throws Exception {

		model.addAttribute("dto", new Product_infoDto());
		List<Category_Dto> category = catedao.selectAll();
		model.addAttribute("category", JSONArray.fromObject(category));

		if (session.getAttribute("customer") != null) {
			if (((Customer_infoDto) session.getAttribute("customer")).getCust_manager() == 'M') {
				return "insertProd";
			} else {
				System.out.println("관리자가 아닙니다.");
				return "redirect:/prodList";
			}
		} else {
			System.out.println("로그인해주세요.");
			return "redirect:/login";
		}
	}

	// 삭제 버튼을 누르면 prodDataDelete 컨트롤러가 처리한다.
	@RequestMapping(value = "/prodDataDelete", method = RequestMethod.GET)
	@ResponseBody
	public int ProdDataDelete_Method(@RequestParam int prod_id) throws Exception {
		int count = 0;

		count = detaildao.selectOne(prod_id);
		if (count == 0) {
			pidao.deleteOne(prod_id);
			return count;
		}
		return count;
	}

	// 리스트에서 상품 수정 버튼을 클릭할 때 ProdModify 페이지로 이동한다.
	@RequestMapping("/ProdModifychoice")
	public String ProdModifyPage(Model model, HttpSession session) throws Exception {
		if (session.getAttribute("customer") != null) {
			if (((Customer_infoDto) session.getAttribute("customer")).getCust_manager() == 'M') {
				List<Product_infoDto> list = pidao.selectAll();
				model.addAttribute("list", list);
			} else {
				System.out.println("관리자가 아닙니다.");
				return "redirect:/prodList";
			}
		} else {
			System.out.println("로그인해주세요.");
			return "redirect:/login";
		}
		return "ProdModify";
	}

	// 상품 정보를 수정 후 수정 버튼을 누를 때
	@RequestMapping(value = "/ProductUpdate", method = RequestMethod.POST)
	public String ProdModifyOk_Method2(@ModelAttribute Product_infoDto dto, MultipartHttpServletRequest request) throws Exception {

		log.info("상품이름 :" + dto.getProd_name());
		log.info(" 상품 평점 :" + dto.getProd_rating());
		log.info(" 상품 코드 :" + dto.getCateCode());
		log.info(" 상품 이미지 :" + dto.getProd_imgsrc());

		if (!dto.getPicture().isEmpty()) {

			ServletContext sc = request.getServletContext();

			System.out.println("sc.getRealPath(\"/\") " + sc.getRealPath("/"));
			System.out.println("sc.getContextPath() " + sc.getContextPath());

			String originalFileName = dto.getPicture().getOriginalFilename(); // 파일이름을 수정해보자

			UUID uid = UUID.randomUUID();

			String createdFileName = uid.toString() + "_" + originalFileName;
			String path = sc.getRealPath("/img") + "\\" + createdFileName;

			dto.getPicture().transferTo(new File(path));
			dto.setProd_imgsrc("img/" + createdFileName);
		}

		pidao.update(dto);

		return "redirect:/ProdModifychoice";
	}

	// 검색: 상세정보/상세정보 링크 클릭 시
	// boardRead1 페이지로 이동한다.
	@RequestMapping(value = "/prodModifyManager", method = RequestMethod.GET)
	public String ProductInformation_Modify(Model model, @RequestParam int prod_id) throws Exception {

		List<Category_Dto> category = catedao.selectAll();
		model.addAttribute("category", JSONArray.fromObject(category));

		Product_infoDto dto = pidao.selectOne(prod_id);
		model.addAttribute("data", dto);
		return "prodModifyDetail";
	}

	// 조건 검색 버튼을 누를때의 행동을 보여준다.
	@RequestMapping("/productConditionSearch")
	public String ProductCondition_Search(ProductSearchDto dto, Model model) throws Exception {

		log.info("DTO.getSearchOption() :" + dto.getSearchOption());

		if (dto.getSearchOption() == null)
			dto.setSearchOption("prod_name");

		if (dto.getKeyword() == null)
			dto.setKeyword("");

		log.info("dto.setKeyword() :" + dto.getKeyword() + "  : AA");
		log.info(" dto.getSearchOption().toString()   : " + dto.getSearchOption().toString());

		List<Product_infoDto> list = pidao.selectConditioS(dto);
		model.addAttribute("list", list);
		return "ProdModify";
	}

}
