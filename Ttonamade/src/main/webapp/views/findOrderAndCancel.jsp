<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문 조회/취소</title>
</head>
<body>
<c:import url="header.jsp"/>
<h2>주문 조회/취소</h2>
<input type="button" value="돌아가기" onclick="history.back(-1)">
<p>${customer.cust_name } 님의 주문내역입니다.</p>
<table border="1">
	<tr>
		<th>주문번호</th>
		<th>주문금액</th>
		<th>주문일</th>
		<th>우편번호</th>
		<th>주소</th>
		<th>상세주소</th>
		<th>전화번호</th>
	</tr>
	<c:forEach var="i" items="${list }">
		<c:if test="${String.valueOf(i.order_status) == 'T' }">
		<tr>
			<td>${i.order_id}</td>
			<td>${i.order_totalAmount }</td>
			<td>${i.order_date }</td>
			<td>${i.order_zipcode }</td>
			<td>${i.order_add1 }</td>
			<td>${i.order_add2 }</td>
			<td>${i.order_telephone }</td>
		</tr>
		
		<tr>	
			<th colspan="3">주문번호2</th>
			<th>제품아이디</th>
			<th>제품명</th>
			<th>가격</th>
			<th>주문수량</th>
		</tr>
		<c:forEach var="j" items="${list2 }">
			<tr>
				<td colspan="2">${j.order_id}</td>
				<td>${j.order_seq}</td>
				<td>${j.prod_id }</td>
				<td>${j.prod_name }</td>
				<td>${j.prod_price }</td>
				<td>${j.order_count }</td>
			</tr>
		</c:forEach>
		</c:if>
	</c:forEach>
</table>
</body>
</html>