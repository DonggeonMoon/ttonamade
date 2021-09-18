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
<header class="masthead2 bg-primary text-center" style="height:350px">
		<div class="">
			<!-- Masthead Avatar Image-->
			<img class="masthead-avatar" src="/Ttonamade/img/Ttonamade.jpg" style="width:200px; height:200px;">
		</div>
</header>
<h2>마이 페이지</h2>
<input type="button" value="회원정보 수정/탈퇴" onclick="location.href='/Ttonamade/editCustInfo'">
<input type="button" value="주문 조회/취소" onclick="location.href='/Ttonamade/findOrderAndCancel'">
<input type="button" value="찜한 상품 보기" onclick="location.href='/Ttonamade/choiceView'">
<c:import url="footer.jsp"/>
</body>
</html>