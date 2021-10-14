<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style type="text/css">
body {
	background-image: #34495e;
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
<script>
	var idChk = false;
	var checkedId = "";
	$(document).ready(function() {
		$("#idCheck").click(function() {
			var cust_id = $("#cust_id").val();

			if (cust_id != "") {
				$.ajax({
					async : true,
					type : 'POST',
					data : cust_id,
					url : "idCheck",
					dataType : "json",
					contentType : "application/json; charset=UTF-8",
					success : function(data) {
						if (data.isUnique) {
							alert("사용 가능한 아이디입니다.");
							$("#cust_password").focus();
							idChk = true;
							checkedId = cust_id;
						} else {
							alert("이미 존재하는 아이디입니다.");
							$("#cust_id").focus();
						}
					},
					error : function(error) {
						alert("error: " + error);
					}
				});
			} else {
				alert("아이디를 입력해주세요.");
			}
		});
	});

	function submitForm() {
		if (idChk && checkedId == ($("#cust_id").val())) {

			$("#form1").submit();
		} else {
			alert("아이디 중복 확인을 해주세요.");
		}
	}
</script>
</head>
<body>
	<c:import url="header.jsp" />
	<c:import url="nav.jsp" />
	<section class="container-fluid">
		<div class="text-center">
			<h2 class="m-2">🌷회원가입🌷</h2>
			<form id="form1" class="rounded-3 bg-white border d-inline-block m-2"
				style="width: 500px;" name="form1" action="insertCustInfo2"
				method="POST">
				<div class="text-center">
					<div class="textForm">
						<input id="cust_id" name="cust_id" type="text" class="cust_id"
							placeholder="ෆ아이디"> <input id="idCheck"
							style="float: right; transform: translateY(-100%);" type="button"
							value="ID 중복 확인">
					</div>
					<div class="textForm">
						<input name="cust_password" type="password" class="cust_password"
							placeholder="ෆ비밀번호">
					</div>
					<div class="textForm">
						<input name="loginPwConfirm" type="password" class="cust_password"
							placeholder="ෆ비밀번호 확인">
					</div>
					<div class="textForm">
						<input name="cust_name" type="text" class="cust_name"
							placeholder="ෆ이름">
					</div>
					<div class="textForm">
						<input name="cust_telephone" type="text" class="cust_telephone"
							placeholder="ෆ전화번호">
					</div>
					<div class="textForm">
						<div>ෆ성별</div>
						<div class="form-check form-check-inline">
							<input type="radio" name="cust_sex" class="form-check-input"
								id="male" value="M"><label for="male"
								class="form-check-label">남</label>
						</div>
						<div class="form-check form-check-inline">
							<input type="radio" name="cust_sex" class="form-check-input"
								id="female" value="F"><label for="female"
								class="form-check-label">여</label>
						</div>
					</div>
					<div class="textForm">
						<input name="cust_birthday" type="text" class="cust_birthday"
							placeholder="ෆ생년월일">
					</div>
					<input type="button" class="btn btn-dark m-2" value="JOIN"
						onclick="submitForm();" /> <input type="hidden" value="U">
				</div>
				<div class="alert alert-info my-3">
					관리자로 가입하려면 기존 관리자 아이디와 관리자 비밀번호를<br> 입력하세요.
				</div>
				<div class="textForm">
					<input name="cust_manager_id" type="text" class="cust_birthday"
						placeholder="ෆ관리자_아이디">
				</div>
				<div class="textForm">
					<input name="cust_manager_pw" type="text" class="cust_birthday"
						placeholder="ෆ관리자 비밀번호">
				</div>
				<input type="hidden" name="cust_manager" value="B">
			</form>
		</div>
	</section>
	<c:import url="footer.jsp" />
</body>
</html>