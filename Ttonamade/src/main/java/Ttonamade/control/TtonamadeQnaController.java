package Ttonamade.control;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import Ttonamade.dao.Category_Dao;
import Ttonamade.dao.QnaDao;
import Ttonamade.dto.Category_Dto;
import Ttonamade.dto.Criteria;
import Ttonamade.dto.Customer_infoDto;
import Ttonamade.dto.PageMaker;
import Ttonamade.dto.QnaDto;
import net.sf.json.JSONArray;

@Controller
public class TtonamadeQnaController {
	private static final Log log = LogFactory.getLog(TtonamadeProductController.class);

	@Inject
	QnaDao qdao;

	@Inject
	Category_Dao catedao;

	// 게시글 상세 조회
	@RequestMapping("/qnaView")
	public String qnaList(@ModelAttribute QnaDto qnaDto, @RequestParam int qna_id, @RequestParam String cust_id, HttpSession session, Model model) throws Exception {
		List<Category_Dto> category = catedao.selectAll();
		model.addAttribute("category", JSONArray.fromObject(category));
		if (session.getAttribute("customer") != null) {
			char cust_manager = ((Customer_infoDto) session.getAttribute("customer")).getCust_manager();
			char privateFlag = qnaDto.getPrivateFlag();
			String cust_id2 = ((Customer_infoDto) session.getAttribute("customer")).getCust_id();
			QnaDto result = qdao.selectOne(qna_id);

			if (cust_id2.equals(cust_id) || cust_manager == 'M' || privateFlag == 'Y') {
				model.addAttribute("list", result);

				int parent_level = result.getChild_level();
				List<QnaDto> result2 = qdao.selectAllByParent(parent_level);
				model.addAttribute("list2", result2);

				Map<Integer, Object> map = new HashMap<Integer, Object>();
				for (QnaDto i : result2) {
					map.put(i.getChild_level(), qdao.selectAllByParent(i.getChild_level()));
				}

				model.addAttribute("map", map);
				return "qnaView";
			} else {
				return "accessDenied";
			}
		} else {
			System.out.println("로그인 해주세요.");
			return "redirect:/login";
		}
	}

	// 게시글 수정 화면
	@RequestMapping("/qnaModify")
	public String qnaModity(int qna_id, HttpSession session, Model model) throws Exception {
		List<Category_Dto> category = catedao.selectAll();
		model.addAttribute("category", JSONArray.fromObject(category));

		QnaDto qnadto = new QnaDto();
		qnadto.setQna_id(qna_id);
		model.addAttribute("list", qdao.selectOne(qna_id));
		return "qnaModify";
	}

	// 게시글 작성하기
	@RequestMapping("/qnaInsert")
	public String qnaInsert(HttpSession session, Model model) throws Exception {
		List<Category_Dto> category = catedao.selectAll();
		model.addAttribute("category", JSONArray.fromObject(category));

		if (session.getAttribute("customer") != null) {
			return "qnaInsert";
		} else {
			return "redirect:/login";
		}
	}

	// 게시글 등록
	@RequestMapping("/qnaInsert2")
	public String qnainsert2(@ModelAttribute QnaDto qnaDto, HttpSession session) throws Exception {
		String cust_id = ((Customer_infoDto) session.getAttribute("customer")).getCust_id();
		qnaDto.setCust_id(cust_id);
		String title = qnaDto.getTitle();
		String content = qnaDto.getContent();
		char privateflag = qnaDto.getPrivateFlag();

		if (title == "" || content == "" || privateflag == 0) {
			return "accessDenied2";

		} else {
			qdao.insertOne(qnaDto);
			return "redirect:/qnaList";
		}
	}

	// 수정 버튼 클릭 시
	@RequestMapping("/qnaUpdate")
	public String qnaUpdate(@ModelAttribute QnaDto qnaDto, HttpSession session) throws Exception {
		String title = qnaDto.getTitle();
		String content = qnaDto.getContent();
		char privateflag = qnaDto.getPrivateFlag();
		if (title == "" || content == "" || privateflag == 0) {
			return "accessDenied2";
		} else {
			qdao.updateOne(qnaDto);
			return "redirect:/qnaView?qna_id=" + qnaDto.getQna_id() + "&cust_id=" + qnaDto.getCust_id();
		}
	}

	// 게시판 조회(글 작성하기 버튼)
	@RequestMapping("/qnaList")
	public String qnaList(@ModelAttribute("cri") Criteria cri, Model model) throws Exception {
		List<Category_Dto> category = catedao.selectAll();
		model.addAttribute("category", JSONArray.fromObject(category));
		List<QnaDto> list = qdao.selectAll(((cri.getPage() - 1) * cri.getPerPageNum() + 1), (cri.getPage() * cri.getPerPageNum()));
		model.addAttribute("list", list); // 게시판의 글 리스트
		log.info("startpage" + ((cri.getPage() - 1) * cri.getPerPageNum() + 1) + "ppn:" + (cri.getPage() * cri.getPerPageNum()) + "size" + list.size());
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(qdao.listCountCriteria(cri));
		model.addAttribute("pageMaker", pageMaker);
		return "qnaList";
	}

	// 게시글 삭제 화면
	@RequestMapping("/deleteqnaView")
	public String deleteCustInfo(int qna_id, HttpSession session) throws Exception {
		char cust_manager = ((Customer_infoDto) session.getAttribute("customer")).getCust_manager();
		if (cust_manager == 'M') {
			qdao.deleteOne(qna_id);
		} else {
			return "accessDenied";
		}
		return "redirect:/qnaList";
	}

	// 댓글 작성
	@RequestMapping("/insertComment")
	public String insertComment(@ModelAttribute QnaDto qnaDto, HttpSession session) throws Exception {
		String cust_id = ((Customer_infoDto) session.getAttribute("customer")).getCust_id();
		qnaDto.setCust_id(cust_id);
		String content = qnaDto.getContent();
		if (content == "") {
			return "accessDenied3";
		} else {
			qdao.insertComment(qnaDto);
		}
		return "redirect:/qnaView?qna_id=" + qnaDto.getQna_id() + "&cust_id=" + cust_id;
	}

	// 대댓글 작성
	@RequestMapping("/insertComment2")
	public String insertComment2(@ModelAttribute QnaDto qnaDto, int board_qna_id, HttpSession session) throws Exception {
		qnaDto.setParent_level(qnaDto.getChild_level());
		String cust_id = ((Customer_infoDto) session.getAttribute("customer")).getCust_id();
		qnaDto.setCust_id(cust_id);
		String content = qnaDto.getContent();
		if (content == "") {
			return "accessDenied3";
		} else {
			qdao.insertComment(qnaDto);
		}
		return "redirect:/qnaView?qna_id=" + board_qna_id + "&cust_id=" + cust_id;
	}

	// 댓글 삭제
	@RequestMapping("/deleteComment")
	public String deleteComment(@RequestParam int board_qna_id, @RequestParam int qna_id, HttpSession session) throws Exception {
		String cust_id = ((Customer_infoDto) session.getAttribute("customer")).getCust_id();
		qdao.deleteReply(qna_id);
		return "redirect:/qnaView?qna_id=" + board_qna_id + "&cust_id=" + cust_id;
	}

	// 대댓글 삭제
	@RequestMapping("/deleteComment2")
	public String deleteComment2(@RequestParam int board_qna_id, @RequestParam int qna_id, HttpSession session) throws Exception {
		String cust_id = ((Customer_infoDto) session.getAttribute("customer")).getCust_id();
		qdao.deleteReply(qna_id);
		return "redirect:/qnaView?qna_id=" + board_qna_id + "&cust_id=" + cust_id;
	}
}