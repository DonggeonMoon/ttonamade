<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디/비밀번호 찾기</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style type="text/css">
* {
  margin: 0px;
  padding: 0px;
  text-decoration: none;
  font-family:sans-serif;

}

.joinForm {
  position:relative;
  width:400px;
  height:300px;
  background-color:#FFFFFF;
  text-align:left;
}


.joinForm2 {
  position:relative;
  width:400px;
  height:300px;
  background-color:#FFFFFF;
  text-align:left;
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


.cust_name {
  width: 60%;
  border:none;
  outline:none;
  color: #636e72;
  font-size:16px;
  height:25px;
  background: none;
}

.cust_telephone {
  width: 60%;
  border:none;
  outline:none;
  color: #636e72;
  font-size:16px;
  height:25px;
  background: none;
}

.cust_birthday {
  width: 60%;
  border:none;
  outline:none;
  color: #636e72;
  font-size:16px;
  height:25px;
  background: none;
}

.cust_id {
  width: 60%;
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
<section class="page-section portfolio" style="height:900px;">
<center>
<h2>🌷아이디🌷</h2>
<form id="form1" name="form1" action="findId" method="POST" class="joinForm">
    <div class="textForm">ෆ이름: <input type="text" name="cust_name" class="cust_name" placeholder="이름" required><br></div>
    <div class="textForm">ෆ전화번호: <input type="text" name="cust_telephone" class="cust_telephone" placeholder="전화번호('-' 제외)" required><br></div>
    <div class="textForm">ෆ생년월일: <input type="text" name="cust_birthday" class="cust_birthday" placeholder="생년월일 ex)870316" required><br></div>
<center>
    <input type="submit" class="btn2" value="찾기"><br>
</center>
</form>
 <h2>🌷비밀번호🌷</h2>
<form id="form2" name="form2" action="findPw" method="POST" class="joinForm2" >
				<div class="textForm">ෆ아이디: <input type="text" name="cust_id" class="cust_id" placeholder="아이디" required><br></div>
                <div class="textForm">ෆ이름: <input type="text" name="cust_name" class="cust_name" placeholder="이름" required><br></div>
                <div class="textForm">ෆ전화번호: <input type="text" name="cust_telephone" class="cust_telephone" placeholder="전화번호('-' 제외)" required><br></div>
    			<div class="textForm">ෆ생년월일: <input type="text" name="cust_birthday" class="cust_birthday" placeholder="생년월일 ex)870316" required><br></div>
<center>                
        <input type="submit" class="btn2" value="찾기">
</center>
</form>
</center>

</section>
<c:import url="footer.jsp"/>
</body>
</html>


