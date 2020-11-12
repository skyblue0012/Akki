<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<% 
	if(session.getAttribute("user")!=null){
		response.sendRedirect("main.do");
	}
	response.setHeader("Expires", "Sat, 6 May 1995 12:00:00 GMT"); 
	response.setHeader("Cache-Control", "no-store, no-cache, must-revalidate");
	response.addHeader("Cache-Control", "post-check=0, pre-check=0"); 
	response.setHeader("Pragma", "no-cache");
%>

<!DOCTYPE html>
<html>
	<head>
	<%@ include file="/WEB-INF/views/main/index.jsp"%>
	<meta charset="UTF-8">
	<title>삼천리악기</title>
	
		<link href="${pageContext.request.contextPath}/resources/css/login/signup_page2.css" rel="stylesheet">
		<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/httpRequest.js"></script>
		<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
		<script type="text/javascript">
			
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
			
			function cancel() {
				if( confirm("회원가입을 취소할까요?"))
					location.href="main.do";
				else return;
			}
			
			var res = 0;
			var ch_id = "";
			
			function checking() {
				var id = document.getElementById("id").value;
	            var real_id = /^[A-za-z0-9]{3,15}$/g;
	            if(id == "admin"){
	            	alert("사용할 수 없는 아이디입니다.");
	              	f.user_id.focus();
	            	return;
	            }
	            if(!real_id.test(id)){
	            	alert("아이디는 영문과 숫자를 포함한 3~15자리 사용 가능합니다.");
	            	f.user_id.focus();
					return;
				}
				var url = "check_id.do";
				var param = "id=" + id;
				sendRequest(url, param, checked, "POST");
			
				function checked() {
					if (xhr.readyState == 4 && xhr.status == 200) {
						var data = xhr.responseText;
						if (data == "no") {
							alert("이미 존재하는 아이디입니다.");
							document.getElementById("id").value = "";
							document.getElementById("id").focus();
							return;
						} else {
							alert("사용가능한 아이디입니다.");
							ch_id = id;
							res = 1;
							return;
						}
					}
				}
			}
			
			function regi(f) {
				if (res == 0 || ch_id == "" || ch_id != f.user_id.value) {
					if (ch_id != f.user_id.value) {
						res = 0;
					}
					alert("아이디 중복체크를 해주세요");
					return;
				}
				if(f.user_phone3.value == ""){
					alert("휴대폰 번호를 입력해주세요");
					return;
				}
				var id = f.user_id.value;
				var pwd = f.user_pwd.value;
				var pwd2 = f.user_pwd2.value;
				var name = f.user_name.value;
				var birth = f.user_age.value;
				var email = f.user_email.value+"@"+f.user_email2.value;
				var tel = f.user_phone1.value + f.user_phone2.value + f.user_phone3.value;
				var addr_1 = f.user_address.value 
				var addr_2 = f.user_addressDetail.value;
				var real_id = /^[A-za-z0-9]{3,15}$/g;
				var real_email = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/;
				var real_pwd = /^[A-Za-z0-9]{6,12}$/;
				var real_tel = /^(?:(010-?\d{4})|(01[1|6|7|8|9]-?\d{3,4}))-?\d{4}$/;
				var real_name = /^[가-힣]+$|[a-zA-Z]{2,10}\s[a-zA-Z]{2,10}$/;
				
				if (!real_email.test(email)) {
					alert("이메일 형식이 올바르지 않습니다.");
					f.user_email2.focus();
					return;
				}
				if (!real_pwd.test(pwd)) {
					alert("비밀번호가 형식에 맞지 않습니다.");
					f.user_pwd.focus();
					return;
				}
				if (!real_id.test(id)) {
					alert("아이디는 영문과 숫자를 포함한 3~15자리 사용 가능합니다.");
					f.user_id.focus();
					return;
				}else if(id == "admin"){
					alert("사용할 수 없는 아이디입니다.");
					document.getElementById("id").value = "";
					document.getElementById("id").focus();
					return;
				}
				if (!real_name.test(name)) {
					alert("이름을 올바르게 입력해주세요");
					f.user_name.focus();
					return;
				}
				if (birth == "") {
					alert("생년월일을 입력해주세요");
					f.user_age.focus();
					return;
				}else{
					var date = new Date();
				    var year = date.getFullYear();
				    var month = (date.getMonth() + 1);
				    var day = date.getDate();       
				    if (month < 10) month = '0' + month;
				    if (day < 10) day = '0' + day;
				    var monthDay = month + day;
				    birth = birth.replace('-', '').replace('-', '');
				    var birthdayy = birth.substr(0, 4);
				    var birthdaymd = birth.substr(4, 4);
				    var age = monthDay < birthdaymd ? year - birthdayy - 1 : year - birthdayy;
				    if(age < 14){
				    	alert("만 14세 이하는 가입하실 수 없습니다");
				    	return;
				    }
				}
				if (pwd != pwd2) {
					alert("비밀번호가 같지않습니다.");
					f.user_pwd2.value = "";
					f.user_pwd2.focus();
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
				
				var url = "regi.do";
				var param = "id=" + id + "&pwd=" + pwd + "&name=" + name
						+ "&birth=" + birth + "&email=" + email + "&tel=" + tel
						+ "&addr_1=" + addr_1 + "&addr_2=" + addr_2;
				sendRequest(url, param, registFn, "POST");
	
				function registFn() {
					if (xhr.readyState == 4 && xhr.status == 200) {
						var data = xhr.responseText;
						if (data == "no") {
							alert("회원가입 실패");
							return;
						} else {
							alert("회원가입 성공\n로그인 하세요");
							location.href = "login_page.do";
							return;
						}
					}
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
			
			function birmoving(text) {
				var real_text = /^[0-9]+$/;
				if(document.getElementById('age').value.length == 4){
					if(text.value.substring(0,4) <= 1900 ){
						alert("올바른 년도를 입력해주세요");
						document.getElementById("age").value = "";
						return;
					}
					document.getElementById('age').value = document.getElementById('age').value + '-';
				}else if(document.getElementById('age').value.length == 7){
					if(text.value.substring(5,7) == 00 || text.value.substring(5,7) >= 13){
						alert("올바른 생년월일을 입력해주세요");
						document.getElementById("age").value = text.value.substr(0,5);
						return;
					}
					document.getElementById('age').value = document.getElementById('age').value + '-';
				}
				if(text.value.length >= 4){
					if (!real_text.test(text.value.substring(0,4))) {
						if (text.value == "") {
							return;
						}
						alert("숫자만 입력해주세요");
						document.getElementById("age").value = "";
						return;
					}
					if(text.value.length > 6){
						if(!real_text.test(text.value.substring(5,7))){
							
							alert("숫자만 입력해주세요");
							document.getElementById("age").value = text.value.substr(0,5);
							return;
						}
						if(text.value.length > 9){

							if(!real_text.test(text.value.substr(8,10))){
								alert("숫자만 입력해주세요");
								document.getElementById("age").value = text.value.substr(0,8);
								return;
							}
							var real_birth = /^(19[0-9][0-9]|20\d{2})-(0[0-9]|1[0-2])-(0[1-9]|[1-2][0-9]|3[0-1])$/;
							if(!real_birth.test(text.value)){
								if(text.value.substr(8,10) == 00 || text.value.substr(8,10) > 31){
									alert("올바른 생년월일을 입력해주세요");
									document.getElementById("age").value = text.value.substr(0,8);
									return;
								}else{
									alert("올바른 생년월일을 입력해주세요");
									document.getElementById("age").value = "";
								}
								return;
							}
							
						}
					}
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
		<div id="sub_nav">
			<ul>
				<li><a href="main.do">HOME</a></li>
				<li>></li>
				<li><a href="#" id="sign_up">SIGN UP</a></li>
			</ul>
		</div>
		
		<div id="content_top">
			<p>회원가입 정보입력</p>
		</div>
	
		<form name="fm" method="post">
			<div class="info">
				<span class="red">*</span> 필수입력사항 입니다
			</div>
	
			<table class="join_table">
				<!-- 아이디 -->
				<tr>
					<th><label for="id"><span class="red">*</span>아이디</label></th>
					<td>
						<input type="text" id="id" name="user_id">
						<input class="id_check" type="button" value="중복확인" onclick="checking();">
						<span class="id_info">아이디는 영문과 숫자만 가능합니다</span>
					</td>
				</tr>
				<!-- 비번 -->
				<tr>
					<th><label for="pwd"><span class="red">*</span>비밀번호</label></th>
					<td>
						<input type="password" id="pwd" name="user_pwd">
						<span class="pwd_info">최소 6자리에서 12자리를 입력해주세요</span>
					</td>
				</tr>
				<!-- 비번확인 -->
				<tr>
					<th><label for="pwd2"><span class="red">*</span>비밀번호 확인</label>
					</th>
					<td>
						<input type="password" id="pwd2" name="user_pwd2">
						<span class="pwd_info2">비밀번호를 다시 입력해주세요.</span>
					</td>
				</tr>
				<!-- 이름 -->
				<tr>
					<th><label for="name"><span class="red">*</span>이름</label></th>
					<td>
						<input type="text" id="name" name="user_name">
					</td>
				</tr>
				<!-- 생년월일 -->
				<tr>
					<th><label for="age"><span class="red">*</span>생년월일</label></th>
					<td>
						<input type="text" id="age" name="user_age" onkeyup="birmoving(this);" onkeydown="
						if(event.keyCode == 8){
							if(document.getElementById('age').value.length == 5){
								document.getElementById('age').value = document.getElementById('age').value.substr(0,4);
							}else if(document.getElementById('age').value.length == 8){
								document.getElementById('age').value = document.getElementById('age').value.substr(0,7);
							}else{
								return;
							}
						}
						" maxlength="10">
						&nbsp; ex)1988-08-16 &nbsp; "-"를 빼고입력
					</td>
				</tr>
				<!-- 이메일 -->
				<tr>
					<th><label for="email"><span class="red">*</span>이메일</label></th>
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
					<th><label for="phone"><span class="red">*</span>연락처</label></th>
					<td>
						<input type="tel" id="phone1" name="user_phone1" onkeyup="moving1(this);">
						<input type="tel" id="phone2" name="user_phone2" onkeyup="moving2(this);">
						<input type="tel" id="phone3" name="user_phone3" onkeyup="moving3(this);">
					</td>
				</tr>
				<!-- 주소 -->
				<tr>
					<th><label for="address"><span class="red">*</span>주소</label></th>
					<td>
						<div class="user_id1">
							<input type="text" id="address" name="user_address" readonly="readonly">
							<button type="button" id="orgBtn" onclick="getAddressInfo()">조회</button>
						</div>
						<div class="user_id2">
							<input type="text" id="d_address" name="user_addressDetail" placeholder="상세주소">
						</div>
					</td>
				</tr>
				
			</table>
	
			<div id="cotent_bottom">
				<input type="button" value="확인" onclick="regi(this.form);">
				<input type="button" value="취소" onclick="cancel();">
			</div>
		</form>
		
	</body>
	
	<%@ include file="/WEB-INF/views/main/footer.jsp"%>
	
</html>