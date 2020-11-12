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
	<meta charset="UTF-8">
	<title>삼천리악기</title>
		
		<link href="${pageContext.request.contextPath}/resources/css/main/index.css" rel="stylesheet">
		<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/httpRequest.js"></script>
		
		<script type="text/javascript">
			
			function detail( p_idx ) {
				location.href="product_detail.do?p_idx="+p_idx;
			}
			
			function check( p_type ) {
				location.href="product_category.do?p_type="+encodeURIComponent(p_type);
			}
			
			function check_brand( p_type, p_brand ) {
				location.href="product_category.do?p_type="+encodeURIComponent(p_type)+"&p_brand="+encodeURIComponent(p_brand);
			}
			
			function searching() {
				var what = document.getElementById('search').value;
				if(what == ""){
					alert("검색어를 입력해주세요.");
					document.getElementById('search').value = "";
					document.getElementById('search').focus();
					return;
				}else{
					location.href = "user_searching.do?what="+encodeURIComponent(what);
				}
				
			}
			
			function add_basket( p_idx, amount ) {
				if( amount == null ) {
					var url = "add_basket.do";
					var param = "p_idx="+p_idx;
					sendRequest(url, param, add_basket_res,"POST");
				} else if( amount != null ) {
					var url = "add_basket.do";
					var param = "p_idx="+p_idx+"&amount="+amount;
					sendRequest(url, param, add_basket_res,"POST");
				}
				
			}
			
			function add_basket_res() {
				if (xhr.readyState == 4 && xhr.status == 200) {
					var data = xhr.responseText;
					if (data == "fail") {
						alert("장바구니 추가에 실패하였습니다");
						return;
					} else if(data == "need_login") {
						alert("로그인후 이용가능합니다");
						location.href="login_page.do"
						return;
					} else if(data == "success") {
						alert("장바구니에 추가되었습니다");
						if( confirm("장바구니로 이동하시겠습니까?") ) {
							location.href="user_basket.do";
							return;
						}
						return;
					} else if(data == "already_basket") {
						if( confirm("장바구니에 동일한 상품이 존재합니다\n장바구니로 이동하시겠습니까?") ) {
							location.href="user_basket.do";
							return;
						}
						return;
					}
				}
			}

			function order_pay_one(p_idx, amount) {
				location.href = "order_payment.do?p_idx="+p_idx+"&amount="+amount;
			}
			
			function logouT(id) {
				if(id==""){
					id="admin";
				}
				var url = "logOut.do";
				var param = "str="+"no"+"&id="+id;
				sendRequest(url, param, out_suc,"POST");
				function out_suc() {
					if( xhr.readyState == 4 && xhr.status == 200 ){
						var data = xhr.responseText;
						if(data == "no"){
							alert("로그아웃 오류");
							return;
						}else{
							alert("로그아웃 성공");
							location.href="main.do";
						}
					}
				}
			}
			
		</script>
		
	</head>
	<body>
	
		<div id="top">
			<!-- 로그인/아웃 등  -->
			<div id="click_box">
				<c:if test="${ !empty sessionScope.user }">
					<p onclick="logouT('${user.id}');">로그아웃</p>
					<p>ㅣ</p>
					<p onclick="location.href='userPage_check.do'">마이페이지</p>
					<p>ㅣ</p>
				</c:if>
				<p onclick="location.href='order_list.do'">주문조회</p>
				<p>ㅣ</p>
				<p onclick="location.href='user_basket.do'">장바구니</p>
				<p>ㅣ</p>
				<c:if test="${ empty sessionScope.user && empty sessionScope.admin }">					
					<p onclick="location.href='sign_up.do'">회원가입</p>
					<p>ㅣ</p>
					<p onclick="location.href='login_page.do'">로그인</p>
				</c:if>
				<c:if test="${ !empty sessionScope.user }">
					<p>${user.name}님 환영합니다</p>
				</c:if>
			</div>
			<!-- 로고  -->
			<img class="logo" src="${pageContext.request.contextPath}/resources/img/logo_color.png" alt="" onclick="location.href='main.do'">
			<!-- 상호명  -->
			<img class="business_name" src="${pageContext.request.contextPath}/resources/img/akki.png" alt="" onclick="location.href='main.do'">
			<!-- 검색박스 -->
			<div id="top_box">
				<div id="search_box">
					<input type="text" id="search" placeholder="Searching.." onkeypress="if(event.keyCode==13){searching();}">
					<img src="${pageContext.request.contextPath}/resources/img/search_black.png" alt="" onclick="searching();">
				</div>
			</div>
		</div>
		
		<nav role="category_bar">
			<ul id="main-menu">
				<li><a href="main.do">메인화면</a></li>
				<li><a onclick="check('어쿠스틱기타')">어쿠스틱기타</a>
					<ul id="brand">
						<c:forEach var="b" items="${category}">
							<c:if test="${b.p_type eq '어쿠스틱기타'}">
								<li><a onclick="check_brand('어쿠스틱기타', '${b.p_brand}');" aria-label="subemnu">${b.p_brand}</a></li>
							</c:if>
						</c:forEach>
					</ul>
				</li>
				<li><a onclick="check('클래식기타')">클래식기타</a>
					<ul id="brand">
						<c:forEach var="b" items="${category}">
							<c:if test="${b.p_type eq '클래식기타'}">
								<li><a onclick="check_brand('클래식기타', '${b.p_brand}');" aria-label="subemnu">${b.p_brand}</a></li>
							</c:if>
						</c:forEach>
					</ul>
				</li>
				<li><a onclick="check('일렉기타')">일렉기타</a>
					<ul id="brand">
						<c:forEach var="b" items="${category}">
							<c:if test="${b.p_type eq '일렉기타'}">
								<li><a onclick="check_brand('일렉기타', '${b.p_brand}');" aria-label="subemnu">${b.p_brand}</a></li>
							</c:if>
						</c:forEach>
					</ul>
				</li>
				<li><a onclick="check('베이스기타')">베이스기타</a>
					<ul id="brand">
						<c:forEach var="b" items="${category}">
							<c:if test="${b.p_type eq '베이스기타'}">
								<li><a onclick="check_brand('베이스기타', '${b.p_brand}');" aria-label="subemnu">${b.p_brand}</a></li>
							</c:if>
						</c:forEach>
					</ul>
				</li>
				<li><a onclick="check('우쿠렐레')">우쿠렐레</a>
					<ul id="brand">
						<c:forEach var="b" items="${category}">
							<c:if test="${b.p_type eq '우쿠렐레'}">
								<li><a onclick="check_brand('우쿠렐레', '${b.p_brand}');" aria-label="subemnu">${b.p_brand}</a></li>
							</c:if>
						</c:forEach>
					</ul>
				</li>
				<li><a onclick="check('앰프')">앰프</a>
					<ul id="brand">
						<c:forEach var="b" items="${category}">
							<c:if test="${b.p_type eq '앰프'}">
								<li><a onclick="check_brand('앰프', '${b.p_brand}');" aria-label="subemnu">${b.p_brand}</a></li>
							</c:if>
						</c:forEach>
					</ul>
				</li>
				<li><a onclick="check('etc')">etc</a>
					<ul id="brand">
						<c:forEach var="b" items="${category}">
							<c:if test="${b.p_type eq 'etc'}">
								<li><a onclick="check_brand('etc', '${b.p_brand}');" aria-label="subemnu">${b.p_brand}</a></li>
							</c:if>
						</c:forEach>
					</ul>
				</li>
			</ul>
		</nav>
		
	</body>
</html>
