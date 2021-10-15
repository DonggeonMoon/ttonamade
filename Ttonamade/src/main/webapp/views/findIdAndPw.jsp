<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디/비밀번호 찾기</title>
<style type="text/css">
* {
	margin: 0px;
	padding: 0px;
	text-decoration: none;
	font-family: sans-serif;
}

.joinForm {
	position: relative;
	width: 400px;
	height: 300px;
	background-color: #FFFFFF;
	text-align: left;
}

.joinForm2 {
	position: relative;
	width: 400px;
	height: 300px;
	background-color: #FFFFFF;
	text-align: left;
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

.cust_name {
	width: 60%;
	border: none;
	outline: none;
	color: #636e72;
	font-size: 16px;
	height: 25px;
	background: none;
}

.cust_telephone {
	width: 60%;
	border: none;
	outline: none;
	color: #636e72;
	font-size: 16px;
	height: 25px;
	background: none;
}

.cust_birthday {
	width: 60%;
	border: none;
	outline: none;
	color: #636e72;
	font-size: 16px;
	height: 25px;
	background: none;
}

.cust_id {
	width: 60%;
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
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
	$(document).ready(function() {
		$("#find_id_btn").click(function() {
			var json = {
				cust_name : $("#cust_name").val(),
				cust_telephone : $("#cust_telephone").val(),
				cust_birthday : $("#cust_birthday").val(),
			};
			$.ajax({
				async : true,
				type : 'POST',
				data : JSON.stringify(json),
				url : "findId",
				dataType : "json",
				contentType : "application/json; charset=UTF-8",
				success : function(data) {
					alert("회원님의 아이디는 " + data.cust_id + "입니다.");
				},
				error : function(error) {
					console.log(json);
					alert("error: " + error);
				}
			});
		});

		$("#find_pw_btn").click(function() {
			var json = {
				cust_name : $("#cust_name2").val(),
				cust_telephone : $("#cust_telephone2").val(),
				cust_birthday : $("#cust_birthday2").val(),
				cust_id : $("#cust_id").val()
			};
			$.ajax({
				async : true,
				type : 'POST',
				data : JSON.stringify(json),
				url : "findPw",
				dataType : "json",
				contentType : "application/json; charset=UTF-8",
				success : function(data) {
					alert("회원님의 임시 비밀번호는 " + data.temp_cust_pw + "입니다.");
				},
				error : function(error) {
					console.log(json);
					alert("error: " + error);
				}
			});
		});
	});
</script>
</head>
<body>
	<c:import url="header.jsp" />
	<c:import url="nav.jsp" />
	<section class="page-section portfolio" style="height: 900px;">
		<div class="text-center">
			<h2 class="m-5">🌷아이디🌷</h2>
			<form class="d-inline-block" id="form1" name="form1" action="findId" method="POST" class="joinForm">
				<div class="textForm">
					ෆ이름: <input type="text" id="cust_name" name="cust_name" class="cust_name" placeholder="이름" required><br>
				</div>
				<div class="textForm">
					ෆ전화번호: <input type="text" id="cust_telephone" name="cust_telephone" class="cust_telephone" placeholder="전화번호('-' 제외)" required><br>
				</div>
				<div class="textForm">
					ෆ생년월일: <input type="text" id="cust_birthday" name="cust_birthday" class="cust_birthday" placeholder="생년월일 ex)870316" required><br>
				</div>
				<div>
					<input type="button" id="find_id_btn" class="btn2" value="찾기"><br>
				</div>
			</form>
			<h2 class="m-5">🌷비밀번호🌷</h2>
			<form class="d-inline-block" id="form2" name="form2" action="findPw" method="POST" class="joinForm2">
				<div class="textForm">
					ෆ아이디: <input type="text" id="cust_id" name="cust_id" class="cust_id" placeholder="아이디" required><br>
				</div>
				<div class="textForm">
					ෆ이름: <input type="text" id="cust_name2" name="cust_name" class="cust_name" placeholder="이름" required><br>
				</div>
				<div class="textForm">
					ෆ전화번호: <input type="text" id="cust_telephone2" name="cust_telephone" class="cust_telephone" placeholder="전화번호('-' 제외)" required><br>
				</div>
				<div class="textForm">
					ෆ생년월일: <input type="text" id="cust_birthday2" name="cust_birthday" class="cust_birthday" placeholder="생년월일 ex)870316" required><br>
				</div>
				<div>
					<input type="button" id="find_pw_btn" class="btn2" value="찾기">
				</div>
			</form>
		</div>
	</section>
	<c:import url="footer.jsp" />
</body>
</html>