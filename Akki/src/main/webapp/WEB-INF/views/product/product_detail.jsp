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
	
		<link href="${pageContext.request.contextPath}/resources/css/product/product_detail.css" rel="stylesheet">
		<body onload="init();">
		<script type="text/javascript">
			
			var sell_price;
			var amount;
			
			function init () {
				sell_price = document.getElementById("sell_price").value; 
				amount = document.getElementById("amount").value;
				sum_real = Comma(sell_price) +"원" ;
				document.getElementById("sum").value = sum_real;
				change();
            }
			
            function add () {
            	document.getElementById("amount").value++;
            	sum_real = Comma(parseInt(document.getElementById("amount").value) * sell_price) + "원";
            	sum.value = sum_real;
            }
            
            function del () {
            	if (document.getElementById("amount").value > 1) {
            		document.getElementById("amount").value --;
            		sum_real = Comma(parseInt(document.getElementById("amount").value) * sell_price) + "원";
            		sum.value = sum_real;
           		}
           	}
            
            function change () {
            	document.getElementById("amount").value;
            	document.getElementById("sum").value;
            	if (document.getElementById("amount").value < 0) {
            		document.getElementById("amount").value = 0;
           		}
            	sum_real = Comma(parseInt(document.getElementById("amount").value) * sell_price) + "원";
            	sum.value = sum_real;
           	}

            function Comma(n) {
                return n.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
            }
			
		</script>
	</head>
	<body>
	
		<!-- 클릭시 홈, 대분류, 브랜드로 이동 -->
		<div class="cate">
			<p>HOME</p>
			<p>></p>
			<p>${vo.p_type}</p>
			<p>></p>
			<p>${vo.p_brand}</p>
		</div>
	
		<!-- 상품 디테일 (가격, 상품명, 이미지) -->
		<div id="product_detail">
			<div id="product_img">
				<img src="${pageContext.request.contextPath}/resources/p_img/${vo.p_img}" alt="">
			</div>
			
			<div id="product_infobox">
				<div class="pro_name">
					<p>${vo.p_name}</p>
					<!-- 상품이름 -->
				</div>
				<div class="pro_info">
					<p>제조사</p>
					<p>${vo.p_brand}</p>
					<p>원산지</p>
					<p>${vo.p_origin}</p>
					<p>판매가</p>
					<p>
						<f:formatNumber value="${vo.p_price}" pattern="#,###" />원
					</p>
				</div>
				<div class="pro_cnt">
					<p class="p_name">${vo.p_name}</p>
					<!-- 상품이름 -->
					<div class="product_cnt">
						<input type=hidden id="sell_price" name="sell_price" value="${vo.p_price}">
						<input type="text" id="amount" name="amount" value="1" size="3" onchange="change();">
						<input type="button" value=" + " onclick="add();">
						<input type="button" value=" - " onclick="del();">
						<div class="price_sum">
							<p class="t_p">총 상품금액 :</p>
							<input type="text" id="sum" name="sum" size="11" readonly="readonly">
						</div>
						<p class="p_price">
							<f:formatNumber value="${vo.p_price}" pattern="#,###" />원
						</p>
					</div>
				</div>
				<div id="product_button">
					<input type="button" value="구매하기"
						onclick="order_pay_one('${vo.p_idx}', document.getElementById('amount').value)" />
					<input type="button" value="장바구니"
						onclick="add_basket('${vo.p_idx}', document.getElementById('amount').value)" />
				</div>
			</div>
	
			<div id="detail_suvinfo">
				<ul>
					<li>상품상세정보</li>
					<li>상품구매안내</li>
					<li>상품배송안내</li>
				</ul>
			</div>
			
			<div class="detail_imgbox">
				<img src="${pageContext.request.contextPath}/resources/p_img/${vo.p_content_img}" alt="">
			</div>
			<br>
			<div class="prd_info -section">
				<div class="area_title">
		            <h3>상품결제정보</h3>
		        </div>
		        <p class="info_text">
		        	고액결제의 경우 안전을 위해 카드사에서 확인전화를 드릴 수도 있습니다. 확인과정에서 도난 카드의 사용이나 타인 명의의 주문등
		        	정상적인 주문이 아니라고 판단될 경우 임의로 주문을 보류 또는 취소할 수 있습니다. &nbsp;
	        		<br>
	        		<br>
	        		무통장 입금은 상품 구매 대금은 PC뱅킹, 인터넷뱅킹, 텔레뱅킹 혹은 가까운 은행에서 직접 입금하시면 됩니다. &nbsp;
	        		<br>
	        		주문시 입력한&nbsp;입금자명과 실제입금자의 성명이 반드시 일치하여야 하며, 7일 이내로 입금을 하셔야 하며&nbsp;입금되지
	        		않은 주문은 자동취소 됩니다.
        			<br>
		        </p>
		    </div>
			<br>
			<div class="prd_info -section">
		        <div class="area_title">
		            <h3>배송정보</h3>
		        </div>
		        <p class="info_text">
		        	배송 방법 : 택배<br>
		        	배송 지역 : 전국지역<br>
		        	배송 비용 : 2,500원<br>
		        	배송 기간 : 1일 ~ 2일<br>
		        	배송 안내 : - 산간지역이나 도서지방은 별도의 추가금액을 지불하셔야 하는 경우가 있습니다.<br>
		        	고객님께서 주문하신 상품은 입금 확인후 배송해 드립니다. 다만, 상품종류에 따라서 상품의 배송이 다소 지연될 수 있습니다.<br>
		        </p>
		    </div>
			<br>
			<div class="prd_info -section">
		        <div class="area_title">
		            <h3>교환 및 반품정보</h3>
		        </div>
		        <p class="info_text">
		        	<b>교환 및 반품이 가능한 경우</b><br>
		        	- 상품을 공급 받으신 날로부터 7일이내 단, 가전제품의<br>
		        	&nbsp;&nbsp;경우 포장을 개봉하였거나 포장이 훼손되어 상품가치가 상실된 경우에는 교환/반품이 불가능합니다.<br>
		        	- 공급받으신 상품 및 용역의 내용이 표시.광고 내용과<br>
		        	&nbsp;&nbsp;다르거나 다르게 이행된 경우에는 공급받은 날로부터 3월이내, 그사실을 알게 된 날로부터 30일이내<br>
		        	<br>
		        	<b>교환 및 반품이 불가능한 경우</b><br>
		        	- 고객님의 책임 있는 사유로 상품등이 멸실 또는 훼손된 경우. 단, 상품의 내용을 확인하기 위하여<br>
		        	&nbsp;&nbsp;포장 등을 훼손한 경우는 제외<br>
		        	- 포장을 개봉하였거나 포장이 훼손되어 상품가치가 상실된 경우<br>
		        	&nbsp;&nbsp;(예 : 가전제품, 식품, 음반 등, 단 액정화면이 부착된 노트북, LCD모니터, 디지털 카메라 등의 불량화소에<br>
		        	&nbsp;&nbsp;따른 반품/교환은 제조사 기준에 따릅니다.)<br>
		        	- 고객님의 사용 또는 일부 소비에 의하여 상품의 가치가 현저히 감소한 경우 단, 화장품등의 경우 시용제품을 <br>
		        	&nbsp;&nbsp;제공한 경우에 한 합니다.<br>
		        	- 시간의 경과에 의하여 재판매가 곤란할 정도로 상품등의 가치가 현저히 감소한 경우<br>
		        	- 복제가 가능한 상품등의 포장을 훼손한 경우<br>
		        	&nbsp;&nbsp;(자세한 내용은 고객만족센터 1:1 E-MAIL상담을 이용해 주시기 바랍니다.)<br>
		        	<br>
		        	※ 고객님의 마음이 바뀌어 교환, 반품을 하실 경우 상품반송 비용은 고객님께서 부담하셔야 합니다.<br>
		        	&nbsp;&nbsp;(색상 교환, 사이즈 교환 등 포함)<br>
		        </p>
		    </div>
			
		</div>
	</body>
	
	<%@ include file="/WEB-INF/views/main/footer.jsp"%>

</html>