<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보 수정/탈퇴</title>
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
  text-align:left;
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


.cust_id {
  width: 100%;
  border:none;
  outline:none;
  color: #636e72;
  font-size:16px;
  height:25px;
  background: none;
}

.cust_name {
  width: 100%;
  border:none;
  outline:none;
  color: #636e72;
  font-size:16px;
  height:25px;
  background: none;
}

.cust_password {
  width: 100%;
  border:none;
  outline:none;
  color: #636e72;
  font-size:16px;
  height:25px;
  background: none;
}

.cust_sex {
  width: 100%;
  border:none;
  outline:none;
  color: #636e72;
  font-size:16px;
  height:25px;
  background: none;
}

.cust_telephone {
  width: 100%;
  border:none;
  outline:none;
  color: #636e72;
  font-size:16px;
  height:25px;
  background: none;
}

.cust_birthday {
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
</head>
<body>
<c:import url="header.jsp"/>
<header class="masthead2 bg-primary text-center" style="height:350px">
		<div class="">
			<!-- Masthead Avatar Image-->
			<img class="masthead-avatar" src="/Ttonamade/img/Ttonamade.jpg" style="width:200px; height:200px;">
		</div>
</header>
<section class="page-section portfolio" style="height:1000px;">
<div class="container">
<center>
<h2 style="position:relative;left:50%;transform:translateX(-50%)">🌷회원정보 수정/탈퇴🌷</h2>
</center>
<form id="form1" name="form1" action="editCustInfo2" method="POST" class="joinForm" >
    <div class="textForm">
        ෆ아이디
        <c:out value="${list.cust_id}"/>
    </div>
    <div class="textForm">
        ෆ이름
        <c:out value="${list.cust_name}"/>
    </div>
    <div class="textForm">
        ෆ비밀번호<br>
        <input type="password"  name="cust_password" class="cust_password" value="${custDto.cust_password}" >
    </div>
     <div class="textForm">
    	ෆ전화번호
    	<br>
        <input type="text" name="cust_telephone" class="cust_telephone" value="${list.cust_telephone}">
    </div>  
    <div class="textForm">
        ෆ성별
        <br>
        <input type="text" name="cust_sex" class="cust_sex" value="${list.cust_sex}">
    </div>
   <div class="textForm">
        ෆ생년월일
        <br>
        <input type="text" name="cust_birthday" class="cust_birthday" value="${list.cust_birthday}">
    </div> 
<input type="hidden" name="cust_id" value="${list.cust_id}">
<input type="hidden" name="cust_name" value="${list.cust_name}">
<center>
<input type="submit" class="btn" value="수정">
<input type="button"  class="btn"value="탈퇴" onclick="location.href='/Ttonamade/deleteCustInfo'">
<input type="button" class="btn" value="돌아가기" onclick="history.back(-1)">
</center>
</form>

</div>
</section>
<c:import url="footer.jsp"/>
</body>
</html>    