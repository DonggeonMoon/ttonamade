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
<div style="float:right;"><a href="/Ttonamade/login">로그인</a> <a href="/Ttonamade/insertCustInfo">회원가입</a>${customer.cust_name} (${customer.cust_id })님 <a href="/Ttonamade/cartView">장바구니</a> <a href="/Ttonamade/myPage">마이 페이지</a></div>
<h2>상품 목록</h2>
<table>
	<tr>
		<th>번호</th>
		<th>가격</th>
		<th>평점</th>
		<th>설명</th>
		<th>수량</th>
		<th>게시일</th>
	</tr>
	<c:forEach var="i" items="${list }">
		<c:url var="link" value="/prodView">
			<c:param name="prod_id" value="${i.prod_id }"></c:param>
		</c:url>
		<tr>
			<td>${i.prod_id }</td>
			<td>${i.prod_price }</td>
			<td>${i.prod_rating }</td>
			<td>${i.prod_desc }</td>
			<td>${i.prod_count }</td>
			<td>${i.prod_date }</td>
		</tr>
	</c:forEach>
</table>
<input type="button" value="상품보기" onclick="location.href='/Ttonamade/prodView'">
<input type="button" value="상품등록" onclick="location.href='/Ttonamade/insertProd'">
</body>
</html>
