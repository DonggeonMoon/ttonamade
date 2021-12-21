<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 목록</title>
<script>
	window.onpageshow = function(event) {
		if ( event.persisted || (window.performance && window.performance.navigation.type == 2)) { 
			location.reload();
			}
	};
	
	function cartSave(prod_id, prod_name, prod_rating, prod_count, prod_price ){
		 var sform = document.forms["form1"];
		 document.getElementById("prod_id").value = prod_id;
		 document.getElementById("prod_name").value = prod_name;
		 document.getElementById("prod_rating").value = prod_rating;
		 document.getElementById("prod_count").value =  prod_count;
		 document.getElementById("prod_price").value = prod_price; 
		 
		var m = parseInt(document.getElementById("prod_count").value);//재고수량
		var mm = parseInt(document.getElementById("prod_count-"+prod_id).value); //받은값
		
		  if (m < mm){
				alert("재고가 부족합니다.");
		  }else{
			   document.getElementById("prod_count").value = mm;
			   
			  	alert("장바구니에 저장했습니다.");
			  	sform.action="orderAddCart";
			  	
				sform.submit();
		  }
	}
</script>
</head>
<body>
	<c:import url="header.jsp" />
	<c:import url="nav.jsp" />
	<div class="row m-0">
		<!-- Section-->
		<section class="col-10 py-5">
			<form name="form1">
				<input type="hidden" id="prod_id" name="prod_id"> <input type="hidden" id="prod_name" name="prod_name"> <input type="hidden" id="prod_rating" name="prod_rating"> <input type="hidden" id="prod_count" name="prod_count"> <input type="hidden" id="prod_price" name="prod_price">
				<div class="container px-5 px-lg-5 mt-5">
					<div class="row gx-4 gx-lg-5 justify-content-center">
						<c:forEach var="i" items="${list }">
							<c:url var="link" value="/prodView">
								<c:param name="prod_id" value="${i.prod_id }"></c:param>
							</c:url>
							<div class="col col-xs-6 col-sm-5 col-md-4 col-lg-3 col-xl-3 mb-5 mx-sm-3">
								<div class="card h-100">
									<!-- Product image-->
									<a href="/Ttonamade/prodView?prod_id=<c:out value="${i.prod_id }"/>"><img class="card-img-top" style="width: 100%; height: 25em;" src="<c:out value="${i.prod_imgsrc }"/>" alt="..." /></a>
									<!-- Product details-->
									<div class="card-body p-5">
										<div class="text-center">
											<!-- Product name-->
											<h5 class="fw-bolder">
												<a href="/Ttonamade/prodView?prod_id=<c:out value="${i.prod_id }"/>"> <c:out value="${i.prod_name }" />
												</a>
											</h5>
											<!-- Product reviews-->
											<div class="d-flex justify-content-center small text-warning mb-2">
												<c:forEach begin="1" end="${i.prod_rating/1 }" step="1">
													<div class="bi-star-fill"></div>

												</c:forEach>
												<c:if test="${i.prod_rating % 1 != 0}">
													<div class="bi-star-half"></div>
												</c:if>
											</div>
											<!-- Product price-->
											<fmt:formatNumber value="${i.prod_price }" type="currency" />
										</div>
										<div class="text-center">
											<h6 class="fw-bolder" id="prod_count">
												<c:out value="${i.prod_count }" />
											</h6>
										</div>
										<div class="text-center">
											<input type="number" id="prod_count-${i.prod_id }" name="prod_count2" style="width: 60px; height: 30px;" value=<c:out value="1" />>
										</div>
									</div>
									<div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
										<div class="text-center">
											<div class="btn-outline-darkmt-auto">
												<input type="button" class="btn btn-outline-warning" name="btnSave" id="btnSave" value="장바구니담기" onclick="cartSave('${i.prod_id}', '${i.prod_name}', '${i.prod_rating}', '${i.prod_count}', '${i.prod_price}' )">
											</div>
										</div>
									</div>
								</div>
							</div>
						</c:forEach>

					</div>
				</div>
			</form>
			<c:if test="${sessionScope.customer != null}">
				<c:if test="${String.valueOf(sessionScope.customer.cust_manager) == 'M'}">
					<div class="text-center">
						<a class="btn btn-outline-dark m-2" href="/Ttonamade/insertProd">상품 등록</a><a class="btn btn-outline-dark m-2" href="/Ttonamade/ProdModifychoice">상품 수정</a>
					</div>
				</c:if>
			</c:if>
			<div class="text-center">
				<input type="button" class="btn btn-outline-dark text-center m-2" style="text-align: center" value="돌아가기" onclick="history.back(-1)">
			</div>
		</section>

		<aside class="col-2 d-none d-sm-block container-fluid p-2">
			<div class="border rounded-2 p-2 bg-white" id="wingBanner" style="position: relative;">
				<div class="m-3">최근 본 상품 목록</div>
				<div id="displaybar"></div>
			</div>
		</aside>
	</div>
	<c:import url="footer.jsp" />
	<!-- 최근 본 상품 목록, 윙 배너 스크립트 -->
	<script>
		let data = JSON.parse(localStorage.getItem('Ttonamade'));
		let html = '';
		var datavalues = '';
		if (data != null) {
			datavalues = Object.values(data);
			let id;
			let name;
			let imgsrc;
		   	
		   	datavalues.sort((beforeValue, nextValue) => {
		   		if (beforeValue.timestamp < nextValue.timestamp) return 1;
		    	else if (beforeValue.timestamp > nextValue.timestamp) return -1;
		    	else return 0;
		    	});
		   	
		   	for (var i = 0; i < datavalues.length; i++) {
		   		id = datavalues[i]['id'];
		   		name = datavalues[i]['name'];
		   		imgsrc = datavalues[i]['imgsrc'];
		   		html += "<div class=\"card m-3\"><div class=\"card-body\"><a class=\"d-none d-xxl-block d-xl-block\" href=\"/Ttonamade/prodView?prod_id=" + id + "\">" + name + "</a><img width=\"50px\" height=\"50px\" src=\"" + imgsrc + "\"><input type=\"button\" class=\"btn-close\" value=\"\" onclick=\"removeProduct(" + i +")\"></div></div>";
		   		if (i == 6) break;
		   	}
		} else {
			html = '최근 본 상품이 없습니다.';
		}
		console.log('adfa'+ html);
		$('#displaybar').html(html);
		
		function removeProduct(idx){
			datavalues.pop(idx);
			var data = {};
			for (var i = 0; i < datavalues.length; i++) {
				var num = datavalues[i]['id'];
				data[num] = datavalues[i];
			}
			localStorage.setItem('Ttonamade', JSON.stringify(data));
			location.reload();
		}
		var limit = $(document.body).prop('scrollHeight') - $('footer').height() * 5;
		$(window).scroll(function(){
			let height = $(document).scrollTop();	
			
			console.log('height: ' + height);
			console.log('limit: ' + limit);
			if (height >  limit) {
				height = limit;
			}
			let height2 = height + "px"
			$('#wingBanner').animate({
				top: height2
			}, 1);
			console.log('top:' + $('#wingBanner').css('top'));
		})
	</script>
	<script type="text/javascript">
		var message = '${data}'; 
		var returnUrl = '${url}'; 
		
		if (message.length != 0){ 
			alert(message);
			document.location.href = returnUrl;
		}
	</script>
</body>
</html>
