<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
	<head>
	<%@ include file="/WEB-INF/views/main/index.jsp"%>
	<meta charset="UTF-8">
	<title>삼천리 악기</title>
	
		<link href="${pageContext.request.contextPath}/resources/css/user/order_success.css" rel="stylesheet">
		
	</head>
	<body>
		<!-- 상품 출력 -->
		<div id="oc_allbox">
			<h2>주문완료</h2>
			<img class="top_navimg" src="${pageContext.request.contextPath}/resources/img/order_step4.gif" alt="" >
		</div>
		<div id="oc_mainbox">
			<img class="top_navimg" src="${pageContext.request.contextPath}/resources/img/check_icon.png" alt="" >
			<p>고객님의 주문이 완료되었습니다</p>
			<p>주문내역 및 배송에 관한 안내는 주문조회를 통하여 확인이 가능합니다.</p>
			<p>주문번호 : ${pay_vo.o_no}</p>
			<p>주문일자 : ${pay_vo.o_date}</p>
		</div>
		<p id="oc_order_info">결제정보</p>
		<div id="oc_mainbox2">
			<p>최종결제금액</p>
			<p><f:formatNumber value="${pay_vo.o_price}" pattern="#,###" />원</p>
			<p>결제수단</p>
			<p>
				<c:if test="${pay_vo.o_pay eq 'card'}">
					신용카드
				</c:if>
				<c:if test="${pay_vo.o_pay eq 'trans'}">
					실시간 계좌이체
				</c:if>
				<c:if test="${pay_vo.o_pay eq 'bank'}">
					무통장입금 | 입금자 : ${bank_vo.b_name}, 입금계좌 : ${bank_vo.b_account}
				</c:if>
			</p>
		</div>
		<p id="oc_product_info">주문 상품 정보</p>
		<table id="oc_table_proinfo">
			<tr class="oc_table_info">
				<th>이미지</th>
				<th>상품정보</th>
				<th>판매가</th>
				<th>수량</th>
				<th>적립금</th>
				<th>배송구분</th>
				<th>합계</th>
			</tr>
			<!-- for문으로 조지는 부분 -->
			<c:forEach var="o" items="${pay_list}">
				<tr class="oc_table_product">
					<td>
						<img src="${pageContext.request.contextPath}/resources/p_img/${o.p_img}" alt="">
					</td>
					<td>
						<p>${o.p_name}</p>
					</td>
					<td><f:formatNumber value="${o.p_price}" pattern="#,###" />원</td>
					<td>${o.amount}</td>
					<td>-</td>
					<c:if test="${50000 lt pay_vo.o_price}">
						<th>무료배송</th>
					</c:if>
					<c:if test="${50000 gt pay_vo.o_price}">
						<th>기본배송</th>
					</c:if>
					<td>
						<f:formatNumber value="${o.p_price * o.amount}" pattern="#,###" />원
					</td>
				</tr>
			</c:forEach>
			<!-- for끝 -->
			<tr class="oc_table_footer">
				<c:if test="${50000 lt pay_vo.o_price}">
					<td>[무료배송]</td>
					<td colspan="6">
						상품구매금액 <f:formatNumber value="${pay_vo.o_price}" pattern="#,###" /> + 배송비 0 = 합계 : <f:formatNumber value="${pay_vo.o_price}" pattern="#,###" />원
					</td>
				</c:if>
				<c:if test="${50000 gt pay_vo.o_price}">
					<td>[기본배송]</td>
					<td colspan="6">
						상품구매금액 <f:formatNumber value="${pay_vo.o_price - 2500}" pattern="#,###" /> + 배송비 2,500 = 합계 : <f:formatNumber value="${pay_vo.o_price}" pattern="#,###" />원
					</td>
				</c:if>
			</tr>
		</table>
		
		<table id="oc_conten_price" border="1">
			<tr>
				<th>총 주문금액</th>
				<th>총 결제금액</th>
			</tr>
			<tr>
				<td><f:formatNumber value="${pay_vo.o_price}" pattern="#,###" />원</td>
				<td><f:formatNumber value="${pay_vo.o_price}" pattern="#,###" />원</td>
			</tr>
		</table>
		
		<p id="oc_content_adinfo">배송지 정보</p>
		<table id="oc_content_info" border="1">
			<tr>
				<th>받으시는분</th>
				<td>${del_vo.d_name}</td>
			</tr>
			<tr>
				<th>주소</th>
				<td>${del_vo.d_addr}</td>
			</tr>
			<tr>
				<th>일반전화</th>
				<td>${del_vo.d_telhome}</td>
			</tr>
			<tr>
				<th>휴대전화</th>
				<td>${del_vo.d_tel}</td>
			</tr>
			<tr>
				<th>배송메세지</th>
				<td>${del_vo.d_dm}</td>
			</tr>
		</table>
		
		<div id="footer_info">
			<p>이용안내</p>
			<p>
				1. 배송은 결제완료 후 지역에 따라 1일 ~ 2일 가량이 소요됩니다.<br>
				2. 상품별 자세한 배송과정은 주문조회를 통하여 조회하실 수 있습니다.<br>
				3. 주문의 취소 및 환불, 교환에 관한 사항은 이용안내의 내용을 참고하십시오.<br>
				<br>
				<strong>세금계산서 발행 안내</strong>
				<br><br>
				1. 부가가치세법 제 54조에 의거하여 세금계산서는 배송완료일로부터 다음달 10일까지만 요청하실 수 있습니다<br>
				2. 세금계산서는 사업자만 신청할 수 있습니다.<br>
				3. 배송이 완료된 주문에 한하여 세금계산서 발행신청이 가능합니다<br>
				4. 세금계산서 신청은 세금계산서 신청양식을 작성한 후 팩스로 사업자등록증사본을 보내셔야 세금계산서 발행이 가능합니다.<br>
				5. 자세한 사항은 전화로 문의 주시기 바랍니다.<br>
				<br>
				<strong>부가가치세법 변경에 따른 신용카드매출전표 및 세금계산서 변경안내</strong>
				<br><br>
				1. 변경된 부가가치세법에 의거. 2004.7.1 이후 신용카드로 결제하신 주문에 대해서는 세금계산서 발행이 불가하며<br>
				2. 신용카드매출전표로 부가가치세 신고를 하여야 합니다.(부가가치세법 시행령 57조)<br>
				3. 상기 부가가치세법 변경내용에 따라 신용카드 이외의 결제건에 대해서만 세금계산서 발행이 가능함을 양지하여 주시기 바랍니다.<br>
				<br>
				<strong>현금영수증 이용안내</strong>
				<br><br>
				1. 현금영수증은 1원 이상의 현금성거래(무통장입금, 실시간계좌이체, 에스크로, 예치금)에 대해 발행이 됩니다.<br>
				2. 현금영수증 발행 금액에는 배송비는 포함됩니다.<br>
				3. 발생신청 기간제한 현금영수증은 입금확인일로 부터 48시간안에 발행을 해야 합니다.<br>
				4. 현금영수증 발행 취소의 경우는 시간 제한이 없습니다 (국세청의 정책에 따라 변경 될 수 있습니다.)<br>
				5. 현금영수증이나 세금계산서 중 하나만 발행 가능합니다.
			</p>
		</div>
			
	</body>
	
	<%@ include file="/WEB-INF/views/main/footer.jsp"%>

</html>