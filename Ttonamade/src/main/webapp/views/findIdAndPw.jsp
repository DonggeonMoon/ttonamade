<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디/비밀번호 찾기</title>
<style type="text/css">

</style>
</head>
<body>
<h2>아이디</h2>
   <form action="findId" method="post">
    이름: <input type="text" name="cust_name" placeholder="이름" required><br>
    전화번호: <input type="text" name="cust_telephone" placeholder="전화번호('-' 제외)" required><br>
    생년월일: <input type="text" name="cust_birthday" placeholder="생년월일 ex)870316" required><br>

    <input type="submit" value="찾기"><br>
</form>
 <h2>비밀번호</h2>
 <!-- 
<form action="findPw" method="post">
				아이디: <input type="text" name="cust_id" placeholder="아이디" required><br>
                이름: <input type="text" name="cust_name" placeholder="이름" required><br>
                전화번호: <input type="text" name="cust_telephone" placeholder="전화번호('-' 제외)" required><br>
    			생년월일: <input type="text" name="cust_birthday" placeholder="생년월일 ex)870316" required><br>
                
        <input type="submit" value="찾기">
</form> -->
</body>
</html>


