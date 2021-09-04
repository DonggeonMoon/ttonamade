<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
</head>
<body>
<c:import url="header.jsp"/>
<h2>회원가입</h2>
<form action="insertCustInfo2" method="get" >
<table border="1">
    <tr>
        <td>아이디</td>
        <td><input name="cust_id" ></td>
    </tr>
    <tr>
        <td>이름</td>
        <td><input name="cust_name"></td>
    </tr>
     <tr>
        <td>비밀번호</td>
        <td><input name="cust_password" type = "password"></td>
    </tr>
    <tr>
        <td>성별</td>
        <td><input name="cust_sex"></td>
    </tr>
    <tr>
        <td>전화번호</td>
        <td><input name="cust_telephone"></td>
    </tr>
    <tr>
        <td>생년월일</td>
        <td><input name="cust_birthday"></td>
    </tr>
</table>
<input type = "hidden" value = "U">
<input type="submit" value="제출" >
</form>
</body>
</html>