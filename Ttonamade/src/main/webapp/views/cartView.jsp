<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Ttonamade</title>
</head>
<body>
<c:import url="header.jsp"/>
<h2>장바구니</h2>
	<table border="1">
	
		<tr>
			<td>장바구니 ID</td>
		
			<td>회원 ID</td>
		
			<td>상품 아이디</td>
		
			<td>상품 이름</td>
		
			<td>재고 수량</td>

			<td>상품 가격</td>
		</tr>
		<tr>
			<c:forEach var="i" items="${list }" >
				<c:url var="link" value="/prodView">
					<c:param name="prod_id" value="${i.prod_id }"/>
				</c:url> 
				<td><c:out value="${i.cart_id }" /></td>
				<td><c:out value="${i.cust_id }" /></td>
				<td><c:out value="${i.prod_id }" /></td>
				<td><a href="${link }"><c:out value="${i.prod_name }" /></a></td>
				<td><c:out value="${i.prod_count }" /></td>
				<td><c:out value="${i.prod_price }" /></td>
			</c:forEach>
		</tr>

	</table>
	<a href="#" onclick="history.back(-1)">돌아가기</a>
	<a href="boardDelete?cart_id=<c:out value="${cart_id }" />">삭제</a>
	<a href="update?cart_id=<c:out value="${cart_id }" />">수정</a>
</body>
</html>