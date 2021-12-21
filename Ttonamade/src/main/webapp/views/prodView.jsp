<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 보기</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
	function cartSave(prod_id, prod_name, prod_rating, prod_count, prod_price) {

		var sform = document.forms["form1"];

		document.getElementById("prod_id").value = prod_id;
		document.getElementById("prod_name").value = prod_name;
		document.getElementById("prod_count").value = prod_count;
		document.getElementById("prod_price").value = prod_price;

		var m = parseInt(document.getElementById("prod_count").value);//재고수량
		var mm = parseInt(document.getElementById("inputQuantity").value); //받은값

		if (m < mm) {
			alert("재고가 부족합니다.");
		} else {
			document.getElementById("prod_count").value = document
					.getElementById("inputQuantity").value;
			alert("장바구니 페이지로 이동합니다.");
			sform.action = "checkCart";
			sform.submit();
		}
	}
</script>
<script>
	$(document).ready(function() {
		$("#btnAddChoice").click(function() {
			var prod_id = "<c:out value="${product.prod_id }"/>";
			$.ajax({
				async : true,
				url : "addChoice",
				type : "POST",
				data : prod_id,
				contentType : "application/json; charset=UTF-8",
				dataType : "json"
			}).done(function(data) {
				if (data.isSuceeded == "suceeded")
					alert("찜하기 성공");
				else if (data.isSuceeded == "login")
					alert("로그인 후 이용해주세요");

				else if (data.isSuceeded == "already")
					alert("이미 등록 되었습니다.");
				else
					alert("찜하기 실패");
			}).fail(function(error, data) {
				alert("error: " + error + data);
			})
		});
	});
</script>

<style>
table.type07 {
	border-collapse: collapse;
	text-align: left;
	line-height: 1.5;
	border: 1px solid #ccc;
	margin: 20px 10px;
}

table.type07 thead {
	border-right: 1px solid #ccc;
	border-left: 1px solid #ccc;
	background: #e7708d;
}

table.type07 thead th {
	padding: 10px;
	font-weight: bold;
	vertical-align: top;
	color: #fff;
}

table.type07 tbody th {
	width: 150px;
	padding: 10px;
	font-weight: bold;
	vertical-align: top;
	border-bottom: 1px solid #ccc;
	background: #fcf1f4;
}

table.type07 td {
	width: 350px;
	padding: 10px;
	vertical-align: top;
	border-bottom: 1px solid #ccc;
}
</style>
</head>
<body>
	<c:import url="header.jsp" />
	<c:import url="nav.jsp" />
	<form name="form1">
		<input type="hidden" id="prod_id" name="prod_id"> <input type="hidden" id="prod_name" name="prod_name"> <input type="hidden" id="prod_count" name="prod_count"> <input type="hidden" id="prod_price" name="prod_price">
		<!-- Product section-->
		<section class="py-5">
			<div class="container px-4 px-lg-5 my-5">
				<div class="row gx-4 gx-lg-5 align-items-center">
					<div class="col-md-6">
						<img class="card-img-top mb-5 mb-md-0" style="width: 400px; height: 400px;" src="<c:out value="${product.prod_imgsrc }"/>" alt="..." />
					</div>
					<div class="col-md-6">
						<div class="small mb-1">
							제품 번호:
							<c:out value="${product.prod_id }" />
						</div>
						<h1 class="display-5 fw-bolder">
							<c:out value="${product.prod_name }" />
						</h1>
						<div class="fs-5 mb-5">
							<span><fmt:formatNumber value="${product.prod_price }" type="currency" /></span>
						</div>
						<div class="d-flex justify-content-left small text-warning mb-2">
							<c:forEach begin="1" end="${product.prod_rating/1}" step="1">
								<div class="bi-star-fill"></div>
							</c:forEach>
							<c:if test="${product.prod_rating % 1 != 0}">
								<div class="bi-star-half"></div>
							</c:if>
						</div>
						<p class="lead">
							<c:out value="${product.prod_desc }" />
						</p>
						<p class="lead" style="width: 300px">
							재고 수량:
							<c:out value="${product.prod_count }" />
						</p>
						<p class="lead">
							등록일:
							<c:out value="${product.prod_date }" />
						</p>
						<div class="d-flex">
							<input class="form-control text-center me-3" id="inputQuantity" type="number" value="1" style="max-width: 3rem" />
							<button class="btn btn-outline-dark flex-shrink-0" type="button" id="btnSave" value="주문하기" onclick="cartSave('${product.prod_id}', '${product.prod_name}', '${product.prod_rating}', '${product.prod_count}','${product.prod_price}'   )">주문하기</button>
							<button class="btn btn-outline-dark flex-shrink-0 mx-2" type="button" id="btnAddChoice">찜하기</button>

						</div>
					</div>
				</div>
			</div>
		</section>
		<section class="py-5">
			<div class="container px-4 px-lg-5 my-5">

				<div class="row gx-4 gx-lg-5 align-items-center">
					<table class="type07">
						<thead>
							<tr>
								<th>작성자</th>
								<th>별점</th>
								<th>내용</th>
								<th>이미지</th>
								<c:if test="${fn:contains(cust, 'M')}">
									<th>삭제</th>
								</c:if>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="i" items="${list }">
								<tr>
									<th scope="row"><c:out value="${i.cust_id}" /></th>
									<td class="fs-5 mb-5"><span> <c:forEach begin="1" end="${i.prod_rating}" step="1">
												<span class="bi-star-fill"></span>
											</c:forEach>
									</span></td>
									<td><c:out value="${i.prod_review}" /></td>
									<td><img style="width: 10%; height: 2em;" src="<c:out value="${i.review_imgsrc}"/>" /></td>
									<c:if test="${fn:contains(cust, 'M')}">
										<td><input type="button" class="btn btn-outline-danger" name="Delete" value="삭제" onclick="location.href='reviewDelete?order_seq=${i.order_seq }&prod_id=${i.prod_id}'"></td>
									</c:if>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
		</section>
	</form>
	<script type="text/javascript">
		var message = '${data}';
		var returnUrl = '${url}';

		if (message.length != 0) {
			alert(message);
			document.location.href = returnUrl;
		}
	</script>
	<!-- 최근 본 상품 목록 스크립트 -->
	<script>
		let id = "<c:out value='${product.prod_id}' />";
		let name = "<c:out value='${product.prod_name}' />";
		let imgsrc = "<c:out value='${product.prod_imgsrc}' />";
		let timestamp = new Date().getTime();
		let map = {
			'id' : id,
			'name' : name,
			'imgsrc' : imgsrc,
			'timestamp' : timestamp
		};
		let data = localStorage.getItem('Ttonamade');

		if (data != null) {
			data = JSON.parse(localStorage.getItem('Ttonamade'));
			data[id] = map;
			localStorage.setItem('Ttonamade', JSON.stringify(data));
		} else {
			data = {};
			data[id] = map;
			localStorage.setItem('Ttonamade', JSON.stringify(data));
		}
	</script>
	<c:import url="footer.jsp" />
</body>
</html>