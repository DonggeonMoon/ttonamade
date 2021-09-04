<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 보기</title>
</head>
<body>
<c:import url="header.jsp"/>
<h2>상품 보기</h2>
<table border="1">
	<tr>
		<th>상품 ID</th>
		<th>상품 이름</th>
		<th>가격</th>
		<th>평점</th>
		<th>상품 설명</th>
		<th>이미지</th>
		<th>재고 수량</th>
		<th>날짜</th>
	</tr>
	<tr>
		<td><c:out value="${product.prod_id }" /></td>
		<td><c:out value="${product.prod_name }" /></td>
		<td><c:out value="${product.prod_price }" /></td>
		<td><c:out value="${product.prod_rating }" /></td>
		<td><c:out value="${product.prod_desc }" /></td>
		<td><c:out value="${product.prod_imgsrc }" /></td>
		<td><c:out value="${product.prod_count }" /></td>
		<td><c:out value="${product.prod_date }" /></td>
	</tr>
</table>
<input type="button" value="주문 저장" onclick="location.href='/Ttonamade/insertOrder'">
</body>
</html>