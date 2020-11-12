<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<% 
   response.setHeader("Expires", "Sat, 6 May 1995 12:00:00 GMT"); 
   response.setHeader("Cache-Control", "no-store, no-cache, must-revalidate");
   response.addHeader("Cache-Control", "post-check=0, pre-check=0"); 
   response.setHeader("Pragma", "no-cache");
%>

<!DOCTYPE html>
<html>
	<head>
	<%@ include file="/WEB-INF/views/main/index.jsp"%>
	<%@ include file="/WEB-INF/views/user/userPage_index.jsp"%>
	<meta charset="UTF-8">
	<title>삼천리악기</title>
	
		<link href="${pageContext.request.contextPath}/resources/css/user/userPwd_change.css" rel="stylesheet">
		<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/httpRequest.js"></script>
		
		<script type="text/javascript">
			
			function password_change() {
				
				var pwd1 = document.getElementById("pwd1").value;
				var pwd2 = document.getElementById("pwd2").value;
				var pwd3 = document.getElementById("pwd3").value;
				
				var real_pwd = /^[A-Za-z0-9]{6,12}$/;
				
				if (!real_pwd.test(pwd1)) {
					alert("영문과 숫자를 조합한 6~12 자리 비밀번호를 입력하세요");
					document.getElementById("pwd1").value = "";
					document.getElementById("pwd1").focus();
					return;
				}
				if (!real_pwd.test(pwd2)) {
					alert("영문과 숫자를 조합한 6~12 자리 비밀번호를 입력하세요");
					document.getElementById("pwd2").value = "";
					document.getElementById("pwd2").focus();
					return;
				}
				if (!real_pwd.test(pwd3)) {
					alert("영문과 숫자를 조합한 6~12 자리 비밀번호를 입력하세요");
					document.getElementById("pwd3").value = "";
					document.getElementById("pwd3").focus();
					return;
				}
				if( pwd1 == "" ) {
					alert("비밀번호를 입력해주세요");
					document.getElementById("pwd1").value = "";
					document.getElementById("pwd1").focus();
					return;
				}
				if( pwd2 == "" ) {
					alert("비밀번호를 입력해주세요");
					document.getElementById("pwd2").value = "";
					document.getElementById("pwd2").focus();
					return;
				}
				if( pwd3 == "" ) {
					alert("비밀번호를 입력해주세요");
					document.getElementById("pwd3").value = "";
					document.getElementById("pwd3").focus();
					return;
				}
				if( pwd1 == pwd2 || pwd1 == pwd3 ) {
					alert("현재 비밀번호와 동일한 비밀번호로 바꾸실 수 없습니다");
					document.getElementById("pwd2").value = "";
					document.getElementById("pwd3").value = "";
					document.getElementById("pwd2").focus();
					return;
				}
				if( pwd2 != pwd3 ) {
					alert("변경하실 비밀번호가 일치하지 않습니다");
					document.getElementById("pwd2").value = "";
					document.getElementById("pwd3").value = "";
					document.getElementById("pwd2").focus();
					return;
				}
				
				var url = "pwd_change_check.do";
				var param = "pwd1=" + pwd1 + "&pwd2=" + pwd2 + "&pwd3=" + pwd3;
				
				sendRequest(url, param, password_changed, "POST");
			}
			
			function password_changed() {
				if (xhr.readyState == 4 && xhr.status == 200) {
					var data = xhr.responseText;
					if (data == "wrong_pwd") {
						alert("현재 비밀번호가 일치하지 않습니다");
						document.getElementById("pwd1").value = "";
						document.getElementById("pwd2").value = "";
						document.getElementById("pwd3").value = "";
						document.getElementById("pwd1").focus();
						return;
					} else if(data == "different_pwd") {
						alert("변경하실 비밀번호가 일치하지 않습니다");
						document.getElementById("pwd1").value = "";
						document.getElementById("pwd2").value = "";
						document.getElementById("pwd3").value = "";
						document.getElementById("pwd1").focus();
						return;
					} else if(data == "success") {
						alert("비밀번호 변경이 완료되었습니다\n다시 로그인해 주시기 바랍니다");
						location.href="just_logout.do";
						return;
					}
				}
			}
			
			function cancel() {
				if( confirm("비밀번호 변경을 취소할까요?")) {
					location.href="main.do";
				}
				return;
			}
			
		</script>
		
	</head>
	<body>
		<div id="change_box">
			<div id="content_top">
				<p>비밀번호 변경</p>
			</div>
				
			<table class="change_pwd">
				<!-- 현재 비밀번호 -->
				<tr>
					<th><label for="id">현재 비밀번호</label></th>
					<td>
						<input type="password" id="pwd1" name="pwd">
					</td>
				</tr>
				<!-- 비밀번호 변경 -->
				<tr>
					<th><label for="name">변경 비밀번호</label></th>
					<td>
						<input type="password" id="pwd2" name="change_pwd">
					</td>
				</tr>
				<!-- 비밀번호 확인 -->
				<tr>
					<th><label for="name">비밀번호 확인</label></th>
					<td>
						<input type="password" id="pwd3" name="check_pwd">
					</td>
				</tr>
			</table>
			<div id="cotent_bottom">
				<input type="button" value="확인" onclick="password_change();">
				<input type="button" value="취소" onclick="cancel();">
			</div>
			
		</div>	

	</body>
	
	<%@ include file="/WEB-INF/views/main/footer.jsp"%>

</html>