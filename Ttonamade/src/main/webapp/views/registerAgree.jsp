<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입 약관 동의</title>
<style>
* {
	margin: 0px;
	padding: 0px;
	text-decoration: none;
	font-family: sans-serif;
}

div {
	text-align: center;
}
</style>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<body>
	<c:import url="header.jsp" />
	<c:import url="nav.jsp" />
	<div class="container">
		<div>
			<!-- 회원가입약관 동의 시작 { -->
			<div id="register_agree">
				<h3 class="m-5">🌷약관 동의🌷</h3>
				<form name="fregister" id="fregister" action="/Ttonamade/insertCustInfo" onsubmit="return fregister_submit(this);" method="POST" autocomplete="off">
					<section id="fregister_term">
						<textarea class="w-75" rows="10" cols="150" readonly><c:import url="policy1.jsp" /></textarea>
						<div class="fregister_agree2 checks2">
							<input type="checkbox" name="agree" value="1" id="agree11"> <label for="agree11">이용약관 동의<span>(필수)</span></label>
						</div>
					</section>
					<section id="fregister_private">
						<textarea class="w-75" rows="10" cols="150" readonly><c:import url="policy2.jsp" /></textarea>
						<fieldset class="fregister_agree2 checks2">
							<input type="checkbox" name="agree2" value="1" id="agree21"> <label for="agree21">개인정보 수집 및 이용 동의<span>(필수)</span></label>
						</fieldset>
					</section>
					<!-- <p style="margin: 10px 0;">회원가입약관 및 개인정보처리방침안내의 내용에 동의하셔야 회원가입 하실 수 있습니다.</p> -->
					<div id="fregister_chkall" class="checks2">
						<input type="checkbox" name="chk_all" value="1" id="chk_all"> <label for="chk_all">회원가입 약관에 모두 동의합니다</label>
					</div>
					<div class="btn_confirm">
						<input type="submit" class="btn btn-dark m-2" value="동의" id="submit_btn"> <input type="button" class="btn btn-secondary m-2" value="비동의" id="submit_btn" onclick="location.href='/Ttonamade'">
					</div>
				</form>
				<script>
					function fregister_submit(f) {
						if (!f.agree.checked) {
							alert("회원가입약관의 내용에 동의하셔야 회원가입 하실 수 있습니다.");
							f.agree.focus();
							return false;
						}

						if (!f.agree2.checked) {
							alert("개인정보처리방침안내의 내용에 동의하셔야 회원가입 하실 수 있습니다.");
							f.agree2.focus();
							return false;
						}

						return true;
					}

					jQuery(function($) {
						// 모두선택
						$("input[name=chk_all]").click(function() {
							if ($(this).prop('checked')) {
								$("input[name^=agree]").prop('checked', true);
							} else {
								$("input[name^=agree]").prop("checked", false);
							}
						});
					});
				</script>
			</div>
			<!-- } 회원가입 약관 동의 끝 -->
		</div>
	</div>
	<!-- } 콘텐츠 끝 -->
	<c:import url="footer.jsp" />
</body>
</html>