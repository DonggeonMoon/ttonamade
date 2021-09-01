<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이 페이지</title>
</head>
<body>
<div style="float:right;"><a href="/Ttonamade/login">로그인</a> <a href="/Ttonamade/insertCustInfo">회원가입</a> <a href="/Ttonamade/cartView">장바구니</a> <a href="/Ttonamade/myPage">마이 페이지</a></div>
<h2>마이 페이지</h2>
<input type="button" value="회원정보 수정/탈퇴" onclick="location.href='/Ttonamade/editCustInfo'">
<input type="button" value="주문 조회/취소" onclick="location.href='/Ttonamade/findOrderAndCancel'">
</body>
</html>