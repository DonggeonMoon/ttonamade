<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Ttonamade</title>
<link href="/Ttonamade/resources/css/nice-select.css" rel="stylesheet" />
<script type="text/javascript" src="/Ttonamade/resources/js/jquery.js"></script>
<script type="text/javascript" src="/Ttonamade/resources/js/jquery.nice-select.js"></script>

	 
	<style>
  table {
    width: 100%;
    border-top: 5px solid #ffcccc;
    border-collapse: collapse;
  }
  th, td {
    border-bottom: 1px solid #ffcccc;
    padding: 10px;
    text-align: center;
  }
  thead tr {
    background-color: #0d47a1;
    color: #ffffcc;
  }
  tbody tr:nth-child(2n) {
    background-color: #ffffff;
  }
  tbody tr:nth-child(2n+1) {
    background-color: #ffffcc;
  }
</style>
	  

</head>
<body>
<c:import url="header.jsp" />
<c:import url="nav.jsp" />
<center>
<h2>🌷장바구니🌷</h2>
</center>
<div class="container mt-3">
	<c:choose>
 		<c:when test="${map.count == 0 }"> 		 
 			<h2 style="text-align:center">장바구니가 비어있습니다. </h2>
 		</c:when>
 		<c:otherwise>
 			<form name="form1" id ="form1" method ="post" action ="cartTransOrder" >
		 			<table  border="1" style="width:100% "  class="table table-hover"   > 
		 				<tr>
							<th >상품명</th>
							<th >단 가</th>
							<th >수 량</th>	
							<th >금 액</th>	
							<th >취 소</th>
						</tr>
		 				<c:forEach var="row" items="${map.list }" varStatus ="i">
		 					<tr>
		 						<td>
		 							${row.prod_name}
		 						</td>
		 						<td >
		 							 <script>
		 							 	var str =${row.prod_price}/${row.prod_count}
		 							 	str = Math.round(str)
		 								document.write( str.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") )
		 							 	 
		 							 </script>
		 						</td>
		 						
		 						<td >
		 							<fmt:formatNumber> ${row.prod_count}</fmt:formatNumber>
		 						 
		 							<input type="hidden" name="prod_id" value="${row.prod_id }"> 							 
		 							<input type ="hidden" name="cust_id" value="${row.cust_id }">
		 						
		 						</td>
		 						
		 						<td >
		 							 
		 							 <fmt:formatNumber  > ${row.prod_price}</fmt:formatNumber>
		 						</td>
		 						
		 						
		 						 <td>
		 						
		 				<!-- 		<button class="btn btn-warning" ><a href="cartDelete?cart_id=<c:out value="${row.cart_id }" />"> 삭 제</button> </a>   -->
		 						 <a href="cartDelete?cart_id=<c:out value="${row.cart_id }" />&prod_id=<c:out value="${row.prod_id }" />"><button type="button" class="btn btn-warning" >삭 제</button></a>  
		 					
		 						</td> 				
		 						
		 					</tr>
		 				</c:forEach>
		 				
		 				<!-- 주문내역을 보이고 전체금액을 보여준다 -->
		 				<tr>
		 					<td colspan= 5 align ="center" style ="height:100px" >
		 					
		 						장바구니 금액 합계 :<fmt:formatNumber>${map.sumMoney}</fmt:formatNumber>  
		 					 
		 					</td>
		 				</tr>
		 			</table> 	
 			 	
	 			<input type="hidden" name="count" value="${map.count }">
	 			<br>
 			</form>
 			
 		</c:otherwise>
 	</c:choose>
 	
 		<c:choose>
 		<c:when test="${map.count == 0 }">
 			
 			
 		</c:when>
 		<c:otherwise>
 		<center>
 			<a href="#" onclick="history.back(-1)"><input type="button" class="btn btn-outline-warning"  value="돌아가기" style ="width:150px" class="btn" ></a>
			<a href="cartDeleteAll?cust_id=<c:out value="${map.custid }" />"><input type ="button"  class="btn btn-outline-warning" value ="장바구니 비우기" style ="width:150px" class="btn"></a>	
		 	
			<a href ="#" onclick="form1.submit()"><input type ="button"  class="btn btn-outline-warning" value="주문저장" id ="btn1" class="btn"></a><br><br>
			
		</center>
		</c:otherwise>
	</c:choose>

</div>

	<script type="text/javascript">
	
		var message = '${data}'; 
		var returnUrl = '${url}'; 
	
		if (message.length != 0){ 
			alert(message);
			document.location.href =returnUrl ;
		}
		//alert(message);
	</script>
<c:import url="footer.jsp"/>
</body>
</html>