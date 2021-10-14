<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이 페이지</title>
<style type="text/css">
.Btn {
	margin-bottom: 40px;
	width: 15%;
	height: 40px;
	background: linear-gradient(125deg, #ffffcc, #ffccff, #ff99cc);
	background-position: left;
	background-size: 200%;
	color: #212529;
	font-weight: bold;
	text-stroke: 1px red;F
	border: 3px solid #ffcccc;
	cursor: pointer;
	transition: 0.4s;
	display: inline;
}
</style>
</head>
<body>
	<c:import url="header.jsp" />
	<c:import url="nav.jsp" />
	<section class="container-fluid" style="height: 100%">
		<div class="text-center">
			<h2>🌷마이 페이지🌷</h2>
			<input class="Btn" type="button" value="회원정보 수정/탈퇴"
				onclick="location.href='/Ttonamade/editCustInfo'"> <input
				class="Btn text-dark" type="button" value="주문 조회/취소"
				onclick="location.href='/Ttonamade/findOrderAndCancel'"> <input
				class="Btn text-dark" type="button" value="주문상품보기"
				onclick="location.href='/Ttonamade/prodList2'"> <input
				class="Btn text-dark" type="button" value="찜한 상품 보기"
				onclick="location.href='/Ttonamade/choiceView'">
		</div>
	</section>
	<c:import url="footer.jsp" />
</body>
</html>