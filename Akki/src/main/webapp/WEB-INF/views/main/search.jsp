<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
	<head>
	<%@ include file="/WEB-INF/views/main/index.jsp"%>
	<meta charset="UTF-8">
	<title>삼천리악기</title>
	
		<link href="${pageContext.request.contextPath}/resources/css/main/search.css" rel="stylesheet">
		<link href="${pageContext.request.contextPath}/resources/css/main/main.css" rel="stylesheet">
		
	</head>
	<body>
	
		<c:if test="${ !empty list }">
	
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
				<h2>- 검색 상품목록</h2>
				<c:forEach var="p" items="${list}">
					<div class="item_box">
						<div class="pro_img">
							<img id="pro_img" onclick="detail('${p.p_idx}')" 
								style="background-image:url(${pageContext.request.contextPath}/resources/p_img/${p.p_img})">
						</div>
						<div class="content_box">
							<p>${p.p_name}</p>
							<p>${p.p_brand}</p>
							<p>
								가격 :<f:formatNumber value="${p.p_price}" pattern="#,###" />원
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
	
		</c:if>
	
		<c:if test="${ empty list }">
			<p id="none_product">검색한 상품이 존재하지 않습니다.</p>
		</c:if>
	
	</body>
	
	<%@ include file="/WEB-INF/views/main/footer.jsp"%>

</html>