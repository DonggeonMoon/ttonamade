<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>예약주문 리스트</title>
<script>
	function checkForm() {
		if (($("#SearchOption option:selected").val()) != 'All') {
			if ($('#keyword').val() == '') {
				alert(" 시작일을 선택해주세요");
				return false;
			}

			if ($('#keyword2').val() == '') {
				alert("마지막 날짜를 꼭 선택해주세요.");
				return false;
			}
		}
		return true;
	}
</script>
</head>
<body>
	<c:import url="header.jsp" />
	<c:import url="nav.jsp" />
	<div class="center">
		<h2 class="text-center m-5">예약주문을 검색하세요</h2>
	</div>
	<div class="search-page text-center text-black">
		<form name="form1" action="reservationOrderS" onsubmit="return checkForm()">
			<fieldset>
				<legend class="hidden"> </legend>
				<label class="hidden"> 검색분류 </label> <span> <select name="SearchOption" id="SearchOption">
						<option ${(param.SearchOption=="All")?"selected":"" } value="All">All</option>
						<option ${(param.SearchOption=="order_date")?"selected":"" } value="order_date">주문일자</option>
						<option ${(param.SearchOption=="reservation_date")?"selected":"" } value="reservation_date">예약일자</option>
						<option ${(param.SearchOption=="send_date")?"selected":"" } value="send_date">배송일자</option>
				</select><br> <label class="hidden"></label></span>
				<div class="mx-auto">
					<div class="row">
						<div class="col">
							<span> <input type="date" style="width: 200px" id="keyword" name="keyword" type="text" data-sb-can-submit="no"> <input type="date" style="width: 200px" id="keyword2" name="keyword2" type="text" data-sb-can-submit="no"> <input type="submit" value="검색" class="btn btn-outline-info" />
							</span>
						</div>
					</div>
				</div>

			</fieldset>
		</form>
	</div>
	<div class="section">
		<div class="container mt-3">
			<!--  class="list-table" -->
			<div class="text-center">
				<table border="1" style="width: 100%" class="table table-hover">
					<c:forEach var="i" items="${list}">
						<thead>
							<tr>
								<th style="text-align: center">주문번호</th>
								<th style="text-align: center">주 소</th>
								<th style="text-align: center">전화번호</th>
								<th style="text-align: center">주문 총금액</th>
								<th style="text-align: center">주문일</th>
								<th style="text-align: center">예약일자</th>
								<th style="text-align: center">배송일자</th>
							</tr>
						</thead>
						<tr>
							<td style="text-align: center"><c:out value="${i.order_id }" /></td>
							<td style="text-align: center"><c:out value="${i.order_zipcode }" /> <c:out value="${i.order_add1 }" /> <c:out value="${i.order_add2 }" /></td>
							<td style="text-align: center"><c:out value="${i.order_telephone }" /></td>
							<td style="text-align: center"><fmt:formatNumber>${i.order_totalAmount }</fmt:formatNumber></td>
							<td style="text-align: center"><c:out value="${i.order_date }" /></td>
							<td style="text-align: center"><c:out value="${i.reservation_date }" /></td>
							<td style="text-align: center"><c:out value="${i.send_date }" /></td>
						</tr>
						<tr>
							<th style="text-align: center"></th>
							<th style="text-align: center">제품명</th>
							<th style="text-align: center">주문수량</th>
							<th style="text-align: center">주문금액</th>
							<th style="text-align: center">상품이미지</th>
							<th style="text-align: center">삭제</th>
							<th style="text-align: center">수정</th>
						</tr>
						<c:forEach var="j" items="${map.get(i.getOrder_id()) }">
							<tr>
								<td style="text-align: center"></td>
								<td style="text-align: center">${j.prod_name}</td>
								<td style="text-align: center">${j.order_count}</td>
								<td style="text-align: center"><fmt:formatNumber>${j.prod_price }</fmt:formatNumber></td>
								<td style="text-align: center"><img style="width: 15%; height: 2.5em;" src="<c:out value="${j.prod_imgsrc}"/>" /></td>
								<td style="text-align: center"><input type="button" class="btn btn-outline-info" value="수정" onclick="location.href='ResOrderUpdate?Gubun=M&order_id=${j.order_id}'"></td>
								<td style="text-align: center"><input type="button" class="btn btn-outline-info" value="삭제" onclick="location.href='ResOrderUpdate?Gubun=D&order_id=${j.order_id}'"></td>
							</tr>
						</c:forEach>
					</c:forEach>
				</table>
			</div>
		</div>
	</div>
	<script type="text/javascript">
		var message = '${data}';
		var returnUrl = '${url}';

		if (message.length != 0) {
			alert(message);
			document.location.href = returnUrl;
		}
	</script>
</body>
</html>