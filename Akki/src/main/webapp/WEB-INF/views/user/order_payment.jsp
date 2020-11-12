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
	
		<link href="${pageContext.request.contextPath}/resources/css/user/order_payment.css" rel="stylesheet">
		<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
		
		<!-- jQuery -->
		<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
		<!-- iamport.payment.js -->
		<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
		
		<script type="text/javascript">
			
			var IMP = window.IMP; // 생략해도 괜찮습니다.
			IMP.init("imp43709676"); // "imp00000000" 대신 발급받은 "가맹점 식별코드"를 사용합니다.
			
			function order_pay() {
				
				var agree = document.getElementById('pay_agree');
				
				if( !agree.checked ) {
					alert("구매동의에 체크하셔야 합니다");
					return;
				}

				var real_email = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/;
				var real_tel = /^(?:(010-?\d{4})|(01[1|6|7|8|9]-?\d{3,4}))-?\d{4}$/;
				var real_name = /^[가-힣]+$|[a-zA-Z]{2,10}\s[a-zA-Z]{2,10}$/;
				var real_home = /^(0(2|3[1-3]|4[1-4]|5[1-5]|6[1-4]))-(\d{3,4})-(\d{4})$/;
				
				//주문자 정보
				var name = document.getElementById("name_1").value;
				var addr1_1 = document.getElementById("address_1").value;
				var addr1_2 = document.getElementById("d_address_1").value;
				var tel = document.getElementById("tel1_1").value +"-"+document.getElementById("tel1_2").value+"-"+document.getElementById("tel1_3").value;
				var email1 = document.getElementById("email").value+"@"+document.getElementById("email2").value;
				
				//배송지 정보
				var name2 = document.getElementById("name_2").value;
				var addr2_1 = document.getElementById("address_2").value;
				var addr2_2 = document.getElementById("d_address_2").value;
				var home = document.getElementById("home_t1").value+"-"+document.getElementById("home_t2").value+"-"+document.getElementById("home_t3").value;
				var tel2  = document.getElementById("tel2_1").value+"-"+document.getElementById("tel2_2").value +"-"+document.getElementById("tel2_3").value;
				var dm = document.getElementById("dm").value;
				
				if(name == ""){
					alert("이름을 입력해주세요");
					document.getElementById("name_1").focus();
					return;
				}else if(name2 == ""){
					alert("이름을 입력해주세요");
					document.getElementById("name_2").focus();
					return;
				}else if(!real_name.test(name)){
					alert("이름을 바르게 입력해주세요");
					document.getElementById("name_1").value = "";
					document.getElementById("name_1").focus();
					return;
				}else if(!real_name.test(name2)){
					alert("이름을 바르게 입력해주세요");
					document.getElementById("name_2").value = "";
					document.getElementById("name_2").focus();
					return;
				}
				
				if(addr1_1 == ""){
					alert("주소를 입력해주세요");
					document.getElementById("address_1").focus();
					return;
				}else if(addr1_2 == ""){
					alert("상세주소를 입력해주세요");
					document.getElementById("d_address_1").focus();
					return;			
				}else if(addr2_1 == ""){
					alert("주소를 입력해주세요");
					document.getElementById("address_2").focus();
					return;
				}else if(addr2_2 == ""){
					alert("상세주소를 입력해주세요");
					document.getElementById("d_address_2").focus();
					return;
				}
				
				if(document.getElementById("home_t1").value != "선택"){
					if(!real_home.test(home)){
						alert("일반전화를 바르게 입력해주세요");
						document.getElementById("home_t2").focus();
						return;
					}
				}else {
					home = "없음";
				}
				
				if(document.getElementById("tel1_2").value == ""){
					alert("휴대폰 번호를 입력해주세요");
					document.getElementById("tel1_2").focus();
					return;
				}else if(document.getElementById("tel1_3").value == ""){
					alert("휴대폰 번호를 입력해주세요");
					document.getElementById("tel1_3").focus();
					return;
				}else if(document.getElementById("tel2_2").value == ""){
					alert("휴대폰 번호를 입력해주세요");
					document.getElementById("tel2_2").focus();
					return;
				}else if(document.getElementById("tel2_3").value == ""){
					alert("휴대폰 번호를 입력해주세요");
					document.getElementById("tel2_3").focus();
					return;
				}
				
				if(!real_tel.test(tel)){
					alert("휴대폰 번호를 바르게 입력해주세요");
					document.getElementById("tel1_2").focus();
					return;
				}else if(!real_tel.test(tel2)){
					alert("휴대폰 번호를 바르게 입력해주세요");
					document.getElementById("tel2_2").focus();
					return;
				}
				
				
				if(!real_email.test(email1)){
					alert("이메일을 바르게 입력해주세요");
					document.getElementById("email").focus();
					return;
				}
				
				if(dm.length > 50){
					alert("글자수는 50자로 제한됩니다(공백포함)");
					document.getElementById("dm").value = text.value.substring(0,50);
					document.getElementById("dm").focus();
				}
				dm = document.getElementById("dm").value.replace("\n"," ");
				dm = dm.replace(/ +/g, " ");
				
				var pay_select = document.querySelector('input[name="pay_select"]:checked').value;
				
				var no = new Date().getTime();
				
				var total_price = ${total_price};
				
				if( total_price < 50000 ) {
					total_price = total_price + 2500;
				}
				
				var addr1 = addr1_1 + " " + addr1_2;
				var addr2 = addr2_1 + " " + addr2_2;
				var p_idx_check = document.getElementsByName("p_idx");
				var p_amount_check = document.getElementsByName("p_amount");
				
				var p_idx = new Array();
				var p_amount = new Array();
				
				for(var i = 0; i < p_idx_check.length; i++) {
					p_idx[i] = p_idx_check[i].value;
					p_amount[i] = p_amount_check[i].value;
	            }

				//무통장 입금시
				if( pay_select == 'bank' ) {
					
					var name = document.getElementById("bank_name").value;
					var account = document.getElementById("bank_info").value;
					var o_pay = "bank";
					
					if( name == "" ) {
						alert("입금자명을 입력하세요");
						name.value = "";
						name.focus();
						return;
					}
					if( !real_name.test( name ) ) {
						alert("올바른 입금자명을 입력하세요");
						name.value = "";
						name.focus();
						return;
					}
					if( account == null || account == ':::선택해주세요:::' ) {
						alert("입금하실 계좌를 선택해주세요");
						return;
					}
					
					var url = "complete_bank.do";
					var param = "o_pay="+o_pay+"&o_price="+total_price+"&p_idx="+p_idx+
					"&p_amount="+p_amount+"&o_no="+no+"&d_name="+name2+"&d_tel="+tel2+
					"&d_telhome="+home+"&d_addr="+addr2+"&d_dm="+dm+"&b_name="+name+"&b_account="+account;
			        
					sendRequest(url, param, complete_bank_res, "POST");
				}
				
				function complete_bank_res() {
					if (xhr.readyState == 4 && xhr.status == 200) {
		               var data = xhr.responseText;
		               if (data == "error") {
		                  alert("결제에 실패하였습니다");
		                  return;
		               } else if(data == "hack") {
		            	   alert("결제된 금액이 요청한 금액과 달라 결제를 자동취소처리하였습니다");
		            	   return;
		               } else if(data == "success") {
		                  location.href = "order_success.do?no=" + no;
		                  return;
		               }
		            }
				}
				
				if( pay_select != 'bank' ) {
				
					// IMP.request_pay(param, callback) 호출
					IMP.request_pay({ // param
						pg: "kcp",
						pay_method: pay_select,
						merchant_uid: no,
						name: "${p_name}",
						amount: total_price,
						buyer_email: email1,
						buyer_name: name,
						buyer_tel: tel,
						buyer_addr: addr1
						}, function (rsp) { // callback
					    if (rsp.success) { // 결제 성공 시: 결제 승인 또는 가상계좌 발급에 성공한 경우
					        // jQuery로 HTTP 요청
					        jQuery.ajax({
					            url: "complete.do", // 가맹점 서버
					            method: "POST",
					            traditional: true,
					            data: {
					                imp_uid: rsp.imp_uid,
					                total_price: total_price,
					                o_pg: rsp.pg_provider,
					                o_pay: rsp.pay_method,
					                o_status: rsp.status,
					                o_price: rsp.paid_amount,
					                date_unix: rsp.paid_at,
					                p_idx: p_idx,
					                p_amount: p_amount,
					                o_no: no,
					                d_name: name2,
					                d_tel: tel2,
					                d_telhome: home,
					                d_addr: addr2,
					                d_dm: dm
					            }
					        }).done(function (data, status) {
					        	// 가맹점 서버 결제 API 성공시 로직
					        	
					        	if ( data == "success" ) {
					        		
					    			location.href = "order_success.do?no=" + rsp.merchant_uid;
					    			
					    		} else {
					    			switch (data) {
					    			case "hack":
					    				alert("결제된 금액이 요청한 금액과 달라 결제를 자동취소처리하였습니다");
					    				break;
					    			case "error":
					    				alert("오류로 인하여 결제를 취소처리 하였습니다.");
					    				break;
									case "401":
										alert("Unauthorized");
										break;
									case "404":
										alert("해당되는 거래내역이 존재하지 않음");
										break;
									case "500":
										alert("서버 응답 오류");
										break;
									}
					    		}
					        	
					        })
				        } else {
				        	alert("결제에 실패하였습니다\n에러 내용: " +  rsp.error_msg);
			        	}
					});
					
				}
				
			}
			
		</script>
		
		<script type="text/javascript">
			function getAddressInfo(n){
				if(n == 1){
					new daum.Postcode({
						oncomplete: function(data) {
							document.getElementById('address_1').value = data.roadAddress;
						},
						shorthand : false
					}).open();
					document.getElementById("d_address_1").focus();
				}else{
					new daum.Postcode({
						oncomplete: function(data) {
							document.getElementById('address_2').value = data.roadAddress;
						},
						shorthand : false
					}).open();
					document.getElementById("d_address_2").focus();
				}
			}
			
			function email_select() {
				var email_com = document.getElementById('email3').value;
				if(email_com == "1"){
					document.getElementById('email2').readOnly=false;
					document.getElementById('email2').value = "";
					document.getElementById('email2').focus();
	            }else{
	            	document.getElementById('email2').value = email_com;
	            	document.getElementById('email2').readOnly=true;
	            }
			}
			
			function h_tel() {
				if(document.getElementById("home_t1").value == "선택"){
					document.getElementById("home_t2").value = "";
					document.getElementById("home_t3").value = "";
					document.getElementById("home_t2").readOnly=true;
					document.getElementById("home_t3").readOnly=true;
					document.getElementById("tel2_1").focus();
				}else{
					document.getElementById("home_t2").value = "";
					document.getElementById("home_t3").value = "";
					document.getElementById("home_t2").readOnly=false;
					document.getElementById("home_t3").readOnly=false;
				}
			}
			
			function switch_card() {
				document.getElementById('payment_content1').style.display = "none";
				document.getElementById('payment_content2').style.display = "none";
				document.getElementById('payment_content3').style.display = "block";
			}
			
			function switch_bank() {
				document.getElementById('payment_content3').style.display = "none";
				document.getElementById('payment_content2').style.display = "none";
				document.getElementById('payment_content1').style.display = "block";
			}
			
			function switch_trans() {
				document.getElementById('payment_content3').style.display = "none";
				document.getElementById('payment_content1').style.display = "none";
				document.getElementById('payment_content2').style.display = "block";
			}
			
		</script>
	
	</head>
	<body>
		<!-- 상품 출력 -->
		<div id="cart_box">
			<h2>상품구매</h2>
			<img class="top_navimg" src="${pageContext.request.contextPath}/resources/img/order_step2.gif" alt="">
			<table border="1">
				<tr>
					<th>이미지</th>
					<th>상품정보</th>
					<th>판매가</th>
					<th>수량</th>
					<th>배송구분</th>
					<th>배송비</th>
					<th>합계</th>
				</tr>
				<!-- for문 시작 -->
				<c:if test="${ !empty list }">
					<c:forEach var="o" items="${list}">
						<tr>
							<td>
								<img src="${pageContext.request.contextPath}/resources/p_img/${o.p_img}" alt="" class="order_img" />
							</td>
							<td>${o.p_name}</td>
							<td><f:formatNumber value="${o.p_price}" pattern="#,###" />원
							</td>
							<td><f:formatNumber value="${o.amount}" pattern="#,###" />개
							</td>
							<td>일반배송</td>
							<td>
								<c:if test="${50000 lt o.p_price}">무료배송</c:if>
								<c:if test="${50000 gt o.p_price}">2,500 원</c:if>
							</td>
							<td>
								<f:formatNumber value="${o.p_price * o.amount}" pattern="#,###" />원
							</td>
						</tr>
						<input type="hidden" name="p_idx" value="${o.p_idx}">
						<input type="hidden" name="p_amount" value="${o.amount}">
					</c:forEach>
				</c:if>
				<c:if test="${ empty list }">
					<tr>
						<td>
							<img src="${pageContext.request.contextPath}/resources/p_img/${product.p_img}" alt="" class="order_img" />
						</td>
						<td>${product.p_name}</td>
						<td>
							<f:formatNumber value="${product.p_price}" pattern="#,###" />원
						</td>
						<td>
							<f:formatNumber value="${amount}" pattern="#,###" />개
						</td>
						<td>일반배송</td>
						<td>
							<c:if test="${50000 lt total_price}">무료배송</c:if>
							<c:if test="${50000 gt total_price}">2,500 원</c:if>
						</td>
						<td>
							<f:formatNumber value="${product.p_price * amount}" pattern="#,###" />원
						</td>
					</tr>
					<input type="hidden" name="p_idx" value="${product.p_idx}">
					<input type="hidden" name="p_amount" value="${amount}">
				</c:if>
				<!-- for문 끝 -->
				<tr class="sumprice_info">
					<td colspan="7">
						<p>
							상품구매금액
							<strong>
								<f:formatNumber value="${total_price}" pattern="#,###" />
							</strong> + 배송비
							<c:if test="${50000 lt total_price}">+0 원 (무료)</c:if>
							<c:if test="${50000 gt total_price}">+2,500 원</c:if>
							= 합계 :
						</p>
						<p>
							<c:if test="${50000 lt total_price}">
								<f:formatNumber value="${total_price}" pattern="#,###" />원
	                     	</c:if>
							<c:if test="${50000 gt total_price}">
								<f:formatNumber value="${total_price + 2500}" pattern="#,###" />원
	                     	</c:if>
						</p>
					</td>
				</tr>
			</table>
	
		</div>
	
		<!-- 주문자 정보 -->
		<div id="customer_info">
			<p>주문자 정보</p>
			<table border="1">
				<tr>
					<th>주문자</th>
					<td><input id="name_1" type="text" value="${user.name}" ></td>
				</tr>
				<tr>
					<th>주소</th>
					<td>
						<div class="user_id1">
							<input type="text" id="address_1" name="user_address" readonly="readonly" value="${ user.addr_1 }" onclick="getAddressInfo(1)">
							<button type="button" id="orgBtn" onclick="getAddressInfo(1)">조회</button>
						</div>
						<div class="user_id2">
							<input type="text" id="d_address_1" name="user_addressDetail" placeholder="상세주소" value="${ user.addr_2 }">
						</div>
					</td>
				</tr>
				<tr>
					<th>휴대전화</th>
					<td>
						<select id="tel1_1">
							<option>010</option>
							<option>011</option>
							<option>016</option>
							<option>017</option>
							<option>018</option>
							<option>019</option>
						</select> - <input id="tel1_2" type="tel" maxlength="4"> - <input id="tel1_3" type="tel" maxlength="4">
					</td>
				</tr>
				<tr>
					<th><label for="email"><!-- <span class="red">*</span> -->이메일</label></th>
					<td>
						<input type="text" id="email" name="user_email" value="">@
						<input type="text" id="email2" name="user_email2" value="">
						<select id="email3" onchange="email_select()">
							<option value="1">직접입력</option>
							<option value="naver.com">네이버</option>
							<option value="google.com">구글</option>
							<option value="daum.net">다음</option>
							<option value="nate.com">네이트</option>
						</select>
					</td>
				</tr>
			</table>
		</div>
	
		<!-- 배송 정보 -->
		<div id="send_info">
			<p>배송 정보</p>
			<table border="1">
				<tr>
					<th>받으시는분</th>
					<td><input id="name_2" type="text" value=""></td>
				</tr>
				<tr>
					<th>주소</th>
					<td>
						<div class="user_id1">
							<input type="text" id="address_2" name="user_address" readonly="readonly" onclick="getAddressInfo(2)">
							<button type="button" id="orgBtn" onclick="getAddressInfo(2)">조회</button>
						</div>
						<div class="user_id2">
							<input type="text" id="d_address_2" name="user_addressDetail" placeholder="상세주소">
						</div>
					</td>
				</tr>
				<tr>
					<th>일반전화</th>
					<td>
						<select id="home_t1" onchange="h_tel();">
							<option>선택</option>
							<option>02</option>
							<option>031</option>
							<option>032</option>
							<option>033</option>
							<option>041</option>
							<option>042</option>
							<option>043</option>
							<option>044</option>
							<option>051</option>
							<option>052</option>
							<option>053</option>
							<option>054</option>
							<option>055</option>
							<option>061</option>
							<option>062</option>
							<option>063</option>
							<option>064</option>
						</select> - <input id="home_t2" type="text" maxlength="4"> - <input id="home_t3" type="text" maxlength="4">
					</td>
				</tr>
				<tr>
					<th>휴대전화</th>
					<td>
						<select id="tel2_1">
							<option>010</option>
							<option>011</option>
							<option>016</option>
							<option>017</option>
							<option>018</option>
							<option>019</option>
						</select> - <input id="tel2_2" type="tel" maxlength="4"> - <input id="tel2_3" type="tel" maxlength="4">
					</td>
				</tr>
				<tr>
					<th>배송메세지</th>
					<td><textarea id="dm" placeholder="배송메세지를 입력하세요 (최대 50글자)" rows="" cols=""></textarea>
				</tr>
			</table>
		</div>
		
		<!-- 결제 예정금액 -->
		<div id="price_box">
			<div id="price_menu">
				<p>총 상품금액</p>
				<p>총 배송비</p>
				<p>결제예정금액</p>
			</div>
			<div id="price_value">
				<p>
					<f:formatNumber value="${total_price}" pattern="#,###" />원
				</p>
				<p>
					<c:if test="${50000 lt total_price}">+0 원</c:if>
					<c:if test="${50000 gt total_price}">+2,500 원</c:if>
				</p>
				<p>
					<c:if test="${50000 lt total_price}">
	                	=<f:formatNumber value="${total_price}" pattern="#,###" />원
	                </c:if>
					<c:if test="${50000 gt total_price}">
						=<f:formatNumber value="${total_price + 2500}" pattern="#,###" />원
					</c:if>
				</p>
			</div>
		</div>
		<div id="discount">
			<table>
				<tr>
					<th>총 할인금액</th>
					<td>0원</td>
				</tr>
				<tr>
					<th>총 부가결제금액</th>
					<td>0원</td>
				</tr>
			</table>
		</div>
		
		<!-- 결제 수단 -->
		<div id="select_payment">
			<div id="select_box">
				<input type="radio" name="pay_select" value="card" checked="checked" onclick="switch_card()">카드 결제
				<input type="radio" name="pay_select" value="bank" onclick="switch_bank()">무통장 입금
	            <input type="radio" name="pay_select" value="trans" onclick="switch_trans()">실시간 계좌이체
			</div>
			
			<div id="payment_content1">
				<table>
					<tr>
						<th>입금자명</th>
						<td><input type="text" id="bank_name"></td>
					</tr>
					<tr>
						<th>입금은행</th>
						<td>
							<select id="bank_info">
								<option>:::선택해주세요:::</option>
								<option>SC제일은행 : 128-20-114196 예금주 이종영</option>
							</select>
						</td>
					</tr>
				</table>
			</div>
			
			<div id="payment_content2">
				
			</div>
			
			<div id="payment_content3">
				<p>소액 결제의 경우 PG사 정책에 따라 결제 금액 제한이 있을 수 있습니다.</p>
			</div>
			
			<div id="pay_info">
				<!-- 라디오 버튼 바뀔 때마다 id검색해서 value값 변경해야함 -->
				<input id="way" value="무통장 입금 최종결제 금액" readonly="readonly">
				<p>
					<c:if test="${50000 lt total_price}">
	                	<f:formatNumber value="${total_price}" pattern="#,###" />원
	                </c:if>
					<c:if test="${50000 gt total_price}">
						<f:formatNumber value="${total_price + 2500}" pattern="#,###" />원
					</c:if>
				</p>
				<input id="pay_agree" type="checkbox">
				<p>결제정보를 확인하였으며, 구매진행에 동의합니다.</p>
				<input type="button" value="결제하기" onclick="order_pay()">
			</div>
		</div>
	
		<!-- 이용 안내 -->
		<div></div>
	
	</body>
		<script type="text/javascript">
			window.onload= function() {
				var email = "<c:out value='${user.email}'/>";
				var n = parseInt(email.indexOf("@"));
				var email_1 = email.substring(0,n);
				var email_2 = email.substring(n+1);
				document.getElementById("email").value = email_1;
				document.getElementById("email2").value = email_2;
				if( email_2 == "naver.com" || email_2 == "google.com" || email_2 == "daum.com" || email_2 == "nate.com"  ){
					document.getElementById('email3').value = email_2;
					document.getElementById('email2').readOnly=true;
				}else{
					document.getElementById('email3').value = '1';
				}
				var tel = "<c:out value='${user.tel}'/>";
				var tel1 = tel.substring(0,3);
				var tel2 = tel.substring(3,7);
				var tel3 = tel.substring(7,11);
				document.getElementById("tel1_1").selected = tel1;
				document.getElementById("tel1_2").value = tel2;
				document.getElementById("tel1_3").value = tel3;
			}
		</script>
	<%@ include file="/WEB-INF/views/main/footer.jsp"%>

</html>