<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
	<%@ include file="/WEB-INF/views/main/index.jsp"%>
	<meta charset="UTF-8">
	<title>삼천리악기</title>
		
		<link href="${pageContext.request.contextPath}/resources/css/login/which_id_pwd.css" rel="stylesheet">
		
	</head>
	<body>
		
		<div id="cotent_box">
			<input type="button" value="아이디 찾기" onclick="location.href='find_id.do'">
			<input type="button" value="비밀번호 찾기" onclick="location.href='find_pwd.do'">
		</div>
		
	</body>
	
	<%@ include file="/WEB-INF/views/main/footer.jsp"%>
	
</html>