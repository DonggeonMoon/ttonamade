<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문 저장</title>
</head>
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
<body>
	<c:import url="header.jsp" />
	<c:import url="nav.jsp" />
	<h2>주문 저장</h2>
	<form action="insertOrder">
		<ul class="list-check-1">
			<li><input type="radio" id="radio-2-1" class="ipt-radio-1" name="pay_method" value="100000000000" checked /> <label for="radio-2-1"><span class="ico-radio"><span></span></span>신용카드</label></li>
			<li><input type="radio" id="radio-2-2" class="ipt-radio-1" name="pay_method" value="010000000000" /> <label for="radio-2-2"><span class="ico-radio"><span></span></span>계좌이체</label></li>
			<li><input type="radio" id="radio-2-3" class="ipt-radio-1" name="pay_method" value="001000000000" /> <label for="radio-2-3"><span class="ico-radio"><span></span></span>가상계좌</label></li>
			<li><input type="radio" id="radio-2-4" class="ipt-radio-1" name="pay_method" value="000010000000" /> <label for="radio-2-4"><span class="ico-radio"><span></span></span>휴대폰</label></li>
		</ul>
		<table>
			<tr>
				<th>제품 ID</th>
				<td><c:out value="${cart.prod_id}" /></td>
				<th>제품 이름</th>
				<td><c:out value="${cart.prod_name}" /></td>
				<th>가격</th>
				<td><c:out value="${cart.prod_price}" /></td>
				<th>재고 수량</th>
				<td><input type="text" name="order_count"></td>
				<td><input type="submit" onclick="jsf__pay( document.order_info )" value="주문 확정"></td>
			</tr>
			<tr>
				<td><div>
						주문 수량: <input type="text" name="order_totalAmount">
					</div></td>
			</tr>
			<tr>
				<td>우편 번호: <input type="text" name="order_zipcode"></td>
			</tr>
			<tr>
				<td>주소: <input type="text" name="order_add1"></td>
			</tr>
			<tr>
				<td>상세 주소: <input type="text" name="order_add2"></td>
			</tr>
			<tr>
				<td>전화번호: <input type="text" name="order_telephone"></td>
			</tr>
			<tr>
		</table>
		<input type="hidden" name="cust_id" value="${sessionScope.customer.cust_id }"> <input type="hidden" name="prod_id" value="${cart.prod_id}"> <input type="hidden" name="prod_name" value="${cart.prod_name}"> <input type="hidden" name="prod_price" value="${cart.prod_price}"> <input type="hidden" name="req_tx" value="pay" /> <input type="hidden" name="site_cd" value="A52YF" /> <input type="hidden" name="site_name" value="KCP TEST SHOP" /> <input type="hidden" name="pay_method" value="">
		<!-- 결제 수단 -->
		<input type="hidden" name="quotaopt" value="12" />
		<!-- 필수 항목 : 결제 금액/화폐단위 -->
		<input type="hidden" name="currency" value="WON" />
		<!-- 표준웹 설정 정보입니다(변경 불가) -->
		<input type="hidden" name="module_type" value="01" /> <input type="hidden" name="res_cd" value="" /> <input type="hidden" name="res_msg" value="" /> <input type="hidden" name="enc_info" value="" /> <input type="hidden" name="enc_data" value="" /> <input type="hidden" name="ret_pay_method" value="" /> <input type="hidden" name="tran_cd" value="" /> <input type="hidden" name="use_pay_method" value="" />
		<!-- 주문정보 검증 관련 정보 : 표준웹 에서 설정하는 정보입니다 -->
		<input type="hidden" name="ordr_chk" value="" />
		<!--  현금영수증 관련 정보 : 표준웹 에서 설정하는 정보입니다 -->
		<input type="hidden" name="cash_yn" value="" /> <input type="hidden" name="cash_tr_code" value="" /> <input type="hidden" name="cash_id_info" value="" />
		<!-- 2012년 8월 18일 전자상거래법 개정 관련 설정 부분 -->
		<!-- 제공 기간 설정 0:일회성 1:기간설정(ex 1:2012010120120131)  -->
		<input type="hidden" name="good_expr" value="0"> <input type="hidden" name="tax_flag" value="TG03">
		<!-- 변경불가    -->
		<input type="hidden" name="comm_tax_mny" value="">
		<!-- 과세금액    -->
		<input type="hidden" name="comm_vat_mny" value="">
		<!-- 부가세     -->
		<input type="hidden" name="comm_free_mny" value="">
		<!-- 비과세 금액 -->
		<input type="hidden" name="skin_indx" value="1"> <input type="hidden" name="kcp_pay_title" value="NHN KCP TEST" /> <input type="hidden" name="disp_tax_yn" value="N">
	</form>
	<input type="button" value="주문 확정" onclick="location.href='/Ttonamade/orderSuccess'">
	<c:import url="footer.jsp" />
</body>
</html>