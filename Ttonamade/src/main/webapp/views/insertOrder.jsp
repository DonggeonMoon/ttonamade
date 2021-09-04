<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문 저장</title>
</head>
<body>
<c:import url="header.jsp"/>
<h2>주문 저장</h2>

<form action="insertOrder">
<table>
	<tr>
		<th>제품 ID</th>
		<td><c:out value="${cart.prod_id}"/></td>
		<th>제품 이름</th>
		<td><c:out value="${cart.prod_name}"/></td>
		<th>가격</th>
		<td><c:out value="${cart.prod_price}"/></td>
		<th>재고 수량</th>
		<td><input type="text" name="order_count"></td>
		<td><input type="submit" value="주문 확정"></td>	
	</tr>
	<tr>
		<td><div>주문 수량: <input type="text" name="order_totalAmount"></div></td>
	</tr>
	<tr>
		<td>우편 번호: <input type="text" name="order_zipcode"></td>
	</tr>
	<tr>
		<td>주소: <input type="text" name="order_add1"></td>
	</tr>
	<tr>
		<td>상세 주소: <input type="text" name="order_add2"></td>
	</tr>
	<tr>
		<td>전화번호: <input type="text" name="order_telephone"></td>
	</tr>
	<tr>
	
	
</table>
	<input type="hidden" name="cust_id" value="${sessionScope.customer.cust_id }">
	
	<input type="hidden" name="prod_id" value="${cart.prod_id}">
	<input type="hidden" name="prod_name" value="${cart.prod_name}">
	<input type="hidden" name="prod_price" value="${cart.prod_price}">
	
</form>
<input type="button" value="주문 확정" onclick="location.href='/Ttonamade/orderSuccess'">
</body>
</html>