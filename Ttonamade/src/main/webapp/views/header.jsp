<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- Core CSS and JS -->
<link href="/Ttonamade/resources/css/bootstrap.css" rel="stylesheet" />
<script src="/Ttonamade/resources/js/bootstrap.bundle.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<!-- font -->
<link href="https://fonts.googleapis.com/css?family=Lato:400,700,400italic,700italic" rel="stylesheet" type="text/css" />
<link href="https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css" />
<script src="https://use.fontawesome.com/releases/v5.15.3/js/all.js"></script>

<!-- bootstrap-icon -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />
<link href="/Ttonamade/resources/css/nice-select.css" rel="stylesheet" />
<style>
#mainNav {
	padding-top: 1rem;
	padding-bottom: 1rem;
	font-family: "Montserrat", -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, "Noto Sans", sans-serif, "Apple Color Emoji", "Segoe UI Emoji", "Segoe UI Symbol", "Noto Color Emoji";
	font-weight: 700;
}

.select {
	position: relative;
}

.select .option-list {
	position: absolute;
	top: 100%;
	left: 0;
	width: 100%;
	overflow: hidden;
	max-height: 0;
}

.select.active .option-list {
	max-height: none;
}

/* 테마 적용하기 */
#theme {
	
}

#theme .select {
	box-shadow: 0 0 2px rgba(0, 0, 0, 0.3);
	border-radius: 5px;
	padding: 0;
	cursor: pointer;
}

#theme .select:hover {
	color: #333;
	transition: all .3s;
}

#theme .select .option-list {
	list-style: none;
	padding: 0;
	border-radius: 5px;
	box-shadow: 0 0 2px rgba(0, 0, 0, 0.3);
}

#theme .select .option-list .option {
	padding: 0;
}

#theme .select .option-list .option:hover {
	background-color: #f2f2f2;
}
</style>
<!-- Navigation-->
<header class="navbar navbar-expand-lg bg-secondary fixed-top" id="mainNav">
	<div class="container-fluid">
		<div class="col-12 col-sm-12 col-md-5 col-lg-3 px-5">
			<a href="/Ttonamade" class="navbar-brand text-uppercase text-danger">Ttonamade dessert</a>
		</div>
		<div class="form-inline form-group col-12 col-sm-12 col-md-5 col-lg-3 text-center">
			<div class="form-control">
				<div id="theme">
					<select class="select" id="category1" name="category1" style="width: 100px">
						<option class="option-list" value="" disabled>1차 분류</option>
						<option class="option-list" value="">전체</option>
					</select><select class="select  m-1" id="category2" name="category2" style="width: 100px">
						<option class="option-list" disabled>2차 분류</option>
						<option class="option-list" value="">전체</option>
					</select>
					<button class="btn btn-outline-secondary" id="btn_category" name="btn_category" style="padding: 3px">검색</button>
				</div>
			</div>
		</div>
		<div class="col-12 col-sm-12 col-md-5 col-lg-3 m-2">
			<div id="autocomplete" class="dropdown">
				<input type="text" id="search_bar" class="dropdown-toggle" value="" placeholder="검색어를 입력하세요" style="width: 100%;">
				<div id="search_result" class="dropdown-menu bg-white" style="width: 100%;"></div>
			</div>
		</div>
		<div class="col-12 col-sm-12 col-md-5 col-lg-3 m-2 text-center">
			<div class="navbar-nav ms-auto">
				<c:choose>
					<c:when test="${sessionScope.customer == null }">
						<div>
							<a href="/Ttonamade/login" class="text-danger mx-1">로그인</a> <a href="/Ttonamade/registerAgree" class="text-danger mx-1">회원가입</a> <a href="/Ttonamade/qnaList" class="text-danger mx-1">문의하기</a>
						</div>
					</c:when>
					<c:otherwise>
						<c:choose>
							<c:when test="${String.valueOf(sessionScope.customer.cust_manager) == 'M'}">
								<a href="/Ttonamade/reservationOrder">관리자&nbsp;</a>
							</c:when>
						</c:choose>
						<span class="mx-1">${customer.cust_name}(${customer.cust_id })님</span>
						<a href="/Ttonamade/cartView" class="text-danger mx-1">장바구니</a>
						<a href="/Ttonamade/myPage" class="text-danger mx-1">마이 페이지</a>
						<a href="/Ttonamade/qnaList" class="text-danger mx-1">문의하기</a>
						<a href="/Ttonamade/logout" class="text-danger mx-1">로그아웃</a>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
	</div>
</header>
<script>
	$("#search_bar")
			.keyup(
					function(event) {
						let keyword = $("#search_bar").val();
						if (keyword != "") {
							$
									.ajax(
											{
												async : true,
												type : 'POST',
												url : 'autocomplete',
												contentType : "application/json; charset=UTF-8",
												dataType : "json",
												data : keyword
											})
									.done(
											function(data) {
												let html = "";
												$
														.each(
																data,
																function(key,
																		value) {
																	$(
																			"#search_result")
																			.html(
																					"");
																	html += "<a href=\"/Ttonamade/prodView?prod_id="
																			+ key
																			+ "\">"
																			+ value
																			+ "</a><br>"
																	$(
																			"#search_result")
																			.html(
																					html);
																});
												$('#search_result')
														.attr('class',
																'dropdown-menu bg-white show')
											});
						} else {
							$("#search_result").html("");
							$('#search_result').attr('class',
									'dropdown-menu bg-white')
						}
					});
</script>
<script>
	$(function() {
		$('#btn_category').on(
				'click',
				function() {

					var cateCodeRef = $("#category1 option:selected").val();//100,200,300
					var cateCode = $("#category2 option:selected").val();//1,2,3,4,5

					if ($("#category1 option:selected").text() == '전체') {//전체라면
						cateCodeRef = "";
					}

					if ($("#category2 option:selected").text() == '전체') {//전체라면
						cateCode = "";
					}
					// lcation.href="/경로?보낼변수명=" + 값 + "&;보낼변수명2=" + 값 ..... ;
					location.href = "/Ttonamade/prodList1?catecoderef="
							+ cateCodeRef + "&catecode=" + cateCode;

				});
	});
</script>
<script>
	window.onload = function() {

		var cateSelect1 = ''
		var cateSelect2 = ''

		// 컨트롤러에서 데이터 받기
		var jsonData = JSON.parse('${category}');
		//alert(jsonData);
		console.log(jsonData[1].cateName);

		var cate1Arr = new Array();
		var cate1Obj = new Object();

		// 1차 분류 셀렉트 박스에 삽입할 데이터 준비
		for (var i = 0; i < jsonData.length; i++) {

			if (jsonData[i].level == "1") {
				cate1Obj = new Object(); //초기화
				cate1Obj.cateCode = jsonData[i].cateCode;
				cate1Obj.cateName = jsonData[i].cateName;
				// alert(jsonData[i].cateName);
				cate1Arr.push(cate1Obj);
			}
		}

		// 1차 분류 셀렉트 박스에 데이터 삽입
		var cate1Select = $('#category1');

		for (var i = 0; i < cate1Arr.length; i++) {

			cate1Select.append("<option value='" + cate1Arr[i].cateCode + "'>"
					+ cate1Arr[i].cateName + "</option>");
		}

		console.log($("#category1 option:selected").text());
		console.log($("#category1 option").size());
		console.log($('select.category1'));

		$(document)
				.on(
						"change",
						"#category1",
						function() {
							cateSelect1 = $(this).val();

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

							var cate2Select = $("#category2");

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

		$(document).on("change", "#category2", function() {
			cateSelect2 = $(this).val();
		});
	}
</script>