<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>문의 수정</title>
</head>
<body>
	<c:import url="header.jsp" />
	<c:import url="nav.jsp" />
	<section class="container-fluid p-3">
		<h2 class="text-center m-2">✂게시물 수정 삭제✂</h2>
		<div class="text-center">
			<form style="border-width: 10px !important; width: 40%;" class="container border border-secondary rounded-3 p-4" action="qnaUpdate">
				<div>
					<label class="w-25 p-2">제목</label><input style="border: 5px solid #ffcccc" type="text" class="w-75" name="title" id="title" value="<c:out value="${list.title}"/>" />
				</div>
				<div class="d-flex align-items-centerF">
					<label class="w-25">문의 내용</label>
					<textarea style="border: 5px solid #ffcccc" name="content" class="w-75" id="content" rows="10" cols="50"><c:out value="${list.content}" /></textarea>
				</div>
				<div class="p-2">
					<input type="radio" name="privateFlag" id="privateFlag" value="Y" class="radio" /><span>공개</span> <input type="radio" name="privateFlag" id="privateFlag" value="N" class="radio" /><span>비공개</span>
				</div>
				<div>
					<input type="hidden" name="qna_id" value="${list.qna_id}"> <input type="hidden" name="cust_id" value="${list.cust_id}"> <input type="submit" id="btn" class="btn btn-outline-success" value="수정" />
					<c:if test="${sessionScope.customer != null}">
						<c:if test="${String.valueOf(sessionScope.customer.cust_manager) == 'M'}">
							<a href="/Ttonamade/deleteqnaView?qna_id=${list.qna_id}"><input type="button" class="btn btn-outline-danger" value="삭제" id="btn" /></a>
						</c:if>
					</c:if>
				</div>
			</form>
		</div>
	</section>
	<c:import url="footer.jsp" />
</body>
</html>