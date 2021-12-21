<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>예약 정보 수정</title>
<style>
table {
	width: 400px;
	height: 200px;
	margin-left: auto;
	margin-right: auto;
	border: 1px solid #444444;
}
</style>
<meta name="viewport" content="width=device-width, initial-scale=1">
</head>
<body>
	<form name="form1" id="form1">
		<div class="mx-auto">
			<div class="container pt-3">
				<h1>예약정보 수정</h1>
			</div>
			<input type="hidden" id="order_id" name="order_id" value="${orderDto.order_id}">
			<div class="container mt-3">
				<button type="button" class="btn btn-outline-primary">예약일자</button>
				<input type="date" id="reservation_date" name="reservation_date" value="${orderDto.reservation_date}">
			</div>
			<div class="container mt-3">
				<button type="button" class="btn btn-outline-primary">배송일자</button>
				<input type="date" id="send_date" name="send_date" value="${orderDto.send_date}">
			</div>
			<div class="container mt-3">
				<button type="button" class="btn btn-outline-primary">예약메모</button>
			</div>
			<div class="container mt-3">
				<textarea id="reservation_memo" name="reservation_memo" cols="150" rows="5" style="width: 300px"><c:out value="${orderDto.reservation_memo}" /></textarea>
			</div>
			<div class="container mt-3" style="align: center">
				<button type="button" id="btnSave" name="btnSave" class="btn btn-outline-primary">저장</button>
				<button type="button" id="btnCancel" name="btnCancel" class="btn btn-outline-primary" onclick="history.back(-1)">닫기</button>
			</div>
		</div>
	</form>
	<script>
		document
				.querySelector('#btnSave')
				.addEventListener(
						'click',
						function(e) {
							var sform = document.forms["form1"];

							if (document.getElementById("reservation_date").value == "") {
								alert("예약일자를 저장해주세요.");
								return false;
							}

							if (document.getElementById("send_date").value == "") {
								alert("배송일자를 저장해주세요.");
								return false;
							}

							if (new Date().toISOString().substring(0, 10) > document
									.getElementById('reservation_date').value) {
								alert(" 예약 가능한 날이 아닙니다..");
								return false;
							}

							if (new Date().toISOString().substring(0, 10) > document
									.getElementById('send_date').value) {
								alert(" 배송가능한 날이 아닙니다.");
								return false;
							}
							sform.action = "Reservation_Save";
							sform.submit();
						});
	</script>
</body>
</html>