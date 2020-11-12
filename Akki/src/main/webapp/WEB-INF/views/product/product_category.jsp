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
		
		<link href="${pageContext.request.contextPath}/resources/css/product/product_category.css" rel="stylesheet">
		
		<script>
			
			window.onload = function() {
				var p_brand = "${p_brand}";
				if ("${p_brand}" != "") {
					document.getElementById('${p_brand}').style.fontWeight = 900;
				} else {
					document.getElementById('all').style.fontWeight = 900;
				}
			};
			
			function check_order(order, p_type, p_brand) {
				location.href="product_category.do?order="+order+"&p_type="+encodeURI(p_type)+"&p_brand="+encodeURI(p_brand);
			}
			
		</script>
	
	</head>
	<body>
		
		<c:if test="${ !empty list }">
		
			<div id="sub_nav">
				<ul>
					<li><a href="main.do">HOME</a></li>
					<li>></li>
					<li><a onclick="check('${list[0].p_type}')" id="cate_name">${list[0].p_type}</a></li>
				</ul>
			</div>
		
			<div id="cate_top">
				<h1>${list[0].p_type}</h1>
				
				<ul>
					<li><a onclick="check('${list[0].p_type}')" id="all">ALL</a></li>
					<!-- for문으로 반복하여 브랜드 개수만큼 출력 시작-->
					<c:forEach var="b" items="${category}">
						<c:if test="${b.p_type eq list[0].p_type}">
							<li>/</li>
							<li>
								<a onclick="check_brand('${b.p_type}', '${b.p_brand}')" id="${b.p_brand}">${b.p_brand}</a>
							</li>
						</c:if>
					</c:forEach>
					<!-- for문 감싸는 부분 끝 -->
		
				</ul>
		
			</div>
			
			<!-- 총 개수 -->
			<div id="product_total">
				<p>총 : ${p_cnt}개</p>
			</div>
			
			<div id="menu_select">
				<ul>
					<li><a onclick="check_order(4,'${list[0].p_type}', '${list[0].p_brand}')">높은가격순</a></li>
					<li>ㅣ</li>
					<li><a onclick="check_order(3,'${list[0].p_type}', '${list[0].p_brand}')">낮은가격순</a></li>
					<li>ㅣ</li>
					<li><a onclick="check_order(2,'${list[0].p_type}', '${list[0].p_brand}')">신상품순</a></li>
					<li>ㅣ</li>
					<li><a onclick="check_order(1,'${list[0].p_type}', '${list[0].p_brand}')">인기순</a></li>
				</ul>
			</div>
			
			<div id="content">
				
				<c:forEach var="c" items="${list}">
					<div class="product_box">
						<img style="background-image:url(${pageContext.request.contextPath}/resources/p_img/${c.p_img})" 
							onclick="detail('${c.p_idx}')" alt="">
						<p class="product_name">${c.p_name}</p>
						<p class="product_name">Price : <f:formatNumber value="${c.p_price}" pattern="#,###"/>원</p>
						<p class="product_name">Brand : ${c.p_brand}</p>
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
			<p id="none_product">상품 준비중입니다.</p>
		</c:if>
		
	</body>
	
	<%@ include file="/WEB-INF/views/main/footer.jsp"%>
	
</html>