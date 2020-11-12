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
	
		<link href="${pageContext.request.contextPath}/resources/css/user/order_list.css" rel="stylesheet">
		
		<script type="text/javascript">
			
			window.onload = function () {
				
				var mode = '<c:out value="${map.mode}"/>';
				
				if( mode == "cancel" ) {
					var navbox2 = document.getElementById('navbox2_p').style;
					var navbox1 = document.getElementById('navbox1_p').style;
					
					navbox2.background = "#000975";
					navbox2.color = "white";
					
					navbox1.background = "white";
					navbox1.color = "black";
				}

				var list = new Array();
				var list_origin = new Array();
				
				<c:forEach items="${list}" var="item">
					list_origin.push("${item.o_idx}");
				</c:forEach>
				
				list = list_origin.filter(function(item, pos, self) {
				    return self.indexOf(item) == pos;
				});
				
				for( var i = 0; i < list.length; i++ ) {
					
					var count = 0;
					
					for( var j = 0; j < list_origin.length; j++ ) {
						
						if( list[i] == list_origin[j] ) {
							count++;
						}
						
					}
					
					var bas = "s";
					
					var obj = document.getElementById(list[i]);
					obj.setAttribute("id", bas+list[i]);
					
					document.getElementById(bas+list[i]).rowSpan = count;
					
					if( count > 1 ) {
						
						for( var k = 1; k < count; k++ ) {
							
							bas+="s";
							
							var obj2 = document.getElementById(list[i]);
							obj2.setAttribute("id", bas+list[i]);
							
							document.getElementById(bas+list[i]).style.display = "none";
							
						}
						
					}
					
				}
				
			}
			
			//익스플로러 브라우저인 경우 날짜입력 자동 대시
			function dateFormat(el){
				
				if ((navigator.appName == 'Netscape' && navigator.userAgent.search('Trident') != -1) || (agent.indexOf("msie") != -1))
					
					if(el.value.replace(/[0-9 \-]/g, "").length == 0) {
						
						//하이픈(-)기호를 제거한다.
		                let number = el.value.replace(/[^0-9]/g,"");
		                let ymd = "";
		                
		                //문자열의 길이에 따라 Year, Month, Day 앞에 하이픈(-)기호를 삽입한다.
		                if(number.length < 4) {
		                    
		                	return number;
		                    
		                } else if(number.length < 6){
		                    ymd += number.substr(0, 4);
		                    ymd += "-";
		                    ymd += number.substr(4);
		                } else {
		                    ymd += number.substr(0, 4);
		                    ymd += "-";
		                    ymd += number.substr(4, 2);
		                    ymd += "-";
		                    ymd += number.substr(6);
		                }
		                
		                el.value = ymd;
		                
			            } else {
			            	
			                alert("숫자 이외의 값은 입력하실 수 없습니다.");
			                
			                //숫자와 하이픈(-)기호 이외의 모든 값은 삭제한다.
			                el.value = el.value.replace(/[^0-9 ^\-]/g,"");
			                
			                return false;
	
			            } else {
				        	
				            return false;
				            
		            }
				
			}
			
			//주문내역 또는 취소 환불 버튼 클릭 펑션
			function select_mode(mode) {
				location.href = "order_list.do?mode=" + mode;
			}
			
			//주문처리 상태 클릭시 실행 펑션
			function select_option() {
				
				var mode = '<c:out value="${map.mode}"/>';
				var select = document.getElementById("select_status_order").value;
				var start_date = document.getElementById("start_date").value;
				var end_date = document.getElementById("end_date").value;
				var real_date = /^(19|20)\d{2}-(0[1-9]|1[012])-(0[1-9]|[12][0-9]|3[0-1])$/;
				
				if( !real_date.test(start_date) || !real_date.test(end_date) ) {
					alert("검색날짜를 올바르게 입력해주세요");
					return;
				}
				
				location.href = "order_list.do?o_deliver="+select+"&mode="+mode+"&start_date="+start_date+"&end_date="+end_date;
			}
			
			//날짜 개별 선택후 조회버튼 클릭 실행 펑션
			function search_date(date) {
				
				var mode = '<c:out value="${map.mode}"/>';
				var select = document.getElementById("select_status_order").value;
				var today = new Date();
				
				var dd = today.getDate();
				var mm = today.getMonth()+1;
				var yyyy = today.getFullYear();
				
				var end_date = yyyy+'-'+mm+'-'+dd;
				
				if( date == 1 ) {
					
				} else if( date == 7 ) {
					today.setDate(today.getDate()-7);
				} else if( date == 30 ) {
					today.setMonth(today.getMonth()-1);
				} else if( date == 3 ) {
					today.setMonth(today.getMonth()-3);
				} else if( date == 6 ) {
					today.setMonth(today.getMonth()-6);
				}
				
				var dd = today.getDate();
				var mm = today.getMonth()+1;
				var yyyy = today.getFullYear();
				
				var start_date = yyyy+'-'+mm+'-'+dd;
				
				location.href = "order_list.do?o_deliver="+select+"&mode="+mode+"&start_date="+start_date+"&end_date="+end_date;
			}
			
			//주문취소버튼 클릭시 실행 펑션 ajax
			function cancel_order(o_no) {
				if( !confirm("주문을 취소하시겠습니까?") ) {
					return;
				}
				var url = "cancel_order.do";
	            var param = "o_no="+o_no;
	            sendRequest(url, param, cancel_order_res,"POST");
			}
			
			function cancel_order_res() {
				if (xhr.readyState == 4 && xhr.status == 200) {
					var data = xhr.responseText;
					if (data == "fail") {
						alert("주문 취소에 실패하였습니다");
						return;
					} else if(data == "success") {
						alert("주문 취소가 완료되었습니다");
						location.href="order_list.do";
						return;
					} else if(data == "deliverying") {
						alert("상품이 배송중이므로 취소가 불가능합니다\n전화로 문의바랍니다");
						return;
					} else if(data == "done") {
						alert("이미 배송완료된 결제건 입니다");
						return;
					} else if(data == "cancel") {
						alert("이미 취소된 결제건입니다");
						return;
					} else if(data == "trade") {
						alert("교환처리되어 취소가 불가능합니다");
						return;
					} else if(data == "return") {
						alert("반품처리되어 취소가 불가능합니다");
						return;
					} else if(data == "accept") {
						alert("결제취소중 오류발생\n전화로 문의바랍니다");
						return;
					}
					
				}
			}
			
		</script>
		
	</head>
	<body>
		
		<div id="top_divbox">
			<p>주문조회</p>
		</div>
		
		<div id="top_navbox">
			<div id="navbox1">
				<p id="navbox1_p" onclick="select_mode('buy')">주문내역조회</p>
			</div>
			<div id="navbox2">
				<p id="navbox2_p" onclick="select_mode('cancel')">취소/반품/교환 내역</p>			
			</div>
		</div>
		
		<div id="datebox">
			<div id="select_status">
			<select id="select_status_order" onchange="select_option()">
				<!-- 옵션 추가해야함 -->
				<option value="99">전체 주문처리상태</option>
				<c:if test="${map.mode == 'buy'}">
				<option value="0"<c:if test="${map.o_deliver==0}">selected</c:if>>입금대기</option>
				<option value="1"<c:if test="${map.o_deliver==1}">selected</c:if>>배송준비중</option>
				<option value="2"<c:if test="${map.o_deliver==2}">selected</c:if>>배송중</option>
				<option value="3"<c:if test="${map.o_deliver==3}">selected</c:if>>배송완료</option>
				<option value="4"<c:if test="${map.o_deliver==4}">selected</c:if>>취소</option>
				<option value="5"<c:if test="${map.o_deliver==5}">selected</c:if>>교환</option>
				<option value="6"<c:if test="${map.o_deliver==6}">selected</c:if>>반품</option>
				</c:if>
			</select>
			</div>
			<div id="select_date">
				<p onclick="search_date('1')">오늘</p>
				<p onclick="search_date('7')">1주일</p>
				<p onclick="search_date('30')">1개월</p>
				<p onclick="search_date('3')">3개월</p>
				<p onclick="search_date('6')">6개월</p>
			</div>
			<input type="date" id="start_date" value="${map.start_date}" onkeyup="dateFormat(this)" maxlength="10">
			<p>-</p>
			<input type="date" id="end_date" value="${map.end_date}" onkeyup="dateFormat(this)" maxlength="10">
			<input type="button" id="date_button" onclick="select_option()" value="조회">
		</div>
		<div id="info_box1">
			<p>· 기본적으로 최근 3개월간의 자료가 조회되며, 기간 검색시 지난 주문내역을 조회하실 수 있습니다</p>
			<p>· 주문번호 또는 상품명을 클릭하시면 해당 주문에 대한 상세내역을 확인하실 수 있습니다</p>
		</div>
		
		<c:if test="${ empty list }">
			
			<div id="none_order">
				<p>주문내역이 없습니다.</p>
			</div>
			
		</c:if>
		
		<c:if test="${ !empty list }">
			
			<p id="content_top">주문 상품 정보</p>
			
			<table border="1" id="content_table">
				<tr>
					<th>
						<p>주문일자</p>
						<p>[주문번호]</p>	
					</th>
					<th>이미지</th>
					<th>상품정보</th>
					<th>수량</th>
					<th>상품구매금액</th>
					<th>주문처리상태</th>
					<th>취소/교환/반품</th>
				</tr>
				<!-- 아래 tr에 정보 넣고 for문 돌리기  -->
				<c:forEach var="o" items="${list}">
					<tr>
						<td id="${o.o_idx}" rowspan="1">
							<p>${o.o_date}</p>
							[<a href="#">${o.o_no}</a>]
							<c:if test="${o.o_deliver==0 || o.o_deliver==1}">
								<input type="button" id="cancel_order" onclick="cancel_order('${o.o_no}')" value="주문취소">
							</c:if>
						</td>
						<td>
							<img src="${pageContext.request.contextPath}/resources/p_img/${o.p_img}" alt="">
						</td>
						<td>
							<p>${o.p_name}</p>
						</td>
						<td>${o.amount}</td>
						<td><f:formatNumber value="${o.p_price * o.amount}" pattern="#,###" />원</td>
						<td>
							<p class="color_blue">
								<c:if test="${o.o_deliver eq 0}">입금대기</c:if>
								<c:if test="${o.o_deliver eq 1}">배송준비중</c:if>
								<c:if test="${o.o_deliver eq 2}">배송중</c:if>
								<c:if test="${o.o_deliver eq 3}">배송완료</c:if>
								<c:if test="${o.o_deliver eq 4}">결제취소</c:if>
								<c:if test="${o.o_deliver eq 5}">교환</c:if>
								<c:if test="${o.o_deliver eq 6}">반품</c:if>
							</p>
							<c:if test="${o.o_deliver eq 2}">
								<input type="button" value="배송조회">
							</c:if>
						</td>
						<td>
							<c:if test="${o.o_status ne 'cancel'}">-</c:if>
							<c:if test="${o.o_status eq 'cancel'}">취소</c:if>
							<c:if test="${o.o_status eq 'trade'}">교환</c:if>
							<c:if test="${o.o_status eq 'return'}">반품</c:if>
						</td>
					</tr>
				</c:forEach>
			</table>
			
			<table id="pagemenu">
				<tr height="30">
					<td align="center">${pageMenu}</td>
				</tr>
			</table>
			
		</c:if>
		
	</body>
	
	<%@ include file="/WEB-INF/views/main/footer.jsp"%>
	
</html>