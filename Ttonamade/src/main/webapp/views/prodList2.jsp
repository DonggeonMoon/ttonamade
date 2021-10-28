<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 목록</title>
<script>
	function cartSave(prod_id, prod_name, order_id, order_seq, prod_imgsrc, cust_id ){
		 var sform = document.forms["form1"];
		 document.getElementById("prod_id").value = prod_id;
		 document.getElementById("prod_name").value = prod_name;
		 document.getElementById("order_id").value = order_id;
		 document.getElementById("order_seq").value =  order_seq;
		 document.getElementById("prod_imgsrc").value = prod_imgsrc;
		 document.getElementById("cust_id").value = cust_id;
		 //권한 check 해야한다.
		 
		  var ses_cust_id = "${sessionScope.customer.cust_id}";
	     var ses_cust_manager = "${sessionScope.customer.cust_manager}";
	     var doc_cust_id = document.getElementById("cust_id").value ;
	  
	     
	 	if (   (doc_cust_id != ses_cust_id ) &&  (ses_cust_manager != 'M'   ) ) {			 
		 	alert ( "리뷰를 작성할 수 없습니다");
		 }else{
			 sform.action="forReview"; 
			 sform.method ="get";
			 sform.submit();
		 }
	}
	</script>
</head>
<body>
	<c:import url="header.jsp" />
	<c:import url="nav.jsp" />
	<section class="col-9">
		<form name="form1">
			<input type="hidden" name="order_id" id="order_id"> <input type="hidden" name="prod_name" id="prod_name"> <input type="hidden" name="prod_imgsrc" id="prod_imgsrc"> <input type="hidden" name="cust_id" id="cust_id"> <input type="hidden" name="order_seq" id="order_seq" /> <input type="hidden" name="prod_id" id="prod_id" />
			<div class="container px-5 px-lg-5 mt-5">
				<div class="row gx-4 gx-lg-5 justify-content-center">
					<c:forEach var="i" items="${list }">
						<div class="col col-xs-6 col-sm-5 col-md-4 col-lg-3 col-xl-3 mb-5 mx-sm-3">
							<div class="card h-100">
								<img class="card-img-top" style="width: 100%; height: 25em;" src="<c:out value="${i.prod_imgsrc }"/>" alt="..." />
								<!-- Product image-->
								<!-- Product details-->
								<div class="card-body p-5">
									<div class="text-center">
										<span class="small mb-1">주문번호 : <c:out value="${i.order_id }" /></span> <br>
										<!-- Product name-->
										<h5 class="fw-bolder">
											<a href="/Ttonamade/prodView?prod_id=<c:out value="${i.prod_id }"/>"> <c:out value="${i.prod_name }" /></a>
										</h5>
										<!-- Product reviews-->
										<!-- Product price-->
										주문가격:
										<fmt:formatNumber value="${i.prod_price }" type="currency" />
									</div>
									<div class="text-center">
										<span class="small mb-1" id="order_count">주문개수: <c:out value="${i.order_count }" /></span>
									</div>
									<div class="text-center">
										<script>
		 							 	var str = ${i.prod_price}* ${i.order_count}		 							 	
		 								document.write( "총 금액 : "+ str.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") )
		 							 	 
		 							 </script>
									</div>
									<div class="text-left">
										<span class="small mb-1"> 주문일 : <fmt:formatDate value="${i.order_date }" type="date" dateStyle="full" /></span>
									</div>
								</div>
								<div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
									<div class="text-center">
										<input type="button" class="btn btn-outline-info" name="btnSave" id="btnSave" value="상품리뷰" onclick="cartSave('${i.prod_id}', '${i.prod_name}', '${i.order_id}', '${i.order_seq}', '${i.prod_imgsrc}', '${i.cust_id}' )">
									</div>
								</div>
							</div>
						</div>
					</c:forEach>
				</div>
			</div>
		</form>
	</section>
	<aside class="col-2 d-none d-sm-block container-fluid p-2">
		<div class="border rounded-2 p-2 bg-white" id="wingBanner" style="position: relative;">
			<div class="m-3">최근 본 상품 목록</div>
			<div id="displaybar"></div>
		</div>
	</aside>
	<script type="text/javascript">
	
		var message = '${data}'; 
		var returnUrl = '${url}'; 
		
		if (message.length != 0){ 
			alert(message);
			document.location.href = returnUrl;
		}
		//alert(message);
	</script>
	<div class="text-center">
		<input type="button" class="btn" value="돌아가기" onclick="history.back(-1)">
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
		   		html += "<div class=\"card m-3\"><div class=\"card-body\"><a href=\"/Ttonamade/prodView?prod_id=" + id + "\">" + name + "</a><img width=\"50px\" height=\"50px\" src=\"" + imgsrc + "\"><input type=\"button\" class=\"btn-close\" value=\"\" onclick=\"removeProduct(" + i +")\"></div></div>";
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
</body>
</html>
