<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>찜하기 목록</title>
</head>
<body>
	<c:import url="header.jsp" />
	<c:import url="nav.jsp" />
	<div class="alert alert-light alert-dismissible fade show" align="center">
		<button type="button" class="btn close"></button>
		<h1>찜 목록!!</h1>
		we respect your choices..
	</div>
	<div class="container mt-3">
		<!--  class="list-table" -->
		<c:choose>
			<c:when test="${map.count == 0 }">
				<h2 style="text-align: center">찜 목록이 비어있습니다.</h2>
			</c:when>
			<c:otherwise>
				<form name="form1" id="form1" method="post" action="cartTransOrder">
					<table border="1" style="width: 100%; text-align: center" class="table table-hover">
						<tr>
							<th>상품명</th>
							<th>단 가</th>
							<th>재 고</th>
							<th>금 액</th>
							<th>취 소</th>
						</tr>
						<c:forEach var="row" items="${map.list }" varStatus="i">
							<c:url var="link" value="/prodView">
								<c:param name="prod_id" value="${row.prod_id}" />
							</c:url>
							<tr>
								<td><a href="${link }"><c:out value="${row.prod_name}" /></a></td>
								<td><script>
	 							 	var str =${row.prod_price}/${row.prod_count}
	 							 	str = Math.round(str)
	 								document.write( str.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") )
	 							 </script></td>
								<td><fmt:formatNumber>
										<c:out value="${row.prod_count}" />
									</fmt:formatNumber></td>
								<td><fmt:formatNumber>
										<c:out value="${row.prod_price}" />
									</fmt:formatNumber></td>
								<td><input type="button" value="삭제" class="btn btn-info" onclick="location.href='/Ttonamade/deleteChoice?prod_id=<c:out value="${row.prod_id}"/>'"></td>
							</tr>
						</c:forEach>
					</table>
					<input type="hidden" name="count" value="${map.count }"> <br>
				</form>
			</c:otherwise>
		</c:choose>
	</div>
	<div style="text-align: center">
		<c:choose>
			<c:when test="${map.count == 0 }">
			</c:when>
			<c:otherwise>
				<a href="#" onclick="history.back(-1)"><input type="button" class="btn btn-outline-info" value="돌아가기" style="width: 150px"></a>
				<a href="deleteAllChoice"><input type="button" class="btn btn-outline-info" value="찜 목록 비우기" style="width: 150px"></a>
			</c:otherwise>
		</c:choose>
	</div>
	<br>
	<c:import url="footer.jsp" />
</body>
</html>