<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 보기</title>

<script>
		function cartSave(prod_id, prod_name, prod_rating, prod_count, prod_price  ){
			 
			
			 var sform = document.forms["form1"];
			 
			 document.getElementById("prod_id").value = prod_id;
			 document.getElementById("prod_name").value = prod_name; 
			 document.getElementById("prod_count").value =  prod_count;
			 document.getElementById("prod_price").value = prod_price; 
			  
		 
			        
			var m = parseInt(document.getElementById("prod_count").value);//재고수량
			var mm = parseInt(document.getElementById("inputQuantity").value); //받은값
			 
			
			  if ( m < mm){
				  
					alert("재고가 부족합니다.");
			  }else{
				  
				   document.getElementById("prod_count").value = document.getElementById("inputQuantity").value;
				  	alert("장바구니 페이지로 이동합니다.");
				  	sform.action="insertOrder";
					sform.submit();
			  }
		 
		}
	</script>
	
</head>
<body>
<c:import url="header.jsp"/>
<header class="masthead2 bg-primary text-center" style="height:350px">
		<div class="">
			<!-- Masthead Avatar Image-->
			<img class="masthead-avatar" src="/Ttonamade/img/Ttonamade.jpg" style="width:200px; height:200px;">
		</div>
</header>

<form name ="form1" > 
<input type="hidden" id ="prod_id" name ="prod_id" >
<input type="hidden" id ="prod_name" name ="prod_name" >
<input type="hidden" id ="prod_count" name ="prod_count" >
<input type="hidden" id ="prod_price" name ="prod_price" >


<!-- Product section-->
<section class="py-5">
    <div class="container px-4 px-lg-5 my-5">
        <div class="row gx-4 gx-lg-5 align-items-center">
            <div class="col-md-6"><img class="card-img-top mb-5 mb-md-0" style="width:400px;height:400px;" src="<c:out value="${product.prod_imgsrc }"/>" alt="..."/></div>
            <div class="col-md-6">
                <div class="small mb-1">제품 번호: <c:out value="${product.prod_id }"/></div>
                <h1 class="display-5 fw-bolder"><c:out value="${product.prod_name }"/></h1>
                <div class="fs-5 mb-5">                    
                    <span><fmt:formatNumber value="${product.prod_price }" type="currency"/></span>
                </div>
                <div class="fs-5 mb-5">
                <span>  
	                <c:forEach begin="1" end="${i.prod_rating/1 }" step="1">
	               		<div class="bi-star-fill"></div>
	                </c:forEach>
	                <c:if test="${i.prod_rating % 1 != 0}">
	                	<div class="bi-star-half"></div>
	                </c:if>
	            </span>
	            </div>
                <p class="lead"><c:out value="${product.prod_desc }"/></p>
                <p class="lead">재고 수량: <c:out value="${product.prod_count }"/></p>
                <p class="lead">등록일: <c:out value="${product.prod_date }"/></p>
                <div class="d-flex">
                     <input class="form-control text-center me-3" id="inputQuantity" type="number" value="1" style="max-width: 3rem"/>
                    <button class="btn btn-outline-dark flex-shrink-0" type="button" id ="btnSave" value="주문하기"   onclick="cartSave('${product.prod_id}', '${product.prod_name}', '${product.prod_rating}', '${product.prod_count}','${product.prod_price}'   )">
                      주문하기
                    </button>
                </div>
            </div>
        </div>
    </div>
</section>
</form>
<c:import url="footer.jsp"/>
</body>
</html>