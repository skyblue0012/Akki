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
	
		<link href="${pageContext.request.contextPath}/resources/css/user/userPage_check.css" rel="stylesheet">
		<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/httpRequest.js"></script>
		
		<script type="text/javascript">
			
			function password_check() {
				
				var password_check = document.getElementById("password_check").value;
				
				if( password_check == "" ) {
					alert("비밀번호를 입력해주세요");
					document.getElementById("password_check").value = "";
					document.getElementById("password_check").focus();
					return;
				}
				
				var url = "userInfo_check.do";
				var param = "password_check=" + password_check;
				
				sendRequest(url, param, password_checked, "POST");
			}
			
			function password_checked() {
				if (xhr.readyState == 4 && xhr.status == 200) {
					var data = xhr.responseText;
					if (data == "wrong") {
						alert("비밀번호가 일치하지 않습니다.");
						document.getElementById("password_check").value = "";
						document.getElementById("password_check").focus();
						return;
					} else if(data == "correct") {
						location.href = "userInfo_change.do";
					}
				}
			}
			
		</script>
		
	</head>
	<body>
	
		<div id="check_box">
			<div class="cb_subject">
				<h2>회원정보 변경</h2>
			</div>
			<div class="pwd_info">
				<p>회원님의 개인정보를 신중히 취급하여, 회원님의 동의없이 기재하신 회원정보가 공개되지 않습니다</p>
				<p>개인정보를 안전하게 보호하기 위해 비밀번호를 다시 한번 입력해주세요</p>
			</div>
			<div class="check_pwd">
				<h3>비밀번호 재확인</h3>
				<p>아이디</p>
				<p>${user.id}</p>
				<p>비밀번호</p>
				<div class="pwd_input">
					<input type="password" id="password_check" onkeypress="if(event.keyCode == 13)password_check();">
				</div>
			</div>
			<input type="button" class="submit" value="확인" onclick="password_check();">
		</div>
		
	</body>
	
	<%@ include file="/WEB-INF/views/main/footer.jsp"%>

</html>