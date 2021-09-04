<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 등록</title>
</head>
<body>
<c:import url="header.jsp"/>
<h2>상품 등록</h2>
<form action="insertProd2">
	<div>상품 이름: <input type="text" name="prod_name"></div>
	<div>가격: <input type="text" name="prod_price"></div>
	<div>평점: <input type="text" name="prod_rating"></div>
	<div>상품 설명: <input type="text" name="prod_desc"></div>
	<div>이미지: <input type="text" name="prod_imgsrc"></div>
	<div>재고 수량: <input type="text" name="prod_count"></div>
	<input type="submit" value="등록">
</form>
</body>
</html>