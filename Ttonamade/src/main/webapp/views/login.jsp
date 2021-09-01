<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
</head>
<body>
<h2>로그인</h2>
<form action="/Ttonamade/login" method="post">
<div>ID: <input type="text" name="cust_id"></div>
<div>PW: <input type="password" name="cust_password"></div>
<input type="submit" value="로그인">
</form>
<input type="button" value="회원가입" onclick="location.href='/Ttonamade/insertCustInfo'">
<input type="button" value="아이디/비밀번호 찾기" onclick="location.href='/Ttonamade/findIdAndPw'">
<input type="button" value="돌아가기" onclick="history.back(-1)">

</body>
</html>