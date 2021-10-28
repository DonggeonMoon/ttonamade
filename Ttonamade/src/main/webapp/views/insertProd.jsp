<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 등록</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style type="text/css">
body {
	background-image: #34495e;
}

.joinForm {
	position: absolute;
	width: 400px;
	height: 400px;
	padding: 30px, 20px;
	background-color: #FFFFFF;
	text-align: left;
	top: 40%;
	left: 50%;
	transform: translate(-50%, -50%);
	border-radius: 15px;
}

.joinForm h2 {
	text-align: center;
	margin: 30px;
}

.textForm {
	border-bottom: 2px solid #adadad;
	margin: 30px;
	padding: 10px 10px;
}

.prod_name {
	width: 100%;
	border: none;
	outline: none;
	color: #636e72;
	f: 16px;
	height: 25px;
	background: none;
}

.prod_price {
	width: 100%;
	border: none;
	outline: none;
	color: #636e72;
	font-size: 16px;
	height: 25px;
	background: none;
}

.prod_rating {
	width: 100%;
	border: none;
	outline: none;
	color: #636e72;
	font-size: 16px;
	height: 25px;
	background: none;
}

.prod_desc {
	width: 100%;
	border: none;
	outline: none;
	color: #636e72;
	font-size: 16px;
	height: 25px;
	background: none;
}

.picture {
	width: 100%;
	border: none;
	outline: none;
	color: #636e72;
	font-size: 16px;
	height: 30px;
	background: none;
}

.prod_imgsrc {
	width: 100%;
	border: none;
	outline: none;
	color: #636e72;
	font-size: 16px;
	height: 25px;
	background: none;
}

.prod_count {
	width: 100%;
	border: none;
	outline: none;
	color: #636e72;
	font-size: 16px;
	height: 25px;
	background: none;
}

.submitBtn {
	position: relative;
	left: 30%;
	transform: translateX(-85%);
	margin-bottom: 40px;
	width: 35%;
	height: 40px;
	background: linear-gradient(125deg, #81ecec, #6c5ce7, #81ecec);
	background-position: left;
	background-size: 200%;
	color: white;
	font-weight: bold;
	border: none;
	cursor: pointer;
	transition: 0.4s;
	display: inline;
}

.btn:hover {
	background-position: right;
}
</style>
<script>
	$(document).ready(function() {
		var formObj = $("#dto");

		$("#btnRegister").on("click", function() {
			formObj.attr("action", "insertProd2");
			formObj.attr("method", "post");
			formObj.submit();
		});
	});
</script>
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
	<section class="continer-fluid text-center">
		<h2 class="text-center m-5">🌷상품 등록🌷</h2>
		<div class="text-center">
			<div class="container_box">
				<div class="container">
					<label>1차 분류</label> <select class="category1" style="width: 100px">
						<option value="">전체</option>
					</select> <label>2차 분류</label> <select class="category2" name="cateCode" style="width: 100px">
						<option value="">전체</option>
					</select>
				</div>
			</div>
		</div>
		<form:form class="rounded-3 bg-white border d-inline-block m-2" style="width: 500px;" modelAttribute="dto" action="insertProd2" enctype="multipart/form-data">
			<div class="container">
				<div class="textForm">
					ෆ상품 이름
					<form:input path="prod_name" class="prod_name" />
				</div>
				<div class="textForm">
					ෆ가격
					<form:input path="prod_price" class="prod_price" />
				</div>
				<div class="textForm">
					ෆ설명
					<form:textarea path="prod_desc" cols="50" rows="5" class="prod_desc" />
				</div>
				<div class="textForm">
					ෆ이미지 <br> <img id="imscr01" src="" height="100" alt="이미지 미리보기...">
				</div>
				<div class="textForm">
					<input type="file" name="picture" id="picture" onchange="previewFile()" class="picture" />
				</div>
				<div class="textForm">
					ෆ수량
					<form:input path="prod_count" class="prod_count" />
				</div>
				<div class="center">
					<button type="submit" class="btn btn-dark m-3" id="btnRegister">저장</button>
				</div>
			</div>
		</form:form>
	</section>
	<script>
		$(document).ready(function() {
			// 컨트롤러에서 데이터 받기
			var jsonData = JSON.parse('${category}');
			alert(jsonData);
			var cate1Arr = new Array();
			var cate1Obj = new Object();

			// 1차 분류 셀렉트 박스에 삽입할 데이터 준비
			for (var i = 0; i < jsonData.length; i++) {
				if (jsonData[i].level == "1") {
					cate1Obj = new Object(); //초기화
					cate1Obj.cateCode = jsonData[i].cateCode;
					cate1Obj.cateName = jsonData[i].cateName;
					cate1Arr.push(cate1Obj);
				}
			}

			// 1차 분류 셀렉트 박스에 데이터 삽입
			var cate1Select = $('#category1');

			cate1Select.children().remove();
			cate1Select = $('select .category1')
			
			alert(cate1Select);

			for (var i = 0; i < cate1Arr.length; i++) {
				cate1Select.append("<option value='" + cate1Arr[i].cateCode + "'>" + cate1Arr[i].cateName + "</option>");

			}
		});		
	</script>
	<script>
		$(document)
				.on(
						"change",
						"select .category1",
						function() {

							var cate2Arr = new Array();
							var cate2Obj = new Object();

							// 2차 분류 셀렉트 박스에 삽입할 데이터 준비
							for (var i = 0; i < jsonData.length; i++) {

								if (jsonData[i].level == "2") {
									cate2Obj = new Object(); //초기화
									cate2Obj.cateCode = jsonData[i].cateCode;
									cate2Obj.cateName = jsonData[i].cateName;
									cate2Obj.cateCodeRef = jsonData[i].cateCodeRef;

									cate2Arr.push(cate2Obj);
								}
							}

							var cate2Select = $("select .category2");

							cate2Select.children().remove();

							$("option:selected", this)
									.each(
											function() {

												var selectVal = $(this).val();
												cate2Select
														.append("<option value=''>전체</option>");

												for (var i = 0; i < cate2Arr.length; i++) {
													if (selectVal == cate2Arr[i].cateCodeRef) {
														cate2Select
																.append("<option value='" + cate2Arr[i].cateCode + "'>"
																		+ cate2Arr[i].cateName
																		+ "</option>");
													}
												}

											});

						});
	</script>
	<c:import url="footer.jsp" />
</body>
</html>