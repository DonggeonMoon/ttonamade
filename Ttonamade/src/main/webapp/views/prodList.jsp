<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 목록</title>
<script>
		function cartSave(prod_id, prod_name, prod_rating, prod_count, prod_price ){
			 var sform = document.forms["form1"];
			 document.getElementById("prod_id").value = prod_id;
			 document.getElementById("prod_name").value = prod_name;
			 document.getElementById("prod_rating").value = prod_rating;
			 document.getElementById("prod_count").value =  prod_count;
			 document.getElementById("prod_price").value = prod_price; 
			 
			// alert( document.getElementById("prod_count-"+prod_id).value);	
			var m = parseInt(document.getElementById("prod_count").value);//재고수량
			var mm = parseInt(document.getElementById("prod_count-"+prod_id).value); //받은값
			 
		 			
			// alert( m);
			// alert( mm);	
				 
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
	<header class="masthead2 bg-primary text-center" style="height: 350px">
		<div class="">

			<!-- Masthead Avatar Image-->
			<img class="masthead-avatar" src="/Ttonamade/img/Ttonamade.jpg"
				style="width: 200px; height: 200px;">
		</div>
	</header>
	<div>
		<span>최근 본 상품 목록</span><span><div id="displaybar"></div></span>
	</div>
	<!-- Section-->
	<form name="form1">
		<input type="hidden" id="prod_id" name="prod_id">
		<input type="hidden" id="prod_name" name="prod_name">
		<input type="hidden" id="prod_rating" name="prod_rating">
		<input type="hidden" id="prod_count" name="prod_count">
		<input type="hidden" id="prod_price" name="prod_price">
		
		<!-- <input type = "hidden" id="prod_count2" name="prod_count2" value=<c:out value="${i.prod_count} "/>> -->
		<section class="py-5">
			<div class="container px-5 px-lg-5 mt-5">
				<div
					class="row gx-4 gx-lg-5 row-cols-2 row-cols-md-3 row-cols-xl-4 justify-content-center">

					<c:forEach var="i" items="${list }">

						<c:url var="link" value="/prodView">
							<c:param name="prod_id" value="${i.prod_id }"></c:param>
						</c:url>

						<div class="col mb-5  mx-sm-3">
							<div class="card h-100">
								<!-- Product image-->
								<a
									href="/Ttonamade/prodView?prod_id=<c:out value="${i.prod_id}"/>"><img
									class="card-img-top" style="width: 100%; height: 25em;"
									src="<c:out value="${i.prod_imgsrc }"/>" alt="..." /></a>
								<!-- Product details-->
								<div class="card-body p-5">
									<div class="text-center">
										<!-- Product name-->
										<h5 class="fw-bolder">
											<c:out value="${i.prod_name }" />
										</h5>
										<!-- Product reviews-->
										<div
											class="d-flex justify-content-center small text-warning mb-2">
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
										<h6 class="fw-bolder" id="prod_count" name="prod_count">
											<c:out value="${i.prod_count }" />
										</h6>
									</div>
									<div class="text-center">
										<input type="text" id="prod_count-${i.prod_id }"
											name="prod_count2" style="width: 60px; height: 30px;"
											dir="rtl" value=<c:out value="${i.prod_count }" />>
									</div>
									<script>
                             		 	//	document.getElementById("prod_count2").value = <c:out value="${i.prod_count }" />
                             			// alert(document.getElementById("prod_count2").value)
                             		  </script>
								</div>

								<div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
									<div class="text-center">
										<class="btn-outline-darkmt-auto"> <input type="button" name="btnSave" id="btnSave" value="장바구니담기"
											onclick="cartSave('${i.prod_id}', '${i.prod_name}', '${i.prod_rating}', '${i.prod_count}', '${i.prod_price}' )">
									</div>
								</div>
							</div>
						</div>
					</c:forEach>

				</div>
			</div>
		</section>
	</form>
	<c:if test="${sessionScope.customer != null}">
		<c:if
			test="${String.valueOf(sessionScope.customer.cust_manager) == 'M'}">
			<div class="text-center mb-5">
				<a class="btn btn-outline-dark mt-auto mx-3"
					href="/Ttonamade/insertProd">상품 등록 </a><a
					class="btn btn-outline-dark mt-auto mx-3"
					href="/Ttonamade/ProdModifychoice">상품 수정 </a>
			</div>
		</c:if>
	</c:if>
	<c:import url="footer.jsp" />
	<!-- 최근 본 상품 목록 스크립트 -->
	<script>
		let data = JSON.parse(localStorage.getItem('Ttonamade'));
		let html = '';
		var datavalues ='';
		if (data != null) {
			datavalues = Object.values(data);
			let id;
			let name;
			let imgsrc;
		   	
		   	datavalues.sort((beforeValue, nextValue) => {
		   		if (beforeValue.timestamp > nextValue.timestamp) return 1;
		    	else if (beforeValue.timestamp < nextValue.timestamp) return -1;
		    	else return 0;
		    	});
		   	
		   	for (var i = 0; i < datavalues.length; i++) {
		   		id = datavalues[i]['id'];
		   		name = datavalues[i]['name'];
		   		imgsrc = datavalues[i]['imgsrc'];
		   		html += "<a href=\"/Ttonamade/prodView?prod_id=" + id + "\">" + name + "</a><img width=\"50px\" height=\"50px\" src=\"" + imgsrc + "\"><input type=\"button\" value=\"삭제\" onclick=\"removeProduct(" + i +")\">";
		   	}
		} else {
			html = '최근 본 상품이 없습니다.';
		}
		document.getElementById('displaybar').innerHTML = html;
		
		function removeProduct(idx){
			datavalues.pop(idx);
			var data={};
			for (var i = 0; i < datavalues.length; i++) {
				var num = datavalues[i]['id'];
				data[num] = datavalues[i];
				}
			localStorage.setItem('Ttonamade', JSON.stringify(data));
			location.reload();
		}
	</script>
</body>
</html>
