<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	<title>삼천리악기 관리자</title>
		
		<link href="${pageContext.request.contextPath}/resources/css/admin/admin_index.css" rel="stylesheet">
		
	</head>
	<body>
		
		<input id="menu" type="checkbox" /><label for="menu">&equiv;</label>
		
		<nav>
			<header>메뉴</header>
			<ul>
				<li><a href="add_product.do">상품 등록</a></li>
				<li><a href="admin_main.do">상품 목록</a></li>
				<li><a href="#">주문 목록</a></li>
				<li><a href="#">회원 목록</a></li>
			</ul>
		</nav>
		
	</body>
</html>