<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
	<%@ include file="/WEB-INF/views/admin/admin_index.jsp"%>
	<meta charset="UTF-8">
	<title>삼천리악기 관리자</title>
		
		<link href="${pageContext.request.contextPath}/resources/css/admin/add_product.css" rel="stylesheet">
		<script type="text/javascript">
			
			function add_product( f ) {
				var p_type = f.p_type.value;
				var p_brand = f.p_brand.value;
				var p_name = f.p_name.value;
				var p_price = f.p_price.value;
				var p_origin = f.p_origin.value;
				var p_content_s = f.p_content_s.value;
				var p_content = f.p_content.value;
				var name1 = f.img[0].value;
				var name2 = f.img[1].value;

				if (p_type == "") {
					alert("상품 종류를 선택하세요");
					f.p_type.focus();
					return;
				}
				if (p_brand == "") {
					alert("제조사를 입력하세요");
					f.p_brand.focus();
					return;
				}
				if (p_name == "") {
					alert("모델명 (제품이름)을 입력하세요");
					f.p_name.focus();
					return;
				}
				if (p_price == "") {
					alert("판매가를 입력하세요\n판매가는 숫자만 입력가능합니다");
					f.p_price.focus();
					return;
				}
				if (p_origin == "") {
					alert("원산지(생산지)를 입력하세요");
					f.p_origin.focus();
					return;
				}
				if (p_content_s == "") {
					alert("상품요약정보 (바디타입)을 입력하세요");
					f.p_content_s.focus();
					return;
				}
				if (name1 == "") {
					alert("상품의 대표 이미지를 선택하세요\n(500 x 500 사이즈 권장)");
					f.name1.focus();
					return;
				}
				if (name2 == "") {
					alert("상품을 상세하게 설명할 이미지를 선택하세요");
					f.name2.focus();
					return;
				}

				f.action = "regi_product.do";
				f.submit();
				
			}
			
		</script>
		
	</head>
	<body>
	
		<div id="content" align="center">
			<form method="post" enctype="multipart/form-data">
				<table class="add_product">
	
					<thead>
						<tr>
							<th>항목</th>
							<th>내용</th>
						</tr>
					</thead>
					<tr>
						<th>종류</th>
						<td>
							<select name="p_type">
								<option value="">==========</option>
								<option value="어쿠스틱기타">어쿠스틱기타</option>
								<option value="클래식기타">클래식기타</option>
								<option value="일렉기타">일렉기타</option>
								<option value="베이스기타">베이스기타</option>
								<option value="우쿠렐레">우쿠렐레</option>
								<option value="앰프">앰프</option>
								<option value="etc">etc</option>
							</select>
						</td>
					</tr>
					<tr>
						<th>제조사</th>
						<td>
							<input type="text" name="p_brand">
						</td>
					</tr>
					<tr>
						<th>모델명(이름)</th>
						<td>
							<input type="text" name="p_name">
						</td>
					</tr>
					<tr>
						<th>판매가</th>
						<td>
							<input type="number" pattern="\d*" name="p_price" placeholder="숫자만 입력">
						</td>
					</tr>
					<tr>
						<th>이미지 정사각형(소)</th>
						<td>
							<input type="file" name="img" accept=".jpg, .jpeg, .png" value="사진 선택">
						</td>
					</tr>
					<tr>
						<th>상품 상세설명 이미지(대)</th>
						<td>
							<input type="file" name="img" accept=".jpg, .jpeg, .png" value="사진 선택">
						</td>
					</tr>
					<tr>
						<th>원산지</th>
						<td>
							<input type="text" name="p_origin">
						</td>
					</tr>
					<tr>
						<th>상품요약정보(바디타입 등등)</th>
						<td>
							<input type="text" name="p_content_s">
						</td>
					</tr>
					<tr>
						<th>상품 상세설명</th>
						<td>
							<textarea rows="5" cols="30" name="p_content" style="resize: none;"></textarea>
						</td>
					</tr>
					<tr>
						<th>인기상품 여부</th>
						<td>
							<select name="p_pop">
								<option value="0">==없음==</option>
								<option value="1">인기상품</option>
							</select>
						</td>
					</tr>
					<tr>
						<td align="center">
							<input type="button" onclick="add_product(this.form);" value="등록">
						</td>
						<td align="center">
							<input type="button" onclick="location.href='admin_main.do'" value="취소">
						</td>
					</tr>
	
				</table>
				
			</form>
			
		</div>
	
	</body>
</html>