<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이 페이지</title>
</head>
<body>
<c:import url="header.jsp"/>
<h2>마이 페이지</h2>
<input type="button" value="회원정보 수정/탈퇴" onclick="location.href='/Ttonamade/editCustInfo'">
<input type="button" value="주문 조회/취소" onclick="location.href='/Ttonamade/findOrderAndCancel'">
</body>
</html>