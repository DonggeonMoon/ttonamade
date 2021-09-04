<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 목록</title>
</head>
<body>
<c:import url="header.jsp"/>
<h2>상품 목록</h2>
<table border="1">
	<tr>
		<th>번호</th>
		<th>이름</th>
		<th>가격</th>
		<th>평점</th>
		<th>설명</th>
		<th>이미지</th>
		<th>수량</th>
		<th>게시일</th>
	</tr>
	<c:forEach var="i" items="${list }">
		<c:url var="link" value="/prodView">
			<c:param name="prod_id" value="${i.prod_id }"></c:param>
		</c:url>
		<tr>
			<td>${i.prod_id }</td>
			<td><a href="${link }">${i.prod_name }</a></td>
			<td>${i.prod_price }</td>
			<td>${i.prod_rating }</td>
			<td>${i.prod_desc }</td>
			<td>${i.prod_imgsrc }</td>
			<td>${i.prod_count }</td>
			<td>${i.prod_date }</td>
		</tr>
	</c:forEach>
</table>
<input type="button" value="상품등록" onclick="location.href='/Ttonamade/insertProd'">
</body>
</html>
