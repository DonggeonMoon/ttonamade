<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Ttonamade</title>

	 
	<style>
  table {
    width: 100%;
    border-top: 1px solid #444444;
    border-collapse: collapse;
  }
  th, td {
    border-bottom: 1px solid #444444;
    padding: 10px;
    text-align: center;
  }
  thead tr {
    background-color: #0d47a1;
    color: #ffffff;
  }
  tbody tr:nth-child(2n) {
    background-color: #bbdefb;
  }
  tbody tr:nth-child(2n+1) {
    background-color: #e3f2fd;
  }
</style>
	  

</head>
<body>
<c:import url="header.jsp"/>

<header class="masthead2 bg-primary text-center" style="height:350px">
		<div class="">
			<!-- Masthead Avatar Image-->
			<img class="masthead-avatar" src="/Ttonamade/img/Ttonamade.jpg" style="width:200px; height:200px;">
		</div>
</header>

<h2>장바구니</h2>

	<c:choose>
 		<c:when test="${map.count == 0 }">
 			장바구니가 비어있습니다.
 			
 		</c:when>
 		<c:otherwise>
 			<form name="form1" id ="form1" method ="post" action ="cartTransOrder" >
		 			<table >
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
		 							<a href="cartDelete?cart_id=<c:out value="${row.cart_id }" />">삭제</a> 
		 						 
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
 			<a href="#" onclick="history.back(-1)"><input type="button" value="돌아가기" style ="width:150px" ></a>
			<a href="cartDeleteAll?cust_id=<c:out value="${map.custid }" />"><input type ="button" value ="장바구니 비우기" style ="width:150px" ></a>	
			<a href ="#" onclick="form1.submit()"><input type ="button" value="주문저장" id ="btn1"></a>
		</c:otherwise>
	</c:choose>



<c:import url="footer.jsp"/>
</body>
</html>