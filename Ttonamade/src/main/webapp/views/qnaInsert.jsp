<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/js/bootstrap.bundle.min.js"></script>
<title>문의 작성</title>
</head>
<body>
	<c:import url="header.jsp" />
	<c:import url="nav.jsp" />
	<section class="container-fluid p-3">
		<h2 class="text-center m-2">💌문의하기💌</h2>
		<div class="text-center">
			<form style="border-width: 10px !important; width: 40%;" class="container border border-secondary rounded-3 p-4" action="qnaInsert2">
				<div>
					<label class="w-25 p-2">제목</label><input style="border: 5px solid #ffcccc" type="text" class="w-75" name="title" id="title" />
				</div>
				<div class="d-flex align-items-center">
					<label class="w-25">문의 내용</label>
					<textarea style="border: 5px solid #ffcccc" name="content" class="w-75" id="content" rows="10" cols="50"></textarea>
				</div>
				<div class="p-2">
					<input type="radio" name="privateFlag" id="privateFlag" value="Y" class="radio" /><span>공개</span> <input type="radio" name="privateFlag" id="privateFlag" value="N" class="radio" /><span>비공개</span>
				</div>
				<div>
					<button type="submit" class="btn btn-outline-success m-2">등록하기</button>
				</div>
			</form>
		</div>
	</section>
	<c:import url="footer.jsp" />
</body>
</html>