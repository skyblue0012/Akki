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
	<meta charset="UTF-8">
	<title>삼천리악기</title>
	
		<link href="${pageContext.request.contextPath}/resources/css/user/userPage_index.css" rel="stylesheet">
		
	</head>
	<body>
	
		<div id="user_index">
			<div class="index_content">
				<p>MY서비스</p>
				<p onclick="location.href='userPage_check.do'">회원정보 변경</p>
				<p onclick="location.href='pwd_change.do'">비밀번호 변경</p>
				<p onclick="location.href='user_basket.do'">장바구니</p>
				<p onclick="location.href='order_list.do'">주문조회</p>
				<p onclick="location.href=''">회원탈퇴</p>
			</div>
		</div>	
	
	</body>
	
</html>