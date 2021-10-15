<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보 수정/탈퇴</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style type="text/css">
body {
	background-image: #34495e;
}

.joinForm {
	position: absolute;
	width: 400px;
	height: 400px;
	padding: 30px, 20px;
	background-color: #FFFFFF;
	text-align: left;
	top: 40%;
	left: 50%;
	transform: translate(-50%, -50%);
	border-radius: 15px;
}

.joinForm h2 {
	text-align: center;
	margin: 30px;
}

.textForm {
	border-bottom: 2px solid #adadad;
	margin: 30px;
	padding: 10px 10px;
}

.cust_id {
	width: 100%;
	border: none;
	outline: none;
	color: #636e72;
	font-size: 16px;
	height: 25px;
	background: none;
}

.cust_name {
	width: 100%;
	border: none;
	outline: none;
	color: #636e72;
	font-size: 16px;
	height: 25px;
	background: none;
}

.cust_password {
	width: 100%;
	border: none;
	outline: none;
	color: #636e72;
	font-size: 16px;
	height: 25px;
	background: none;
}

.cust_sex {
	width: 100%;
	border: none;
	outline: none;
	color: #636e72;
	font-size: 16px;
	height: 25px;
	background: none;
}

.cust_telephone {
	width: 100%;
	border: none;
	outline: none;
	color: #636e72;
	font-size: 16px;
	height: 25px;
	background: none;
}

.cust_birthday {
	width: 100%;
	border: none;
	outline: none;
	color: #636e72;
	font-size: 16px;
	height: 25px;
	background: none;
}

.submitBtn {
	position: relative;
	left: 30%;
	transform: translateX(-85%);
	margin-bottom: 40px;
	width: 35%;
	height: 40px;
	background: linear-gradient(125deg, #81ecec, #6c5ce7, #81ecec);
	background-position: left;
	background-size: 200%;
	color: white;
	font-weight: bold;
	border: none;
	cursor: pointer;
	transition: 0.4s;
	display: inline;
}

.btn:hover {
	background-position: right;
}
</style>
</head>
<body>
	<c:import url="header.jsp" />
	<c:import url="nav.jsp" />
	<section class="continer-fluid">
		<div class="text-center">
			<h2 class="m-2">🌷회원정보 수정/탈퇴🌷</h2>
			<form id="form1" class="rounded-3 bg-white border d-inline-block m-2" style="width: 500px;" name="form1" action="editCustInfo2" method="POST">
				<div class="textForm">
					<div>ෆ아이디</div>
					<input type="text" name="cust_id" class="cust_id" value="${list.cust_id}" readonly>
				</div>
				<div class="textForm">
					<div>ෆ이름</div>
					<input type="text" name="cust_name" class="cust_name" value="${list.cust_name}" readonly>
				</div>
				<div class="textForm">
					<div>ෆ전화번호</div>
					<input type="text" name="cust_telephone" class="cust_telephone" value="${list.cust_telephone}">
				</div>
				<div class="textForm">
					<div>ෆ성별</div>
					<div class="form-check form-check-inline">
						<input type="radio" name="cust_sex" class="form-check-input" id="male" value="M" <c:if test="${String.valueOf(list.cust_sex) == 'M'}">checked</c:if>><label for="male" class="form-check-label">남</label>
					</div>
					<div class="form-check form-check-inline">
						<input type="radio" name="cust_sex" class="form-check-input" id="female" value="F" <c:if test="${String.valueOf(list.cust_sex) == 'F'}">checked</c:if>><label for="female" class="form-check-label">여</label>
					</div>
				</div>
				<div class="textForm">
					<div>ෆ생년월일</div>
					<input type="text" name="cust_birthday" class="cust_birthday" value="${list.cust_birthday}">
				</div>
				<div class="textForm">
					<div>ෆ비밀번호</div>
					<input type="password" name="cust_password" class="cust_password" value="${custDto.cust_password}" placeholder="여기에 현재 비밀번호를 입력하고 수정 버튼을 눌러주세요.">
				</div>
				<div class="center">
					<input type="submit" class="btn btn-dark m-2" value="수정"> <input type="button" class="btn btn-secondary m-2" value="돌아가기" onclick="history.back(-1)">
				</div>
				<div>
					<div class="alert alert-info my-3">
						탈퇴하시려면 <a href="/Ttonamade/deleteCustInfo" onclick="return confirm('탈퇴하시겠습니까?')"><span class="badge bg-danger" onclick=" ">여기</span></a>를 눌러주세요.
					</div>
				</div>
			</form>
		</div>
	</section>
	<c:import url="footer.jsp" />
</body>
</html>
