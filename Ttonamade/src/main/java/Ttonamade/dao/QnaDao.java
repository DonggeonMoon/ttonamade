package Ttonamade.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import Ttonamade.dto.Criteria;
import Ttonamade.dto.QnaDto;

@Repository
public class QnaDao {
	@Inject
	private SqlSession ss;

	private static final String NameSpace = "qnaMapper.";

	public void setSs(SqlSession ss) {
		this.ss = ss;
	}

	// 목록 조회
	public List<QnaDto> selectAll(int startNum, int endNum) throws Exception {
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("startNum", startNum);
		map.put("endNum", endNum);

		return ss.selectList(NameSpace + "selectAll", map);
	}

	// 상세 조회
	public QnaDto selectOne(int qna_id) throws Exception {
		return ss.selectOne(NameSpace + "selectOne", qna_id);
	}

	public List<QnaDto> selectAllByParent(int parent_level) throws Exception {
		return ss.selectList(NameSpace + "selectAllByParent", parent_level);
	}

	public int listCountCriteria(Criteria cri) throws Exception {
		int totalCount = ss.selectOne(NameSpace + "listCountCriteria", cri);
		return totalCount;
	}

	// 글 저장
	public void insertOne(QnaDto qnaDto) throws Exception {
		ss.insert(NameSpace + "insertOne", qnaDto);
	}

	// 댓글 저장
	public void insertComment(QnaDto qnaDto) throws Exception {
		ss.insert(NameSpace + "insertComment", qnaDto);
	}

	// 글 수정
	public void updateOne(QnaDto qnaDto) throws Exception {
		int a = ss.update(NameSpace + "updateOne", qnaDto);
		System.out.println("수정 완료!" + a);
	}

	// 글 삭제
	public void deleteOne(int qna_id) throws Exception {
		ss.delete(NameSpace + "deleteOne", qna_id);
	}

	// 댓글삭제
	public void deleteReply(int qna_id) throws Exception {
		ss.delete(NameSpace + "deleteReply", qna_id);
	}

	// 조회수 증가 처리
	public void read(int qna_id) throws Exception {
		ss.update(NameSpace + "read", qna_id);
	}

}
