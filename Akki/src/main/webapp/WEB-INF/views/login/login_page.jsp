<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<% 
	if(session.getAttribute("user")!=null){
		response.sendRedirect("main.do");
	}
	response.setHeader("Expires", "Sat, 6 May 1995 12:00:00 GMT"); 
	response.setHeader("Cache-Control", "no-store, no-cache, must-revalidate");
	response.addHeader("Cache-Control", "post-check=0, pre-check=0"); 
	response.setHeader("Pragma", "no-cache");
%>
<!DOCTYPE html>
<html>
	<head>
	<%@ include file="/WEB-INF/views/main/index.jsp"%>
	<meta charset="UTF-8">
	<title>삼천리 악기</title>
	
		<link href="${pageContext.request.contextPath}/resources/css/login/login_page.css" rel="stylesheet">
		<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/httpRequest.js"></script>
		
		<script type="text/javascript">
			
			function login_try() {
				var id = document.getElementById("id").value;
				var pwd = document.getElementById("pwd").value;
				
				if(id==""){
					alert("아이디를 입력해주세요.");
              		document.getElementById("id").focus();
              		return;
				}
				if(pwd==""){
					alert("비밀번호를 입력해주세요.");
              		document.getElementById("pwd").focus();
              		return;
				}
				
				var url = "loginCheck.do";
				var param = "id="+id+"&pwd="+pwd;
				sendRequest(url, param, log_check,"POST");
				
				function log_check() {
					if( xhr.readyState == 4 && xhr.status == 200 ){
		       	 		var data = xhr.responseText;
		       	 		if(data == "no_find"){
		              		alert("아이디가 존재하지 않습니다.");
		              		document.getElementById("id").value = "";
		              		document.getElementById("id").focus();
		              		return;
		       	 		}else if(data == "no_pwd"){
		       	 			alert("비밀번호가 일치하지 않습니다.");
		       	 			document.getElementById("pwd").value = "";
		       	 			document.getElementById("pwd").focus();
		       	 			return;
		       	 		}else if(data == "error"){
		       	 			alert("알수없는 오류");
		       	 			return;
		       	 		}else if(data == "h_idLogin"){
		       	 			alert("이미 로그인 되어있는 아이디입니다.\n로그아웃 후 시도해주세요");
		       	 			return;
		       	 		}else{
		       	 			alert("로그인 성공");
		       	 			location.href="main.do";
		       	 		}
					}
				}
			}
		</script>
		
	</head>
	<body>
	
		<div id="sub_nav">
			<ul>
				<li><a href="main.do">HOME</a></li>
				<li>></li>
				<li><a href="#" id="user_login">LOGIN</a></li>
			</ul>
		</div>
	
		<div id="cotent_box">
			<img class="business_name" src="${pageContext.request.contextPath}/resources/img/akki.png" alt="">
			<h2>로그인</h2>
				<input type="text" placeholder="아이디" id="id" onkeypress="if(event.keyCode==13){login_try();}">
				<input type="password" placeholder="비밀번호" id="pwd" onkeypress="if(event.keyCode==13){login_try();}">
				<input type="button" value="로그인" onclick="login_try()">
			<hr>
			<ul>
				<li><a href="which_id_pwd.do">아이디 / 비밀번호 찾기</a></li>
				<li>ㅣ</li>
				<li><a href="sign_up.do">회원가입</a></li>
			</ul>
		</div>
		
	</body>
	
	<%@ include file="/WEB-INF/views/main/footer.jsp"%>
	
</html>