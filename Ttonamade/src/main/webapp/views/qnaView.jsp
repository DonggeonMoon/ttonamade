<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
</head>
<body>
	<c:import url="header.jsp" />
	<c:import url="nav.jsp" />
	<!--게시글상세보기 부분-->
	<section class="container-fluid border p-0">
		<h2 class="text-center m-2">🔍게시글🔍</h2>
		<div class="container border border-secondary rounded-3 p-4 text-center" style="border-width: 10px !important; width: 60%;">
			<table class="border w-100">
				<tr>
					<td style="border: 5px solid #ffcccc" class="w-25 p-2">제목</td>
					<td style="border: 5px solid #ffcccc"><c:out value="${list.title}" /></td>
				</tr>
				<tr>
					<td style="border: 5px solid #ffcccc" class="w-25 p-2">아이디</td>
					<td style="border: 5px solid #ffcccc"><c:out value="${list.cust_id}" /></td>
				</tr>
				<tr height="200" style="word-break: break-all">
					<td style="border: 5px solid #ffcccc" class="w-25 p-2">문의 내용</td>
					<td style="border: 5px solid #ffcccc"><c:out value="${list.content}" /></td>
				</tr>
				<tr>

					<td style="border: 5px solid #ffcccc" colspan="2"><c:if test="${sessionScope.customer.cust_id == list.cust_id}">
							<a href="/Ttonamade/qnaModify?qna_id=${list.qna_id}"><input type="button" class="btn pull-right btn-success" value="수정" id="btn" /></a>
						</c:if> <input type="button" class="btn pull-right btn-secondary" value="돌아가기" id="btn" /></td>
				</tr>
			</table>
			<input type="hidden" name="qna_id" value="${list.qna_id}">
		</div>
		<!--댓글입력 부분-->
		<div class="container" style="width: 50%">
			<form action="insertComment" name="commentForm" method="post">
				<div>
					<div>
						<label class="w-25 p-2"><strong>Comments</strong></label>
					</div>
					<div>
						<div>
							<textarea class="w-100" rows="3" cols="30" id="comment" name="content" placeholder="댓글을 입력하세요"></textarea>
						</div>
						<input name="qna_id" type="hidden" value="${list.qna_id }"> <input type="hidden" id="child_level" name="child_level" value="${list.child_level }" />
						<div style="float: right;">
							<a href='#' onClick="commentForm.submit()" class="btn pull-right btn-success">등록</a>
						</div>
					</div>
				</div>
			</form>
		</div>
		<!--댓글목록 부분-->
		<div class="m-2">댓글목록</div>
		<table class="table table-primary table-striped text-center">

			<c:forEach var="i" items="${list2}">
				<tr>

					<td colspan="2"><c:out value="${i.cust_id }" /></td>
					<td></td>
					<td><c:out value="${i.content }" /></td>
					<td><fmt:formatDate pattern="yyyy-MM-dd hh:mm" value="${i.writerDate }" /></td>
					<td><input type="button" class="btn btn-outline-danger" value="삭제" onclick="location.href='/Ttonamade/deleteComment?board_qna_id=<c:out value="${list.qna_id}"/>&qna_id=<c:out value="${i.qna_id}"/>'" /></td>
				</tr>
				<c:forEach var="j" items="${map.get(i.child_level) }">
					<tr>
						<td colspan="3"><c:out value="↳${j.cust_id }" /></td>
						<td><c:out value="${j.content }" /></td>
						<td><fmt:formatDate pattern="yyyy-MM-dd hh:mm" value="${j.writerDate }" /></td>
						<td><input type="button" class="btn btn-outline-danger" value="삭제" onclick="location.href='/Ttonamade/deleteComment2?board_qna_id=<c:out value="${list.qna_id}"/>&qna_id=<c:out value="${j.qna_id}"/>'" /></td>
					</tr>
				</c:forEach>
				<tr>
					<td colspan="6">
						<form action="insertComment2" method="get">
							<textarea maxlength="1000" style="width: 40%" rows="2" cols="30" id="content" name="content" placeholder="답글을 입력하세요"></textarea>
							<input type="hidden" id="qna_id" name="qna_id" value="${i.qna_id }" /> <input type="hidden" id="parent_level" name="parent_level" value="${i.parent_level }" /> <input type="hidden" id="board_qna_id" name="board_qna_id" value="${list.qna_id }" /> <input type="hidden" id="child_level" name="child_level" value="${i.child_level }" /> <input type="submit" class="btn btn-outline-success" value="답글 쓰기" />
						</form>
					</td>
				</tr>
			</c:forEach>
		</table>
	</section>
	<c:import url="footer.jsp" />
</body>
</html>