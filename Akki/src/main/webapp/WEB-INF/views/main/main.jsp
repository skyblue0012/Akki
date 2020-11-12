<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
	<head>
	<meta name="naver-site-verification" content="b07efb98f0e307a9cd3c97ee07010027de45097a" />
	<%@ include file="/WEB-INF/views/main/index.jsp"%>
	<meta charset="UTF-8">
	<title>삼천리악기</title>
	
		<link href="${pageContext.request.contextPath}/resources/css/main/main.css" rel="stylesheet">
		
		<script type="text/javascript">
			function detail( p_idx ) {
				location.href="product_detail.do?p_idx="+p_idx;
			}
		</script>
	
	</head>
	<body>
	
		<div class="slide">
			<ul>
				<li>
					<img src="${pageContext.request.contextPath}/resources/img/시그마_배너1.jpg" alt=""
						onclick="check_brand('어쿠스틱기타', '시그마기타');">
				</li>
				<li>
					<img src="${pageContext.request.contextPath}/resources/img/타카미네_배너1.jpg" alt=""
						onclick="check_brand('어쿠스틱기타', '타카미네');">
				</li>
				<li>
					<img src="${pageContext.request.contextPath}/resources/img/타카미네_배너2.jpg" alt=""
						onclick="check_brand('어쿠스틱기타', '타카미네');">
				</li>
				<li>
					<img src="${pageContext.request.contextPath}/resources/img/SGW_배너.jpg" alt=""
						onclick="check_brand('어쿠스틱기타', '삼익기타');">
				</li>
			</ul>
		</div>
		
		<div id="menu_select">
			<ul>
				<li><a href="main.do?order=4">높은가격순</a></li>
				<li>ㅣ</li>
				<li><a href="main.do?order=3">낮은가격순</a></li>
				<li>ㅣ</li>
				<li><a href="main.do?order=2">신상품순</a></li>
				<li>ㅣ</li>
				<li><a href="main.do?order=1">인기순</a></li>
			</ul>
		</div>
	
		<div id="recent">
			<h2>- 상품목록</h2>
			<c:forEach var="p" items="${list}">
				<div class="item_box">
					<div class="pro_img">
						<img id="pro_img" onclick="detail('${p.p_idx}')"
							style="background-image:url(${pageContext.request.contextPath}/resources/p_img/${p.p_img})">
						<div id="hover_box">
							<img id="cart_button" src="${pageContext.request.contextPath}/resources/img/outline_cart_black.png"
								onclick="add_basket('${p.p_idx}')" alt="">
							<img id="search_button" src="${pageContext.request.contextPath}/resources/img/search_black_x2.png"
								onclick="detail('${p.p_idx}')" alt="">
						</div>
					</div>
					<div class="content_box">
						<p>${p.p_name}</p>
						<p>${p.p_brand}</p>
						<p>
							가격 : <f:formatNumber value="${p.p_price}" pattern="#,###" />원
						</p>
					</div>
				</div>
			</c:forEach>
		</div>
	
		<table id="pagemenu">
			<tr height="30">
				<td align="center">${pageMenu}</td>
			</tr>
		</table>
	
	</body>
	
	<%@ include file="/WEB-INF/views/main/footer.jsp"%>

</html>