<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰 수정/삭제</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<script type="text/javascript" src="/Ttonamade/resources/js/10-10.js"></script>
<link rel="stylesheet" href="/Ttonamade/resources/css/10-10.css" />
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
	<form name="reviewform" class="reviewform" method="post" enctype="multipart/form-data">
		<div class="wrap">
			<div class="container">
				<table class="border">
					<tr>
						<td>
							<div class="textForm">
								상품명 :
								<c:out value="${dto.prod_name }" />
							</div>
						</td>
						<td>
							<div class="textForm">
								상품번호 :
								<c:out value="${dto.prod_id }" />
							</div>
						</td>
						<td>
							<div class="textForm">
								ෆ이미지 <img class="card-img-top" style="width: 50%; height: 25em;" src="<c:out value="${dto.prod_imgsrc }"/>" alt="..." />
							</div>
						</td>
					</tr>
				</table>
				<input type="hidden" id="prod_id" name="prod_id" value="${dto.prod_id }"> <input type="hidden" id="order_seq" name="order_seq" value="${dto.order_seq }">
			</div>
			<h1>후기</h1>
			<input type="hidden" name="rate" id="rate" value=0 /> <input type="hidden" name="cust_id" id="cust_id" value="${PRDDto.cust_id }" /> <input type="hidden" id="review_imgsrc" name="review_imgsrc" value="<c:out value="${PRDDto.review_imgsrc }"/>" /> <input type="hidden" name="prod_review" id="prod_review" />
			<p class="title_star">별점과 이용경험을 남겨주세요.</p>
			<div class="review_rating rating_point">
				<div class="warning_msg">별점을 선택해 주세요.</div>
				<div class="rating">
					<div class="ratefill"></div>
					<!-- [D] 해당 별점이 선택될 때 그 점수 이하의 input엘리먼트에 checked 클래스 추가 -->
					<input type="checkbox" name="rating" id="rating1" value="1" class="rate_radio" title="1점"> <label for="rating1"></label> <input type="checkbox" name="rating" id="rating2" value="2" class="rate_radio" title="2점"> <label for="rating2"></label> <input type="checkbox" name="rating" id="rating3" value="3" class="rate_radio" title="3점"> <label for="rating3"></label> <input type="checkbox" name="rating" id="rating4" value="4" class="rate_radio" title="4점"> <label for="rating4"></label> <input type="checkbox" name="rating" id="rating5" value="5" class="rate_radio" title="5점"> <label for="rating5"></label>
				</div>
			</div>
			<div class="review_contents" style="width: 100%">
				<div class="warning_msg">5자 이상의 리뷰 내용을 작성해 주세요.</div>
				<textarea rows="10" cols="100" class="prod_review" id="prod_review" name="prod_review"><c:out value="${PRDDto.prod_review }" /> </textarea>
			</div>
			<div class="review_contents">
				<input type="hidden" id="prod_rating" name="prod_rating" value="<c:out value="${PRDDto.prod_rating }"/>" />
			</div>
			<div class="review_contents">
				<div>
					<img id="imscr01" class="card-img-top" width="50" height="150" src="<c:out value="${PRDDto.review_imgsrc }"/>" alt="..." />
				</div>
				<div>
					<input type="file" id="picture" name="picture" onchange="previewFile()" class="picture">
				</div>
			</div>
			<div class="cmd">
				<input type="button" name="Modify" id="Modify" value="수정 "> <input type="button" name="Delete" id="Delete" value="삭제 ">
			</div>
		</div>
	</form>
	<script>
		var newrate = "${PRDDto.prod_rating }";
		rating.rate = "${PRDDto.prod_rating }";
		document.querySelector('.ratefill').style.width = parseInt(newrate * 60)
				+ 'px';
		let items = document.querySelectorAll('.rate_radio');
		items.forEach(function(item, idx) {
			if (idx < newrate) {
				item.checked = true;
			} else {
				item.checked = false;
			}
		});
	</script>
	<script>
		document
				.querySelector('#Delete')
				.addEventListener(
						'click',
						function(e) {

							var sform = document.forms["reviewform"];
							sform.action = "forReviewDelete";
							sform.submit();

							var ses_cust_id = "${sessionScope.customer.cust_id}";
							var ses_cust_manager = "${sessionScope.customer.cust_manager}";
							var doc_cust_id = document
									.getElementById("cust_id").value;

							if ((doc_cust_id != ses_cust_id)
									&& (ses_cust_manager != 'M')) {
								alert("삭제할 수 없는 권한입니다.");
							} else {

								sform.action = "forReviewDelete";
								sform.submit();
							}
						});
	</script>
	<script>
		document
				.querySelector('#Modify')
				.addEventListener(
						'click',
						function(e) {

							var sform = document.forms["reviewform"];
							if (rating.rate == 0) {
								rating.showMessage('rate');
								return false;
							}

							//리뷰 5자 미만이면 메시지 표시
							if (document.querySelector('.prod_review').value.length < 5) {
								rating.showMessage('review');
								return false;
							}

							document.getElementById("prod_rating").value = rating.rate; //별점을 아이디 값에 setting
							var ses_cust_id = "${sessionScope.customer.cust_id}";
							var ses_cust_manager = "${sessionScope.customer.cust_manager}";
							var doc_cust_id = document
									.getElementById("cust_id").value;

							if ((doc_cust_id != ses_cust_id)
									&& (ses_cust_manager != 'M')) {
								alert("수정할 수 없는 권한입니다.");
							} else {

								sform.action = "forReviewUD";
								sform.submit();
							}
						});
	</script>
	<div class="text-center">
		<input type="button" class="btn" value="돌아가기" onclick="history.back(-1)">
	</div>
	<c:import url="footer.jsp" />
</body>
</html>
