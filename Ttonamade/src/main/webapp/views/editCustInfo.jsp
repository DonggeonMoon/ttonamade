<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보 수정/탈퇴</title>
</head>
<body>
<c:import url="header.jsp"/>
<h2>회원정보 수정/탈퇴</h2>
<form action="editCustInfo2" method="post">
<table border="1">
    <tr>
        <td>아이디</td>
        <td><c:out value="${list.cust_id}"/></td>
    </tr>
    <tr>
        <td>이름</td>
        <td><c:out value="${list.cust_name}"/></td>
    </tr>
    <tr>
        <td>비밀번호</td>
        <td><input type="password"  name="cust_password" value="${custDto.cust_password}" ></td>
    </tr>
    <tr>
        <td>생년월일</td>
        <td><input type="text" name="cust_birthday" value="${list.cust_birthday}"></td>
    </tr>
    <tr>
        <td>성별</td>
        <td><input type="text" name="cust_sex" value="${list.cust_sex}"></td>
    </tr>
    <tr>
        <td>전화번호</td>
        <td><input type="text" name="cust_telephone"  value="${list.cust_telephone}"></td>
    </tr>
</table>
<input type="hidden" name="cust_id" value="${list.cust_id}">
<input type="hidden" name="cust_name" value="${list.cust_name}">
<input type="submit" value="수정">
</form>
<input type="button" value="탈퇴" onclick="location.href='/Ttonamade/deleteCustInfo'">
<input type="button" value="돌아가기" onclick="history.back(-1)">
</body>
</html>