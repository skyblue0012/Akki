<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
	<%@ include file="/WEB-INF/views/main/index.jsp"%>
	<meta charset="UTF-8">
	<title>삼천리악기</title>
		
		<link href="${pageContext.request.contextPath}/resources/css/login/find_pwd.css" rel="stylesheet">
		<script type="text/javascript">
			function switch_email() {
				document.getElementById('check_email').style.display = "block";
				document.getElementById('check_phone').style.display = "none";
				document.getElementById("now").value="1";
				var phone = document.getElementsByName('number');
				for( var i = 0; i < phone.length; i++ ) {
					phone[i].value = "";
				}
			}
			
			function switch_phone() {
				document.getElementById('email').value = "";
				document.getElementById('check_email').style.display = "none";
				document.getElementById('check_phone').style.display = "block";
				document.getElementById("now").value="2";
			}
			
			function checking_info(f) {
				if(f.id.value == ""){
					alert("아이디를 입력해주세요");
					document.getElementById("name").focus();
					return;
				}else if(f.name.value == ""){
					alert("이름을 입력해주세요");
					document.getElementById("name").focus();
					return;
				}
				
				if(document.getElementById("now").value == "1"){
					if(f.email.value==""){
						alert("이메일을 입력해주세요");
						document.getElementById("email").focus();
						return;
					}
					var url = "checking_pwd.do";
					var param = "id=" + f.id.value +"&name=" + f.name.value + "&email=" + f.email.value + "&tel=" + "no";
					sendRequest(url, param, check_pwd_m, "POST");
					
					function check_pwd_m() {
						if (xhr.readyState == 4 && xhr.status == 200) {
							var data = xhr.responseText;
							if (data == "no") {
								alert("가입된 정보가 없습니다.");
								document.getElementById("id").value="";
								document.getElementById("email").value="";
								document.getElementById("name").value="";
								document.getElementById("id").focus();
								return;
							} else {
								document.getElementById('cotent_box').style.display = "none";
								document.getElementById('result_box').style.display = "block";
								document.getElementById('res_pwd').value = data;
							}
						}
					}
				}else{
					if(document.getElementById("phone1").value==""||document.getElementById("phone2").value==""||document.getElementById("phone3").value==""){
						alert("휴대폰번호를 입력해주세요");
						if(document.getElementById("phone1").value == "")
								document.getElementById("phone1").focus();
						else if(document.getElementById("phone2").value == "")
							document.getElementById("phone2").focus();
						else 
							document.getElementById("phone3").focus();
						return;
					}else{
						
						var tel = f.phone1.value + f.phone2.value + f.phone3.value;
						var url = "checking_pwd.do";
						var param = "id=" + f.id.value +"&name=" + f.name.value + "&email=" + "no" + "&tel=" + tel;
						
						sendRequest(url, param, check_pwd_t, "POST");

						function check_pwd_t() {
							if (xhr.readyState == 4 && xhr.status == 200) {
								var data = xhr.responseText;
								if (data == "no") {
									alert("가입된 정보가 없습니다.");
									document.getElementById("id").value="";
									document.getElementById("name").value="";
									document.getElementById("phone1").value="";
									document.getElementById("phone2").value="";
									document.getElementById("phone3").value="";
									document.getElementById("id").focus();
									return;
								} else {
									document.getElementById('cotent_box').style.display = "none";
									document.getElementById('result_box').style.display = "block";
									document.getElementById('res_pwd').value = data;
								}
							}
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
			
			
		</script>
		
	</head>
	<body>
		
		<div id="cotent_box">
			<form method="post">
				<p id="find_pwd">비밀번호 찾기</p>
				<p id="check_what">
					<input type="radio" name="check_what" checked="checked" onclick="switch_email()">
					<label>이메일</label>
					<input type="radio" name="check_what" onclick="switch_phone()">
					<label>휴대폰번호</label>
				</p>
				<p id="check_id">
					<strong>아이디</strong>
					<input type="text" id="id" onkeypress="if(event.keyCode == 13)checking_info(this.form);"
					value="<c:if test="${id ne null}">${id}</c:if>">
				</p>
				
				<p id="check_name">
					<strong>이름</strong>
					<input type="text" id="name" onkeypress="if(event.keyCode == 13)checking_info(this.form);">
				</p>
				<p id="check_email">
					<strong>이메일</strong>
					<input type="text" id="email" onkeypress="if(event.keyCode == 13)checking_info(this.form);">
				</p>
				<p id="check_phone">
					<strong>휴대폰번호</strong>
					<input type="text" class="check_phone_number" name="number" onkeyup="moving1(this);" onkeypress="if(event.keyCode == 13)checking_info(this.form);" id="phone1"> - 
					<input type="text" class="check_phone_number" name="number" onkeyup="moving2(this);" onkeypress="if(event.keyCode == 13)checking_info(this.form);" id="phone2"> - 
					<input type="text" class="check_phone_number" name="number" onkeyup="moving3(this);" onkeypress="if(event.keyCode == 13)checking_info(this.form);" id="phone3">
				</p>
				<input type="button" value="확인" id="submit" onclick="checking_info(this.form);">
				<input type="hidden" value="1" name="clause" id="now">
			</form>
		</div>
		
		<div id="result_box">
			<p id="find_pwd">비밀번호 찾기</p>
			<p id="coment">임시비밀번호가 발급되었습니다.</p>
			<p id="coment_id">임시비밀번호</p>
			<input type="text" id="res_pwd" readonly>
			<input type="button" id="log_in" value="로그인" onclick="location.href='login_page.do'">
		</div>
		
	</body>
	
	<%@ include file="/WEB-INF/views/main/footer.jsp"%>
	
</html>