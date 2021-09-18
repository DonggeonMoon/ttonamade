<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
</head>
<body>
<c:import url="header.jsp"/>
<header class="masthead2 bg-primary text-center" style="height:350px">
		<div class="">
			<!-- Masthead Avatar Image-->
			<img class="masthead-avatar" src="/Ttonamade/img/Ttonamade.jpg" style="width:200px; height:200px;">
		</div>
</header>
<center>
<div id="bg1"></div>
	<div id="main_in">
		<div id="menu">
			</div>	
				<div id="content">
					<h2>🌷주문 조회/취소🌷</h2>
					<p>${customer.cust_name } 님의 주문내역입니다.</p>
					 <table class="list-table">
				      <thead>
				        
	<c:forEach var="i" items="${list }">
		
		<c:if test="${String.valueOf(i.order_status) == 'T' }">
		<tr>
			<th>주문번호</th>
			<th>주문금액</th>
			<th>주문일</th>
			<th>우편번호</th>
			<th>주소</th>
			<th>상세주소</th>
			<th>전화번호</th>
		</tr>
		<tr>
			<td>${i.order_id}</td>
			<td>${i.order_totalAmount }</td>
			<td>${i.order_date }</td>
			<td>${i.order_zipcode }</td>
			<td>${i.order_add1 }</td>
			<td>${i.order_add2 }</td>
			<td>${i.order_telephone }</td>
			<td><input type="button" value="취소" onclick="location.href='cancelOrder?order_id=${i.order_id }'"></td>
			
		</tr>
		
		<tr>	
			<th colspan="3">주문상세번호</th>
			<th>제품아이디</th>
			<th>제품명</th>
			<th>가격</th>
			<th>주문수량</th>
		</tr>
		<c:forEach var="j" items="${map.get(i.getOrder_id()) }">
			<tr>
				<td colspan="2">${j.order_id}</td>
				<td>${j.order_seq}</td>
				<td>${j.prod_id }</td>
				<td>${j.prod_name }</td>
				<td>${j.prod_price }</td>
				<td>${j.order_count }</td>
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
	
<input type="button" class="btn" value="돌아가기" onclick="history.back(-1)">
	</center>
<c:import url="footer.jsp"/>
</body>
</html>