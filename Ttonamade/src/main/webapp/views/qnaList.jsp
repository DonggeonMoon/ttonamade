<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html xmlns:th="http://www.thymeleaf.org" xmlns:layout="http://www.ultraq.net.nz/thymeleaf/layout" data-layout-decorate="~{samples/layout/sampleLayout}">

<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/js/bootstrap.bundle.min.js"></script>
<title>문의하기</title>
</head>
<body>
	<c:import url="header.jsp" />
	<c:import url="nav.jsp" />
	<h2 class="text-center m-5">🌷게시판🌷</h2>
	<a href="/Ttonamade/qnaInsert"><button type="button" class="btn btn-outline-danger mx-2">작성하기</button></a>
	<br>
	<br>
	<table class="table table-primary table-striped">
		<tr class="bg-secondary" height='50' align='center'>
			<td>번호</td>
			<td>제목</td>
			<td>작성자</td>
			<td>작성일자</td>
			<td>공개여부</td>
		</tr>
		<c:forEach var="i" items="${list}">
			<c:url var="link" value="/qnaView">
				<c:param name="qna_id" value="${i.qna_id}" />
				<c:param name="cust_id" value="${i.cust_id}" />
				<c:param name="privateFlag" value="${i.privateFlag}" />
			</c:url>

			<tr height='50' align='center'>
				<td><c:out value="${i.qna_id}" /></td>
				<td><a href="${link}"><c:out value="${i.title }" /></a></td>
				<td><c:out value="${i.cust_id }" /></td>
				<td><fmt:formatDate pattern="yyyy-MM-dd hh:mm" value="${i.writerDate }" /></td>
				<td><c:if test="${String.valueOf(i.privateFlag) eq 'Y'}"> 
				공개
				</c:if> <c:if test="${String.valueOf(i.privateFlag) eq 'N'}">
				비공개
				</c:if></td>
			</tr>
		</c:forEach>
	</table>
	<form>
		<div class="container mt-3">
			<ul class="pagination">
				<c:if test="${pageMaker.prev eq false}">
					<li class="page-item"><a class="page-link" href="/Ttonamade/qnaList?page=${pageMaker.startPage-1}&perPageNum=${pageMaker.cri.perPageNum}">&laquo;</a></li>
				</c:if>

				<c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="idx">
					<li class="page-item"><a class="page-link" href="/Ttonamade/qnaList?page=${idx}&perPageNum=${pageMaker.cri.perPageNum}">${idx}</a></li>
				</c:forEach>

				<c:if test="${pageMaker.next eq true && pageMaker.endPage > 0}">
					<li class="page-item"><a class="page-link" href="/Ttonamade/qnaList?page=${pageMaker.endPage + 1}&perPageNum=${pageMaker.cri.perPageNum}">&raquo;</a></li>
				</c:if>
			</ul>
		</div>
	</form>
	<c:import url="footer.jsp" />
</body>
</html>