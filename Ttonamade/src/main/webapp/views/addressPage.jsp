<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문 저장</title>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<style type="text/css">
@import url(https://fonts.googleapis.com/css?family=Roboto:300);

.address-page {
	width: 460px;
	padding: 3% 0 0;
	margin: auto;
}

.form {
	position: relative;
	z-index: 1;
	background: #FFFFFF;
	max-width: 460px;
	margin: 0 auto 100px;
	padding: 45px;
	text-align: center;
	box-shadow: 0 0 20px 0 rgba(0, 0, 0, 0.2), 0 5px 5px 0 rgba(0, 0, 0, 0.24);
}

.form input {
	font-family: "Roboto", sans-serif;
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
<style>
.orderInfo {
	border: 5px solid #eee;
	padding: 20px;
}

.orderInfo .inputArea {
	margin: 10px 0;
}

.orderInfo .inputArea label {
	display: inline-block;
	width: 120px;
	margin-right: 10px;
}

.orderInfo .inputArea input {
	font-size: 14px;
	padding: 5px;
}

.orderInfo .inputArea:last-child {
	margin-top: 30px;
}

.orderInfo .inputArea button {
	font-size: 20px;
	border: 2px solid #ccc;
	padding: 5px 10px;
	background: #fff;
	margin-right: 20px;
}
</style>
<script>
	function showPostCode() {
		new daum.Postcode(
				{
					oncomplete : function(data) {
						var fullAddr = '';
						var extraAddr = '';
						if (data.userSelectedType === 'R') {
							fullAddr = data.roadAddress;

						} else {
							fullAddr = data.jibunAddress;
						}

						if (data.userSelectedType === 'R') {
							if (data.bname !== '') {
								extraAddr += data.bname;

							}
							if (data.buildingName !== '') {
								extraAddr += (extraAddr !== '' ? ','
										+ data.buildingName : data.buildingName);

							}
							fullAddr += (extraAddr !== '' ? '(' + extraAddr
									+ ')' : '');

						}
						document.getElementById('order_zipcode').value = data.zonecode;
						document.getElementById('order_add1').value = fullAddr;
						document.getElementById('order_add2').focus();

					}
				}).open();
	}
</script>
<script>
	//유효성 check
	function checkForm() {
		if ($('#order_zipcode').val() == '') {
			alert(" 우편번호를 반드시 기입해주세요.");
			return false;
		}

		if ($('#order_add1').val() == '') {
			alert(" 주소를 반드시 기입해주세요.");
			return false;
		}

		if ($('#order_add2').val() == '') {
			alert(" 상세주소를 반드시 기입해주세요.");
			return false;
		}

		if ($('#order_telephone').val() == '') {
			alert(" 전화번호를 반드시 기입해주세요.");
			return false;
		}
		return true;
	}
</script>
</head>
<body>
	<c:import url="header.jsp" />
	<c:import url="nav.jsp" />
	<div class="address-page">
		<div class="form">
			<h2 class="m-5">🌷배송지 입력🌷</h2>
			<form name="form1" method="post" action="orderSuccess" onsubmit="return checkForm()">
				ෆ우편 번호: <input name="order_zipcode" id="order_zipcode" onclick="showPostCode()" readonly size="10"><input type="button" onclick="showPostCode()" value="우편번호 찾기"> <br> ෆ주 소 : <input name="order_add1" id="order_add1" size="60"> <br> ෆ상세주소: <input name="order_add2" id="order_add2"> <br> ෆ전화번호: <input name="order_telephone" id="order_telephone">
				<div>
					<span><label id="s1">예약일자</label> <label id="s2">배송일자</label></span>
				</div>
				<div>
					<span><input type="text" id="reservation_date" name="reservation_date" style="width: 100px" /><input type="text" id="send_date" name="send_date" style="width: 100px" /> </span>
				</div>
				<label id="memo">메 모</label>
				<textarea id="reservation_memo" name="reservation_memo" cols="10" rows="5"></textarea>
				<input type="submit" value="주문확정">
			</form>
			<div class="orderOpne">
				<button type="button" class="orderOpne_bnt">예약주문</button>
			</div>
		</div>
		<br> <br>
	</div>
	<div class="orderInfo text-center">
		<form role="form" method="post" autocomplete="off">
			<div class="inputArea">
				<div>
					<span><label for="" style="text-align: center">예약일자</label><label for="" style="text-align: center">배송일자</label></span>
				</div>
				<div>
					<input type="date" id="currentDate1" min="new Date().toISOString().substring(0, 10)"> <input type='date' id='currentDate2' min="new Date().toISOString().substring(0, 10)" />
				</div>
			</div>
			<div class="inputArea">
				<div>
					<span><label for="" style="text-align: center">메모</label></span>
				</div>
				<textarea id="txtmemo" style="width: 400px"></textarea>
			</div>
			<button type="button" id="order_btn" class="btn btn-outline-info">예약</button>
			<button type="button" id="cancel_btn" class="btn btn-outline-info">취소</button>
		</form>
	</div>
	<script>
		$(document).ready(
				function() {
					let today = new Date();
					let yesday = new Date(today - 1);
					yesday.setDate(yesday.getDate());

					document.getElementById('reservation_date').value = yesday
							.toISOString().substring(0, 10);
					document.getElementById('send_date').value = yesday
							.toISOString().substring(0, 10);

					document.getElementById('reservation_memo').value = "";
					document.getElementById('txtmemo').value = "";
					$("#reservation_date").hide();
					$("#send_date").hide();
					$("#s1").hide();
					$("#s2").hide();
					$("#reservation_memo").hide();
					$("#memo").hide();
					$(".orderInfo").slideUp();
					$(".orderOpne_bnt").slideDown();
				});
	</script>
	<script>
		document.getElementById('currentDate1').value = new Date()
				.toISOString().substring(0, 10);
		document.getElementById('currentDate2').value = new Date()
				.toISOString().substring(0, 10);
		document.getElementById('reservation_memo').value = document
				.getElementById('txtmemo').value;
	</script>
	<script>
		$(".orderOpne_bnt").click(function() {
			document.getElementById('reservation_date').value = "";
			document.getElementById('send_date').value = "";
			document.getElementById('reservation_memo').value = "";
			document.getElementById('txtmemo').value = "";
			$("#reservation_date").hide();
			$("#send_date").hide();
			$("#s1").hide();
			$("#s2").hide();
			$("#reservation_memo").hide();
			$("#memo").hide();
			$(".orderInfo").slideDown();
			$(".orderOpne_bnt").slideUp();
		});
	</script>
	<script>
		$("#order_btn")
				.click(
						function() {

							if (new Date().toISOString().substring(0, 10) > document
									.getElementById('currentDate1').value) {
								alert(" 예약날짜를 다시 정해주세요.");
							}

							if (new Date().toISOString().substring(0, 10) > document
									.getElementById('currentDate2').value) {
								alert(" 배송날짜를 다시 정해주세요.");
							}

							if (document.getElementById('currentDate1').value > document
									.getElementById('currentDate2').value) {
								alert(" 예약전에 배송할 수 없습니다.");
							}
							if ((new Date().toISOString().substring(0, 10) <= document
									.getElementById('currentDate1').value)
									&& (new Date().toISOString().substring(0,
											10) <= document
											.getElementById('currentDate2').value)) {

								$("#reservation_date").show();
								$("#send_date").show();
								$("#s1").show();
								$("#s2").show();
								$("#reservation_memo").show();
								$("#memo").show();

								document.getElementById('reservation_date').value = document
										.getElementById('currentDate1').value; // 예약일자
								document.getElementById('send_date').value = document
										.getElementById('currentDate2').value; // 배송일자
								document.getElementById('reservation_memo').value = document
										.getElementById('txtmemo').value
								$(".orderInfo").slideUp();
								$(".orderOpne_bnt").slideDown();

							}
						});
	</script>
	<script>
		$("#cancel_btn").click(
				function() {
					let today = new Date();
					let yesday = new Date(today - 1);
					yesday.setDate(yesday.getDate());

					document.getElementById('reservation_date').value = yesday
							.toISOString().substring(0, 10);
					document.getElementById('send_date').value = yesday
							.toISOString().substring(0, 10);
					document.getElementById('reservation_memo').value = "";
					$("#reservation_date").hide();
					$("#send_date").hide();
					$("#s1").hide();
					$("#s2").hide();
					$("#reservation_memo").hide();
					$("#memo").hide();
					$(".orderInfo").slideUp();
					$(".orderOpne_bnt").slideDown();
				});
	</script>
	<c:import url="footer.jsp" />
</body>
</html>