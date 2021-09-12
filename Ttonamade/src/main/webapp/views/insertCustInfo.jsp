<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
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
<script>
var idChk = false;
$(document).ready(function() {
	$("#idCheck").click(function() {
		var cust_id = $("#cust_id").val();
		
		if (cust_id != "") {
			$.ajax({
				async: true,
				type: 'POST',
				data: cust_id,
				url: "idCheck",
				dataType: "json",
				contentType:"application/json; charset=UTF-8",
				success: function(data) {
					if(data.isUnique) {
						alert("사용 가능한 아이디입니다.");
						$("#cust_password").focus();
						idChk = true;
					} else {
						alert("이미 존재하는 아이디입니다.");
						$("#cust_id").focus();
					}
				},
				error: function(error) {
					alert("error: " + error);
				}
			});
		} else {
			alert("아이디를 입력해주세요.");
		}
	});
});

function submitForm(){
	if (idChk) {
		$("#form1").submit();
	}
	else {-
		alert("아이디 중복 확인을 해주세요.");
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
<section class="page-section portfolio" style="height:1000px;">
<div class="container">
<center>
<h2>🌷회원가입🌷</h2>
<form id="form1" name="form1" action="insertCustInfo2" method="POST" class="joinForm" >
      <div class="textForm">
        <input id="cust_id" name="cust_id" type="text" class="cust_id" placeholder="ෆ아이디">
        <input id="idCheck" style="float:right;transform:translateY(-100%);" type="button" value="ID 중복 확인">
      </div>
      <div class="textForm">
        <input name="cust_password" type="password" class="cust_password" placeholder="ෆ비밀번호">
      </div>
       <div class="textForm">
        <input name="loginPwConfirm" type="password2" class="cust_password" placeholder="ෆ비밀번호 확인">
      </div>
      <div class="textForm">
        <input name="cust_name" type="text" class="cust_name" placeholder="ෆ이름">
      </div>
      <div class="textForm">
        <input name="cust_telephone" type="text" class="cust_telephone" placeholder="ෆ전화번호">
      </div>
      <div class="textForm">
        <input name="cust_sex" type="text" class="cust_sex" placeholder="ෆ성별">
      </div>
      <div class="textForm">
        <input name="cust_birthday" type="text" class="cust_birthday" placeholder="ෆ생년월일">
      </div>
      <input type="submit" class="btn" value="J O I N" onclick="submitForm();"/>
      <input type = "hidden" value = "U">
    </form>
</center>
</div>
</section>
<c:import url="footer.jsp"/>
</body>
</html>