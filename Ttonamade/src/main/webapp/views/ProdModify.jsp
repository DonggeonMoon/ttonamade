<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>상품 수정 및 삭제</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Jua&family=Sunflower:wght@700&display=swap" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style type="text/css">
@import url(https://fonts.googleapis.com/css?family=Roboto:300);

.search-page {
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
	box-shadow: 0 0 20px 0 rgba(0, 0, 0, 0.2), 0 5px 5px 0 rgba(0, 0, 0, 0.24);
}

.section {
	margin: 80px;
}
</style>
<script>
	function chageLangSelect() {
		if (($("#SearchOption option:selected").val()) == 'prod_price') {
			$('#keyword2').show();

		} else {
			$('#keyword2').hide();
		}

	}

	$(document).ready(function() { // 태그 등의 셋팅이 완료되었을 시점에 이벤트 발생

		$('#keyword2').hide();
		if ($("#SearchOption option:selected").val() == 'All') {
			$('#keyword2').hide();
		} else if ($("#SearchOption option:selected").val() == 'prod_name') {
			$('#keyword2').hide();
		} else if ($("#SearchOption option:selected").val() == 'prod_price') {
			$('#keyword2').show();
		} else {
			$("#SearchOption option:selected").val() = 'All';
			$('#keyword2').hide();
		}
	});
</script>
<script>
	function checkForm() {
		if (($("#SearchOption option:selected").val()) != 'All') {

			if (($("#SearchOption option:selected").val()) == 'prod_name') {
				if ($('#keyword').val() == '') {
					alert(" 상품명을 입력하세요. ");
					return false;
				}
			}

			if (($("#SearchOption option:selected").val()) == 'prod_price') {
				if ($('#keyword').val() == '') {
					alert(" 검색 금액을 입력하세요");
					return false;
				}
				if ($('#keyword2').val() == '') {
					alert(" 검색 금액을 입력하세요");
					return false;
				}

				if (isNaN($('#keyword').val()) == true) {
					alert(" 숫자를 입력하세요.");
					return false;
				}

				if (isNaN($('#keyword2').val()) == true) {
					alert(" 숫자를 입력하세요.");
					return false;
				}

			}
			return true;

		}
		return true;
	}
</script>
</head>
<c:import url="header.jsp" />
<c:import url="nav.jsp" />
<div class="text-center">
	<br> <br> <span style="font-family: 'Jua', sans-serif; font-family: 'Sunflower', sans-serif; font-size: 30px;"><strong>수정 및 삭제할 상품을 검색하세요.</strong><br> <br></span>
</div>
<form name="form1" action="productConditionSearch" onsubmit="return checkForm()" class="form-horizontal">
	<div class="form-inline form-group">
		<fieldset>
			<div class="form-control" style="text-align: center">
				<label class="hidden" class="col-sm-10"> 검색분류 </label> <select name="SearchOption" id="SearchOption" onchange="chageLangSelect()">
					<option ${(param.SearchOption=="All")?"selected":"" } value="All">All</option>
					<option ${(param.SearchOption=="prod_name")?"selected":"" } value="prod_name">상품명</option>
					<option ${(param.SearchOption=="prod_price")?"selected":"" } value="prod_price">상품가격</option>
				</select> <input type="text" style="width: 150px" id="keyword" name="keyword"> <input type="text" style="width: 150px" id="keyword2" name="keyword2"> <input type="submit" value="검색" class="btn btn-primary btn-sm">
			</div>
		</fieldset>
	</div>
</form>
<div class="section">
	<div class="container mt-3">
		<table class="table table-hover">
			<tr>
				<th>상품아이디</th>
				<th>상품명</th>
				<th>상품가격</th>
				<th>상품수량</th>
				<th>이미지</th>
				<th>평점</th>
			</tr>
			<c:forEach var="i" items="${list}">
				<c:url var="link" value="prodModifyManager">
					<c:param name="prod_id" value="${i.prod_id}" />
				</c:url>
				<tr>
					<td><a href="${link}"><c:out value="${i.prod_id}" /></a></td>
					<td><a href="${link}"><c:out value="${i.prod_name}" /></a></td>
					<td><fmt:formatNumber>${i.prod_price}</fmt:formatNumber></td>
					<td><c:out value="${i.prod_count}" /></td>
					<td><img height="50px" width="50px" src="<c:out value="${i.prod_imgsrc }"/>" alt="..." /></td>
					<td>
						<div class="d-flex justify-content-center small text-warning mb-2">
							<c:forEach begin="1" end="${i.prod_rating/1 }" step="1">
								<div class="bi-star-fill"></div>
							</c:forEach>
							<c:if test="${i.prod_rating % 1 != 0}">
								<div class="bi-star-half"></div>
							</c:if>
						</div>
					</td>
				</tr>
			</c:forEach>
		</table>
	</div>
</div>
<div class="text-center">
	<input type="button" class="btn" value="돌아가기" onclick="history.back(-1)">
</div>
<c:import url="footer.jsp" />
</body>
</html>