<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>login</title>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<style type="text/css">
@import url(https://fonts.googleapis.com/css?family=Roboto:300);

.login-page {
	width: 360px;
	padding: 3% 0 0;
	margin: auto;
}

.form {
	position: relative;
	z-index: 1;
	background: #FFFFFF;
	max-width: 360px;
	margin: 0 auto 100px;
	padding: 45px;
	text-align: center;
	box-shadow: 0 0 20px 0 rgba(0, 0, 0, 0.2), 0 5px 5px 0
		rgba(0, 0, 0, 0.24);
}

.form input {
	font-family: "Roboto", sans-seriFf;
	outline: 0;
	background: #f2f2f2;
	width: 100%;
	border: 0;
	margin: 0 0 15px;
	padding: 15px;
	box-sizing: border-box;
	font-size: 14px;
}

.form button {
	font-family: "Roboto", sans-serif;
	text-transform: uppercase;
	outline: 0;
	background: #4CAF50;
	width: 100%;
	border: 0;
	padding: 15px;
	color: #FFFFFF;
	font-size: 14px;
	-webkit-transition: all 0.3 ease;
	transition: all 0.3 ease;
	cursor: pointer;
}

.form button:hover, .form button:active, .form button:focus {
	background: #43A047;
}

.form .message {
	margin: 20px 0 0;
	color: #b3b3b3;
	font-size: 12px;
}

.form .message a {
	color: #4CAF50;
	text-decoration: none;
}

.form .register-form {
	display: none;
}

.info {
	margin: 50px auto;
	text-align: center;
}

.info h1 {
	margin: 0 0 15px;
	padding: 0;
	font-size: 36px;
	font-weight: 300;
	color: #1a1a1a;
}

.info span {
	color: #4d4d4d;
	font-size: 12px;
}

.info span a {
	color: #000000;
	text-decoration: none;
}

.info span .fa {
	color: #EF3B3A;
}
</style>
<script type="text/javascript">
	$(function() {
		$('.message a').click(function() {
			$('form').animate({
				height : "toggle",
				opacity : "toggle"
			}, "slow");
			$('#result').css('display', 'none');
		});

		var result = "${result}";
		if (result) {
			if (result === 'OK') {
				$("#myModal").modal('show');
			} else {
				$('form').animate({
					height : "toggle",
					opacity : "toggle"
				}, "fast");
			}
		}
	});
</script>
</head>
<body>
	<c:import url="header.jsp" />
	<c:import url="nav.jsp" />
	<div class="login-page">
		<div class="form">
			<form class="" action="/Ttonamade/login" method="post">
				<div>
					ID: <input type="text" name="cust_id">
				</div>
				<div>
					PW: <input type="password" name="cust_password">
				</div>
				<input type="submit" value="로그인">
			</form>
			<input type="button" value="회원가입"
				onclick="location.href='/Ttonamade/registerAgree'"> <input
				type="button" value="아이디/비밀번호 찾기"
				onclick="location.href='/Ttonamade/findIdAndPw'"> <input
				type="button" value="돌아가기" onclick="history.back(-1)">
		</div>
	</div>
	<c:import url="footer.jsp" />
</body>
</html>