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
	<%@ include file="/WEB-INF/views/main/index.jsp"%>
	<%@ include file="/WEB-INF/views/user/userPage_index.jsp"%>
	<meta charset="UTF-8">
	<title>삼천리악기</title>
		
		<link href="${pageContext.request.contextPath}/resources/css/user/userInfo_change.css" rel="stylesheet">
		
	    <script type="text/javascript">
	    	window.onload = function() {
				var mail = "<c:out value='${user.email}'/>".split('@');
				document.getElementById("phone1").value = "<c:out value='${user.tel}'/>".substr(0,3);
				document.getElementById("phone2").value = "<c:out value='${user.tel}'/>".substr(3,4);
				document.getElementById("phone3").value = "<c:out value='${user.tel}'/>".substr(7,4);
				document.getElementById("age").value = "<c:out value='${user.birth}'/>".substr(0,4)+"-"+"<c:out value='${user.birth}'/>".substr(4,2)+"-"+"<c:out value='${user.birth}'/>".substr(6,2);
				document.getElementById("email").value = mail[0];
				document.getElementById("email2").value = mail[1];
				if( mail[1] == "naver.com" || mail[1] == "google.com" || mail[1] == "daum.com" || mail[1] == "nate.com"  ){
					document.getElementById('email3').value = mail[1];
					document.getElementById('email2').readOnly=true;
				}else{
					document.getElementById('email3').value = '1';
				}
			}
	    	
	    	function modify_user(f) {
	    		var email = f.user_email.value+"@"+f.user_email2.value;
	    		var tel = f.user_phone1.value + f.user_phone2.value + f.user_phone3.value;
	    		var addr_1 = f.user_address.value 
				var addr_2 = f.user_addressDetail.value;
	    		var real_email = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/;
	    		if (!real_email.test(email)) {
					alert("이메일 형식이 올바르지 않습니다.");
					f.user_email2.focus();
					return;
				}
				if (addr_1 == ""){
					alert("조회 버튼을 눌러 주소를 입력하세요");
					return;
				}
				if (f.user_addressDetail.value == ""){
					alert("상세주소를 입력해주세요");
					f.user_addressDetail.focus();
					return;
				}
				
				var url = "modify_user.do";
				var param = "id=" + "<c:out value='${user.id}'/>" + "&email=" + email + "&tel=" + tel
						+ "&addr_1=" + addr_1 + "&addr_2=" + addr_2;
				sendRequest(url, param, modifyFn, "POST");
	
				function modifyFn() {
					if (xhr.readyState == 4 && xhr.status == 200) {
						var data = xhr.responseText;
						if (data == "no") {
							alert("정보수정 실패");
							return;
						} else {
							alert("회원정보가 수정되었습니다.");
							location.href = "main.do";
							return;
						}
					}
				}
			}
	    	
			function getAddressInfo(){
				new daum.Postcode({
					oncomplete: function(data) {
						document.getElementById('address').value = data.roadAddress;
					},
					shorthand : false
				}).open();
			}
	    	
	    	function email_com() {
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
	    	
	    	function moving1(text) {
				if (text.value.length >= 3) {
					if (text.value.length > 3) {
						document.getElementById("phone1").value = text.value.substr(0,3);
					}
					var real_text = /^01(?:0|1|[6-9])/;
					if (!real_text.test(text.value)) {
						alert("올바른 형태가 아닙니다.");
						document.getElementById("phone1").value = "";
						document.getElementById("phone1").focus();
						return;
					} else {
						document.getElementById("phone2").focus();
					}
				}
				var real_text = /^[0-9]+$/;
				if (!real_text.test(text.value)) {
					if (text.value == "") {
						return;
					}
					alert("숫자만 입력해주세요");
					document.getElementById("phone1").value = "";
					document.getElementById("phone1").focus();
				}
			}
			
			function moving2(text) {
				if(document.getElementById("phone1").value == ""){
					document.getElementById("phone2").value = text.value.substr(0, 4);
					document.getElementById("phone1").focus();
					return;
				}
				if (text.value.length >= 4) {
					if (text.value.length > 4) {
						document.getElementById("phone2").value = text.value.substr(0, 4);
					}
					var real_text = /^([0-9]{3,4})/;
					if (!real_text.test(text.value)) {
						alert("올바른 형태가 아닙니다.");
						document.getElementById("phone2").value = "";
						document.getElementById("phone2").focus();
						return;
					} else {
						document.getElementById("phone3").focus();
					}
				}
				var real_text = /^[0-9]+$/;
				if (!real_text.test(text.value)) {
					if (text.value == "") {
						return;
					}
					alert("숫자만 입력해주세요");
					document.getElementById("phone2").value = "";
					document.getElementById("phone2").focus();
				}
			}
			
			function moving3(text) {
				if(document.getElementById("phone1").value == "" || document.getElementById("phone2").value == ""){
					if(document.getElementById("phone1").value == ""){
						document.getElementById("phone3").value = text.value.substr(0, 4);
						document.getElementById("phone1").focus();
					}else{
						document.getElementById("phone3").value = text.value.substr(0, 4);
						document.getElementById("phone2").focus();
					}
					
					return;
				}
				if (text.value.length > 4) {
					document.getElementById("phone3").value = text.value.substr(0,4);
				}
				var real_text = /^[0-9]+$/;
				if (!real_text.test(text.value)) {
					if (text.value == "") {
						return;
					}
					alert("숫자만 입력해주세요");
					document.getElementById("phone3").value = "";
					document.getElementById("phone3").focus();
				}
			}
			
			function onair_ck() {
				var email = document.getElementById("email").value ;
				var ck_email = /([\w-\.]+)$/;
				if(!ck_email.test(email) && email !=""){
					alert("올바른 형태의 이메일이 아닙니다");
					document.getElementById("email").value = "";
					document.getElementById("email").focus();
					return;
				}
			}
			
	    </script>
	</head>
	<body>
		<div id="change_box">
		<div id="content_top">
			<p>회원정보 수정</p>
		</div>
	
		<form name="fm" method="post">
		
			<table class="join_table">
				<!-- 아이디 -->
				<tr>
					<th><label for="id">아이디</label></th>
					<td>
						<input type="text" id="id" name="user_id" value="${user.id}" readonly="readonly">
					</td>
				</tr>
				<!-- 이름 -->
				<tr>
					<th><label for="name">이름</label></th>
					<td>
						<input type="text" id="name" name="user_name" value="${user.name}" readonly="readonly">
					</td>
				</tr>
				<!-- 생년월일 -->
				<tr>
					<th><label for="age">생년월일</label></th>
					<td>
						<input type="text" id="age" name="user_age" readonly="readonly">
					</td>
				</tr>
				<!-- 이메일 -->
				<tr>
					<th><label for="email">이메일</label></th>
					<td>
						<input type="text" id="email" name="user_email" onblur="onair_ck();">@
						<input type="text" id="email2" name="user_email2">
						<select id="email3" onchange="email_com()">
							<option value="1">직접입력</option>
							<option value="naver.com">네이버</option>
							<option value="google.com">구글</option>
							<option value="daum.net">다음</option>
							<option value="nate.com">네이트</option>
						</select>
					</td>
				</tr>
				<!-- 연락처 -->
				<tr>
					<th><label for="phone">연락처</label></th>
					<td>
						<input type="tel" id="phone1" name="user_phone1" onkeyup="moving1(this);">
						<input type="tel" id="phone2" name="user_phone2" onkeyup="moving2(this);">
						<input type="tel" id="phone3" name="user_phone3" onkeyup="moving3(this);">
					</td>
				</tr>
				<!-- 주소 -->
				<tr>
					<th><label for="address">주소</label></th>
					<td>
						<div class="user_id1">
							<input type="text" id="address" name="user_address" readonly="readonly" value="${ user.addr_1 }">
							<button type="button" id="orgBtn" onclick="getAddressInfo()">조회</button>
						</div>
						<div class="user_id2">
							<input type="text" id="d_address" name="user_addressDetail" placeholder="상세주소" value="${ user.addr_2 }">
						</div>
					</td>
				</tr>
				
			</table>
			
			<div id="cotent_bottom">
				<input type="button" value="확인" onclick="modify_user(this.form);">
				<input type="button" value="취소" onclick="location.href='main.do'">
			</div>
			
		</form>
		
		</div>
	</body>
	
	<%@ include file="/WEB-INF/views/main/footer.jsp"%>

</html>