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
<script type="text/javascript" src="https://testpay.kcp.co.kr/plugin/payplus_web.jsp"></script>
<script type="text/javascript">
	function m_Completepayment(FormOrJson, closeEvent) {
		var frm = document.order_info;

		GetField(frm, FormOrJson);

		if (frm.res_cd.value == "0000") {
			alert("결제 승인 요청 전,\n\n반드시 결제창에서 고객님이 결제 인증 완료 후\n\n리턴 받은 ordr_chk 와 업체 측 주문정보를\n\n다시 한번 검증 후 결제 승인 요청하시기 바랍니다."); //업체 연동 시 필수 확인 사항.
			/*
			    가맹점 리턴값 처리 영역
			 */

			frm.submit();
		} else {
			alert("[" + frm.res_cd.value + "] " + frm.res_msg.value);

			closeEvent();
		}
	}
</script>
<script type="text/javascript" src="https://testpay.kcp.co.kr/plugin/payplus_web.jsp"></script>
<script type="text/javascript">
	function pay() {

		var frm = document.order_info;

		if (frm.pay_method[0].checked)

		{

			frm.pay_method.value = "100000000000"; //신용카드

		}

		else if (frm.pay_method[1].checked)

		{

			frm.pay_method.value = "010000000000"; //계좌이체

		}

		else if (frm.pay_method[2].checked)

		{

			frm.pay_method.value = "001000000000"; //가상계좌

		} else if (frm.pay_method[3].checked)

		{

			frm.pay_method.value = "000010000000"; //휴대폰

		}
	}
	/* 표준웹 실행 */

	function jsf__pay(form)

	{
		pay();

		try

		{

			KCP_Pay_Execute(form);

		}

		catch (e)

		{

		}

	}
</script>
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
			<form name="order_info" method="post" action="orderSuccess" onsubmit="return checkForm()">
				<div>
					<label for="radio-2-1"><input type="radio" id="radio-2-1" class="ipt-radio-1" name="pay_method" value="100000000000" checked /> <span class="ico-radio"><span></span></span>신용카드</label> <label for="radio-2-2"><input type="radio" id="radio-2-2" class="ipt-radio-1" name="pay_method" value="010000000000" /> <span class="ico-radio"><span></span></span>계좌이체</label> <label for="radio-2-3"><input type="radio" id="radio-2-3" class="ipt-radio-1" name="pay_method" value="001000000000" /> <span class="ico-radio"><span></span></span>가상계좌</label> <label for="radio-2-4"><input type="radio" id="radio-2-4" class="ipt-radio-1" name="pay_method" value="000010000000" /> <span class="ico-radio"><span></span></span>휴대폰</label>
				</div>
				<br> ෆ우편 번호: <input name="order_zipcode" id="order_zipcode" onclick="showPostCode()" readonly size="10"><input type="button" onclick="showPostCode()" value="우편번호 찾기"> <br> ෆ주 소 : <input name="order_add1" id="order_add1" size="60"> <br> ෆ상세주소: <input name="order_add2" id="order_add2"> <br> ෆ전화번호: <input name="order_telephone" id="order_telephone">
				<div>
					<span><label id="s1">예약일자</label> <label id="s2">배송일자</label></span>
				</div>
				<div>
					<span><input type="text" id="reservation_date" name="reservation_date" style="width: 100px" /><input type="text" id="send_date" name="send_date" style="width: 100px" /> </span>
				</div>
				<label id="memo">메 모</label>
				<textarea id="reservation_memo" name="reservation_memo" cols="10" rows="5"></textarea>
				<input type="button" onclick="jsf__pay( document.order_info )" value="주문확정">
				<!-- KCP 발급 사이트(상점)코드 -->
				<input type="hidden" name="site_cd" value="A52YF" />
				<!-- KCP 사이트코드에 부합된 사이트키 -->
				<input type="hidden" name="site_key" value="3grptw1.zW0GSo4PQdaGvsF__" />
				<!-- 쇼핑몰에서 관리하는 회원 ID -->
				<input type="text" name="shop_user_id" value="<c:out value='${sessionScope.customer.cust_id }' />" />
				<!-- 주문자 이름 -->
				<input type="text" name="buyr_name" value="<c:out value='${sessionScope.customer.cust_name }' />" />
				<!-- 상점관리 주문번호 -->
				<input type="text" name="ordr_idxx" value="test_order_12345" />
				<!--  -->
				<input type="hidden" name="req_tx" value="pay" />
				<!-- 상점이름(영문으로 작성권장) -->
				<input type="hidden" name="site_name" value="Ttonamade" />
				<!-- 결제수단코드 -->
				<input type="hidden" name="pay_method" value="">
				<!-- 상품명 -->
				<input type="text" name="good_name" value="TEST상품" />
				<!-- 주문요청금액 -->
				<input type="hidden" name="good_mny" value="1000" />
				<!-- 결제 수단 -->
				<input type="hidden" name="quotaopt" value="12" />
				<!-- 필수 항목 : 결제 금액/화폐단위 -->
				<input type="hidden" name="currency" value="WON" />
				<!-- 표준웹 설정 정보입니다(변경 불가) -->
				<input type="hidden" name="module_type" value="01" />
				<!-- 결과코드 -->
				<input type="hidden" name="res_cd" value="" />
				<!-- 결과메세지 -->
				<input type="hidden" name="res_msg" value="" />
				<!-- 결제창 인증결과 암호화 정보 -->
				<input type="hidden" name="enc_info" value="" />
				<!-- 결제창 인증결과 암호화 정보 -->
				<input type="hidden" name="enc_data" value="" />
				<!-- ret_pay_method -->
				<input type="hidden" name="ret_pay_method" value="" />
				<!-- 결제요청타입 -->
				<input type="hidden" name="tran_cd" value="" />
				<!-- use_pay_method -->
				<input type="hidden" name="use_pay_method" value="" />
				<!-- 주문정보 검증 관련 정보 : 표준웹 에서 설정하는 정보입니다 -->
				<input type="hidden" name="ordr_chk" value="" />
				<!--  현금영수증 관련 정보 : 표준웹 에서 설정하는 정보입니다 -->
				<input type="hidden" name="cash_yn" value="" /> <input type="hidden" name="cash_tr_code" value="" /> <input type="hidden" name="cash_id_info" value="" />
				<!-- 2012년 8월 18일 전자상거래법 개정 관련 설정 부분 -->
				<!-- 제공 기간 설정 0:일회성 1:기간설정(ex 1:2012010120120131)  -->
				<input type="hidden" name="good_expr" value="0"> <input type="hidden" name="tax_flag" value="TG03">
				<!-- 변경불가 -->
				<input type="hidden" name="comm_tax_mny" value="">
				<!-- 과세금액 -->
				<input type="hidden" name="comm_vat_mny" value="">
				<!-- 부가세 -->
				<input type="hidden" name="comm_free_mny" value="">
				<!-- 비과세 금액 -->
				<input type="hidden" name="skin_indx" value="1"> <input type="hidden" name="kcp_pay_title" value="NHN KCP TEST" /> <input type="hidden" name="disp_tax_yn" value="N">
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