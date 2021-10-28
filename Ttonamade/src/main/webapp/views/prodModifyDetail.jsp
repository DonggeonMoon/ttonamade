<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<title>데이타 수정</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style type="text/css">
@import url(https://fonts.googleapis.com/css?family=Roboto:300);

.address-page {
	width: 360px;
	padding: 3% 0 0;
	margin: auto;
}

.form {
	font-family: "Roboto", sans-serif;
	position: relative;
	z-index: 1;
	background: #ffffcc;
	max-width: 700px;
	margin: 0 auto 100px;
	padding: 45px;
	text-align: center;
	border: 10px solid #ffcccc;
}

.form input {
	font-family: "Roboto", sans-serif;
	outline: 0;
	background: #ffcccc;
	width: 100%;
	border: 3px;
	margin: 0 0 15px;
	padding: 15px;
	box-sizing: border-box;
	font-size: 14px;
}

.form button {
	font-family: "Roboto", sans-serif;
	outline: 3px;
	background: #ffffcc;
	width: 100%;
	border: 0;
	padding: 20px;
	color: #000000;
	font-size: 14px;
	-webkit-transition: all 0.3 ease;
	transition: all 0.3 ease;
	cursor: pointer;
}

.form button:hover, .form button:active, .form button:focus {
	background: #000000;
}
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script src="/Ttonamade/resources/js/jquery3.3.1.min.js"></script>

<script>
		function previewFile() {
			  var preview = document.getElementById('imscr01');
			  var file    = document.querySelector('input[type=file]').files[0];
			  var reader  = new FileReader();
			
			  reader.addEventListener("load", function () {
			    preview.src = reader.result;
			  }, false);
			
			  if (file) {
			    reader.readAsDataURL(file);
			  }
			 
		} 
	</script>
<script>
	    $(document).ready(function(){
	    	
	    	 
			$("#btnclick").click(function(){
				
				var json = {
					prod_id : $("#prod_id").val() 					 
				};
				 
				 $.ajax({					 
					type : "GET",
					url : "prodDataDelete?prod_id="+ ${data.prod_id}  ,
					data : json,
					success : function(data) {
						switch (Number(data)) {
							case 0:
								alert("자료가 삭제 되었습니다.");
								window.location.href = "/Ttonamade/ProdModifychoice";
								break;
							 
							default :
								alert("삭제할수 없는 상품입니다.");
								break;
						}

					},
					error : function(error) {
						alert("오류 발생"+ error);
					}
				});
			});
		});
    </script>
</head>
<body>
	<c:import url="header.jsp" />
	<c:import url="nav.jsp" />
	<form name="form1" action="ProductUpdate" class="form" method="post" enctype="multipart/form-data">
		<input type="hidden" name="prod_id" value="${data.prod_id}" /> <input type="hidden" name="prod_imgsrc" id="prod_imgsrc" value="${data.prod_imgsrc}" />
		<h2>❤상세보기❤</h2>
		<table>
			<tr>
				<td>
					<!-- <td><img  height="240" width="240" src="<c:out value="${data.prod_imgsrc }"/>" alt="..."/>  --> <img id="imscr01" class="card-img-top" width="30" height="300" src="<c:out value="${data.prod_imgsrc }"/>" alt="..." />
					<div>
						<input type="file" id="picture" name="picture" onchange="previewFile()" class="picture">
					</div>
				</td>
				<td>
					<table style="height: 300px; border: 10px double #ffcccc; width: 400px; border-radius: 35px; padding: 10px;">
						<tr style="text-align: center">
							<td style="text-align: center">상품이름</td>
							<td style="text-align: center"><input type="text" name="prod_name" value="${data.prod_name}"></td>
						</tr>
						<tr>
							<td style="text-align: center">상품가격</td>
							<td style="text-align: center"><input type="text" name="prod_price" value="${data.prod_price}"></td>
						</tr>

						<tr>
							<td align="center">주문가능수량</td>
							<td style="text-align: center"><input type="text" name="prod_count" value="${data.prod_count}"></td>
						</tr>
						<tr>
							<td style="text-align: center">상품설명</td>
							<td><textarea name="prod_desc" rows="10" cols="30"><c:out value="${data.prod_desc}" /></textarea></td>
						</tr>
						<tr>
							<td>
								<div class="container_box">
									<div class="container">
										<label>1차 분류</label> <select class="category1" style="width: 100px">
											<option value="">전체</option>
										</select> <label>2차 분류</label> <select class="category2" name="cateCode" style="width: 100px">
											<option value="">전체</option>
										</select>
									</div>
								</div>
							</td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
		<div class="text-center">
			<input type="button" value="back" onclick="history.back(-1)" style="width: 100px" class="form button"> <a href="#" onclick="form1.submit()"><input type="button" value="수 정" id="btn1" style="width: 100px" class="form button"></a> <input type="button" id="btnclick" name="btnclick" value="삭 제 " style="width: 100px" class="form button">
		</div>
	</form>
	<c:import url="footer.jsp" />
</body>
</html>