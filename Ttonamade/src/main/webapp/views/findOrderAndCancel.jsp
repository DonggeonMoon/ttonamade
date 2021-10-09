<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문 조회/취소</title>



<style>
/* basket */
.list-table {
	margin-top: 40px;
	position: relative;
	
}
.list-table thead th{
	height:40px;
	border-top:2px solid #ffcccc;
	border-bottom:1px solid #ffcccc;
	font-weight: bold;
	font-size: 17px;
}
.list-table tbody td{
	text-align:center;
	padding:10px 0;
	border-bottom:1px solid	 #CCC; height:20px;
	font-size: 14px 
}
.bak_item {
	
	height: 170px;
	margin-top: 20px;
}

</style>

	<script>
     
		function cateSave(prod_id, prod_name, order_id, order_seq, prod_imgsrc, cust_id ){
			 
			  var sform = document.forms["form1"];			 
			 document.getElementById("prod_id").value = prod_id;			 
			 document.getElementById("prod_name").value = prod_name;			 
			 document.getElementById("order_id").value = order_id;			 
			 document.getElementById("order_seq").value =  order_seq;			 
			 document.getElementById("prod_imgsrc").value = prod_imgsrc; 
			 document.getElementById("cust_id").value = cust_id; 
			// alert(cust_id);
			// alert( "getElementById : " + document.getElementById("cust_id").value);
		  	
			 sform.action="forReview";
			 sform.method="GET";
			  	
			 sform.submit();
				
		
		}
	</script>
	
	
	
</head>
<body>
<c:import url="header.jsp" />
<c:import url="nav.jsp" />
<center>
<table>

<form name ="form1" action ="forReview">	
	 
<div id="bg1"></div>
	<div id="main_in">
		<div id="menu">
			</div>	
				<div id="content">
					<h2>🌷주문 조회/취소🌷</h2>
					<div class="container pt-3">
						<h1>${customer.cust_name }님의 </h1>	<p>주문하신 상품입니다.</p>	
					</div>					
					 
			  
 	<table class="list-table">
 
	 <c:forEach var="i" items="${list }">
	 <tr>
	 	 <thead class="thead-dark">
		<th style="text-align:center">주문번호</th>
		<th style="text-align:center" >우편번호</th>
		<th style="text-align:center" >주소</th>
		<th style="text-align:center" >상세주소</th>
		<th style="text-align:center">주문총금액</th>
		<th style="text-align:center" >주문일</th>		
		<th style="text-align:center">전화번호</th>
		</thead>
	</tr>
	
		<c:if test="${String.valueOf(i.order_status) == 'T' }">
		<tr>		 
			<td style="text-align:center" >${i.order_id}</td> 			
		    <td style="text-align:center" >${i.order_zipcode }</td> 
			<td style="text-align:center" >${i.order_add1 }</td> 
			<td style="text-align:center">${i.order_add2 }</td> 
			<td style="text-align:center" ><fmt:formatNumber>${i.order_totalAmount }</fmt:formatNumber></td> 
			<td style="text-align:center" >${i.order_date }</td> 
			<td style="text-align:center" >${i.order_telephone }</td>	
				 
	 	</tr>
	
		<tr>	
			<th style="text-align:center"></th>			
			<th style="text-align:center">주문수량</th>
			<th style="text-align:center">제품명</th>
			<th style="text-align:center" >상품이미지</th>
			<th style="text-align:center">주문금액</th>		
			<th style="text-align:center" >삭제</th>
			<th style="text-align:center" >리뷰</th>
		</tr>
		<c:forEach var="j" items="${map.get(i.getOrder_id()) }">			
		<tr>
				
				<td style="text-align:center"></td> 				 
				<td style="text-align:center" >${j.order_count}</td>
				<td style="text-align:center" >${j.prod_name}</td>
		 		<td style="text-align:center" ><img style="width:15%;height:2.5em;" src ="<c:out value="${j.prod_imgsrc}"/>"/></td>		 		
				<td style="text-align:center" ><fmt:formatNumber>${j.prod_price }</fmt:formatNumber></td>
				<td style="text-align:center" ><input type="button"   class="btn btn-outline-info" value="삭제" onclick="location.href='cancelOrder?order_id=${j.order_id}'"></td>
	            <td style="text-align:center" ><input type ="button" class="btn btn-outline-info" name ="btnSave" id ="btnSave" value="리뷰"
	             onclick="cateSave('${j.prod_id}', '${j.prod_name}', '${j.order_id}', '${j.order_seq}', '${j.prod_imgsrc}', '${j.cust_id}' )"></td>
	
			
			</tr>
		</c:forEach>
		</c:if>
	</c:forEach>
		</tr>
				      </tbody>
				    </table>
				</div>
			</div>
			
 	
	</table>
		         <input type="hidden" id="order_id" name="order_id"/> 
		         <input type="hidden" id="order_seq"  name="order_seq"/>  
		         <input type="hidden" id="prod_name"  name="prod_name"/>  
		         <input type="hidden" id="prod_imgsrc"  name="prod_imgsrc"/>  
		         <input type="hidden" id="prod_id"  name="prod_id"/> 
		         <input type="hidden"  name ="cust_id"  id="cust_id"/>  
</form>	
	
	<center>
		<input type="button" class="btn" value="돌아가기" onclick="history.back(-1)">
	</center>


<c:import url="footer.jsp"/>

</body>
</html>