<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰 달기</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="/Ttonamade/resources/css/10-10.css" />
<script type="text/javascript" src="/Ttonamade/resources/js/10-10.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
	function previewFile() {
		var preview = document.getElementById('imscr01');
		var file = document.querySelector('input[type=file]').files[0];
		var reader = new FileReader();

		reader.addEventListener("load", function() {
			preview.src = reader.result;
		}, false);

		if (file) {
			reader.readAsDataURL(file);
		}
	}
</script>
</head>
<body>
	<c:import url="header.jsp" />
	<c:import url="nav.jsp" />
	<form name="reviewform" class="reviewform m-2" action="forReviewSave" method="post" enctype="multipart/form-data">
		<div class="wrap">
			<div class="container">
				<table class="d-inline-block text-left">
					<tr>
						<td>
							<div class="textForm">
								상품명:
								<c:out value="${dto.prod_name }" />
							</div>
						</td>
					<tr>
						<td>
							<div class="textForm">
								상품번호:
								<c:out value="${dto.prod_id }" />
							</div>
						</td>
					</tr>
					<tr>
						<td>
							<div class="textForm">
								ෆ이미지: <img class="card-img-top" style="width: 50%; height: 25em;" src="<c:out value="${dto.prod_imgsrc }"/>" alt="..." />
							</div>
						</td>
					</tr>
				</table>
				<h1 class="text-center m-5">후기</h1>
				<input type="hidden" id="prod_id" name="prod_id" value="${dto.prod_id }" /> <input type="hidden" id="order_seq" name="order_seq" value="${dto.order_seq }" /> <input type="hidden" id="cust_id" name="cust_id" value="${dto.cust_id }" />
			</div>
			<input type="hidden" name="rate" id="rate" value="0" />
			<p class="title_star">별점과 이용경험을 남겨주세요.</p>
			<div class="review_rating rating_point">
				<div class="warning_msg">별점을 선택해 주세요.</div>
				<div class="rating">
					<div class="ratefill"></div>
					<!-- [D] 해당 별점이 선택될 때 그 점수 이하의 input엘리먼트에 checked 클래스 추가 -->
					<input type="checkbox" name="rating" id="rating1" value="1" class="rate_radio" title="1점"> <label for="rating1"></label> <input type="checkbox" name="rating" id="rating2" value="2" class="rate_radio" title="2점"> <label for="rating2"></label> <input type="checkbox" name="rating" id="rating3" value="3" class="rate_radio" title="3점"> <label for="rating3"></label> <input type="checkbox" name="rating" id="rating4" value="4" class="rate_radio" title="4점"> <label for="rating4"></label> <input type="checkbox" name="rating" id="rating5" value="5" class="rate_radio" title="5점"> <label for="rating5"></label>
				</div>
			</div>
			<div class="review_contents">
				<div class="warning_msg">5자 이상의 리뷰 내용을 작성해 주세요.</div>
				<textarea rows="10" cols="100" class="prod_review" id="prod_review" name="prod_review"></textarea>
			</div>
			<input type="hidden" id="prod_rating" name="prod_rating">
			<div class="review_contents">
				<div>파일첨부</div>
				<div>
					<img id="imscr01" src="" height="50" alt="이미지 미리보기...">
				</div>
				<div>
					<input type="file" name="picture" id="picture" onchange="previewFile()" class="picture" />
				</div>
			</div>
			<div class="cmd">
				<input type="button" name="save" id="save" value="등록">
			</div>
		</div>
	</form>
	<script>
		document.querySelector('#save').addEventListener('click', function(e) {

			var sform = document.forms["reviewform"];

			//별점 선택 안했으면 메시지 표시
			if (rating.rate == 0) {
				rating.showMessage('rate');
				return false;
			}
			//리뷰 5자 미만이면 메시지 표시
			if (document.querySelector('.prod_review').value.length < 5) {
				rating.showMessage('review');
				return false;
			}
			//폼 서밋
			//실제로는 서버에 폼을 전송하고 완료 메시지가 표시되지만 저장된 것으로 간주하고 폼을 초기화 함.
			document.getElementById("prod_rating").value = rating.rate;
			var ses_cust_id = "${sessionScope.customer.cust_id}";
			var ses_cust_manager = "${sessionScope.customer.cust_manager}";
			var doc_cust_id = document.getElementById("cust_id").value;

			//alert (document.getElementById("cust_id").value );
			if ((doc_cust_id != ses_cust_id) && (ses_cust_manager != 'M')) {
				alert("삭제할 수 없는 권한입니다.");
			} else {
				sform.action = "forReviewSave";
				sform.submit();
			}
		});
	</script>
	<div class="text-center">
		<input type="button" class="btn btn-warning m-2" value="돌아가기" onclick="history.back(-1)">
	</div>
	<c:import url="footer.jsp" />
</body>
</html>
