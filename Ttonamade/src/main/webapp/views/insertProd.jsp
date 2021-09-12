<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 등록</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style type="text/css">
* {
  margin: 0px;
  padding: 0px;
  text-decoration: none;
  font-family:sans-serif;

}

body {
  background-image:#34495e;
}

.joinForm {
  position:absolute;
  width:400px;
  height:400px;
  padding: 30px, 20px;
  background-color:#FFFFFF;
  text-align:center;
  top:40%;
  left:50%;
  transform: translate(-50%,-50%);
  border-radius: 15px;
}

.joinForm h2 {
  text-align: center;
  margin: 30px;
}

.textForm {
  border-bottom: 2px solid #adadad;
  margin: 30px;
  padding: 10px 10px;
}


.prod_name {
  width: 100%;
  border:none;
  outline:none;
  color: #636e72;
  font-size:16px;
  height:25px;
  background: none;
}

.prod_price {
  width: 100%;
  border:none;
  outline:none;
  color: #636e72;
  font-size:16px;
  height:25px;
  background: none;
}

.prod_rating {
  width: 100%;
  border:none;
  outline:none;
  color: #636e72;
  font-size:16px;
  height:25px;
  background: none;
}

.prod_desc {
  width: 100%;
  border:none;
  outline:none;
  color: #636e72;
  font-size:16px;
  height:25px;
  background: none;
}

.picture {
  width: 100%;
  border:none;
  outline:none;
  color: #636e72;
  font-size:16px;
  height:25px;
  background: none;
}

.prod_imgsrc {
  width: 100%;
  border:none;
  outline:none;
  color: #636e72;
  font-size:16px;
  height:25px;
  background: none;
}

.prod_count {
  width: 100%;
  border:none;
  outline:none;
  color: #636e72;
  font-size:16px;
  height:25px;
  background: none;
}

.submitBtn {
    position:relative;
  left:30%;
  transform: translateX(-85%);
  margin-bottom: 40px;
  width:35%;
  height:40px;
  background: linear-gradient(125deg,#81ecec,#6c5ce7,#81ecec);
  background-position: left;
  background-size: 200%;
  color:white;
  font-weight: bold;
  border:none;
  cursor:pointer;
  transition: 0.4s;
  display:inline;
}

.btn:hover {
  background-position: right;
}
</style>


<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script>
	$(document).ready(function() {

		var formObj = $("#dto");

		$("#btnRegister").on("click", function() {
			formObj.attr("action", "insertProd2");
			formObj.attr("method", "post");
			formObj.submit();
		});
	});
</script>

<script >
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


</head>
<body>
<c:import url="header.jsp"/>
<header class="masthead2 bg-primary text-center" style="height:350px">
		<div class="">
			<!-- Masthead Avatar Image-->
			<img class="masthead-avatar" src="/Ttonamade/img/Ttonamade.jpg" style="width:200px; height:200px;">
		</div>
</header>
<section class="page-section portfolio" style="height:1200px;">
<div class="container">
<center>
<h2>🌷상품 등록🌷</h2>
<form:form modelAttribute="dto" class="joinForm" action="insertProd2" enctype="multipart/form-data">

			<div class="textForm">ෆ상품 이름 <form:input path="prod_name" class="prod_name" /></div>
			<div class="textForm">ෆ가격 <form:input path="prod_price" class="prod_price" /></div>
		    <div class="textForm">평점<form:input path="prod_rating" id ="prod_rating" name ="prod_rating"  class="prod_rating" /></div>
			<div class="textForm">ෆ설명<form:textarea path ="prod_desc"  cols="50" rows="5"  class="prod_desc"/></div> 
			<div class="textForm">ෆ이미지<img id ="imscr01" src=""  height="200"   alt="이미지 미리보기..."></div> 	 
			<div class="textForm"> <input type="file" name="picture" id ="picture" onchange="previewFile()" class="picture" /></div>
			<div class="textForm">ෆ수량<form:input path="prod_count"  class="prod_count"/></div>

		</table>
	
	<div>
		<button type="submit" class="btn" id="btnRegister">저장</button>
		 
	</div>
		</form:form>
</center>
</div>
</section>
<c:import url="footer.jsp"/>
</body>
</html>