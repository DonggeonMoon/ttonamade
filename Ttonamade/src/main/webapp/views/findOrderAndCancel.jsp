<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문 조회/취소</title>
<style>
/* basket */
.list-table {
	margin: 0 auto;
	position: relative;
	width: 100%;
}

.list-table thead th {
	height: 40px;
	border-top: 2px solid #ffcccc;
	border-bottom: 1px solid #ffcccc;
	font-weight: bold;
	font-size: 17px;
}

.list-table tbody td {
	text-align: center;
	padding: 10px 0;
	border-bottom: 1px solid #CCC;
	height: 20px;
	font-size: 14px
}

.bak_item {
	height: 170px;
	margin-top: 20px;
}
</style>
<script>
	function cateSave(prod_id, prod_name, order_id, order_seq, prod_imgsrc,
			cust_id) {

		var sform = document.forms["form1"];
		document.getElementById("prod_id").value = prod_id;
		document.getElementById("prod_name").value = prod_name;
		document.getElementById("order_id").value = order_id;
		document.getElementById("order_seq").value = order_seq;
		document.getElementById("prod_imgsrc").value = prod_imgsrc;
		document.getElementById("cust_id").value = cust_id;
		sform.action = "forReview";
		sform.method = "GET";
		sform.submit();
	}
</script>
</head>
<body>
	<c:import url="header.jsp" />
	<c:import url="nav.jsp" />
	<h2 class="text-center m-5">🌷주문 조회/취소🌷</h2>
	<div class="container">
		<form name="form1" action="forReview">
			<div class="container pt-3 mx-auto">
				<h1>${customer.cust_name }님의</h1>
				<p>주문하신 상품입니다.</p>
			</div>
			<div class="container pt-3">
				<c:if test="${String.valueOf(customer.cust_manager) eq 'M'}">
					<p>${customer.cust_name }님은 관리자이며, 주문금액 10%의 DC를 받을 수 있습니다.</P>
				</c:if>

				<c:if test="${String.valueOf(customer.cust_manager) eq 'G'}">
					<p>${customer.cust_name }님은 골드 등급, 주문금액 10%의 DC를 받을 수 있습니다.</P>
				</c:if>
				<c:if test="${String.valueOf(customer.cust_manager) eq 'S'}">
					<p>${customer.cust_name }님은 실버 등급이며, 주문금액 5%의 DC를 받을 수 있습니다.</P>
				</c:if>
				<c:if test="${String.valueOf(customer.cust_manager) eq 'B'}">
					<p>${customer.cust_name }님은 브론즈 등급입니다.</P>
				</c:if>
			</div>
			<table class="list-table">
				<c:forEach var="i" items="${list }">
					<thead>
						<tr>
							<th>주문번호</th>
							<th>우편번호</th>
							<th>주소</th>
							<th>상세주소</th>
							<th>주문총금액</th>
							<th>주문일</th>
							<th>전화번호</th>
						</tr>
					</thead>
					<c:if test="${String.valueOf(i.order_status) == 'T' }">
						<tr>
							<td class="text-center">${i.order_id}</td>
							<td class="text-center">${i.order_zipcode }</td>
							<td class="text-center">${i.order_add1 }</td>
							<td class="text-center">${i.order_add2 }</td>
							<td class="text-center"><fmt:formatNumber>${i.order_totalAmount }</fmt:formatNumber></td>
							<td class="text-center">${i.order_date }</td>
							<td class="text-center">${i.order_telephone }</td>
						</tr>
						<tr>
							<th></th>
							<th>주문수량</th>
							<th>제품명</th>
							<th>상품이미지</th>
							<th>주문금액</th>
							<th>삭제</th>
							<th>리뷰</th>
						</tr>
						<c:forEach var="j" items="${map.get(i.getOrder_id()) }">
							<tr>
								<td class="text-center"></td>
								<td class="text-center">${j.order_count}</td>
								<td class="text-center">${j.prod_name}</td>
								<td class="text-center"><img
									style="width: 15%; height: 2.5em;"
									src="<c:out value="${j.prod_imgsrc}"/>" /></td>
								<td class="text-center"><fmt:formatNumber>${j.prod_price }</fmt:formatNumber></td>
								<td class="text-center"><input type="button"
									class="btn btn-outline-info" value="삭제"
									onclick="location.href='cancelOrder?order_id=${j.order_id}'"></td>
								<td class="text-center"><input type="button"
									class="btn btn-outline-info" name="btnSave" id="btnSave"
									value="리뷰"
									onclick="cateSave('${j.prod_id}', '${j.prod_name}', '${j.order_id}', '${j.order_seq}', '${j.prod_imgsrc}', '${j.cust_id}' )"></td>
							</tr>
						</c:forEach>
					</c:if>
				</c:forEach>
				</tbody>
			</table>
			<input type="hidden" id="order_id" name="order_id" /> <input
				type="hidden" id="order_seq" name="order_seq" /> <input
				type="hidden" id="prod_name" name="prod_name" /> <input
				type="hidden" id="prod_imgsrc" name="prod_imgsrc" /> <input
				type="hidden" id="prod_id" name="prod_id" /> <input type="hidden"
				name="cust_id" id="cust_id" />
		</form>
	</div>
	<div class="text-center">
		<input type="button" class="btn btn-warning m-2" value="돌아가기"
			onclick="history.back(-1)">
	</div>
	<c:import url="footer.jsp" />
</body>
</html>