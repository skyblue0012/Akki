<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
	<head>
	<%@ include file="/WEB-INF/views/admin/admin_index.jsp"%>
	<meta charset="UTF-8">
	<title>삼천리악기 관리자</title>
		
		<link href="${pageContext.request.contextPath}/resources/css/admin/add_product.css" rel="stylesheet">
		<script type="text/javascript">
			
			function modify_product( f ) {
				
				var p_type = f.p_type.value;
				var p_brand = f.p_brand.value;
				var p_name = f.p_name.value;
				var p_price = f.p_price.value;
				var p_origin = f.p_origin.value;
				var p_content_s = f.p_content_s.value;
				var p_content = f.p_content.value;
				var name1 = f.img[0].value;
				var name1_check = f.img[0].style.display;
				var name2 = f.img[1].value;
				var name2_check = f.img[1].style.display;
				
				if( p_type == "" ) {
					alert("상품 종류를 선택하세요");
					f.p_type.focus();
					return;
				}
				if( p_brand == "" ) {
					alert("제조사를 입력하세요");
					f.p_brand.focus();
					return;
				}
				if( p_name == "" ) {
					alert("모델명 (제품이름)을 입력하세요");
					f.p_name.focus();
					return;
				}
				if( p_price == "" ) {
					alert("판매가를 입력하세요\n판매가는 숫자만 입력가능합니다");
					f.p_price.focus();
					return;
				}
				if( p_origin == "" ) {
					alert("원산지(생산지)를 입력하세요");
					f.p_origin.focus();
					return;
				}
				if( p_content_s == "" ) {
					alert("상품요약정보 (바디타입)을 입력하세요");
					f.p_content_s.focus();
					return;
				}
				if( name1_check != "none" ) {
					if( name1 == "" ) {
						alert("상품의 대표 이미지를 선택하세요\n(500 x 500 사이즈 권장)");
						f.name1.focus();
						return;
					}
				}
				if( name2_check != "none" ) {
					if( name2 == "" ) {
						alert("상품을 상세하게 설명할 이미지를 선택하세요");
						f.name2.focus();
						return;
					}
				}
				
				f.action = "modify_product.do";
				f.submit();
				
			}
			
			function img_del() {
				document.getElementById('old_img1').style.display='none';
				document.getElementsByName('img')[0].style.display='block';
				document.getElementById('del1').style.display='none';
				return;
			}
			
			function content_img_del() {
				document.getElementById('old_img2').style.display='none';
				document.getElementsByName('img')[1].style.display='block';
				document.getElementById('del2').style.display='none';
				return;
			}
			
		</script>
	</head>
	<body>
		
		<div id="content" align="center">
			<form method="post" enctype="multipart/form-data">
				<table class="add_product" >
					<thead>
						<tr>
							<th>항목</th>
							<th>내용</th>
						</tr>
					</thead>
					<tr>
						<th>종류</th>
						<td>
							<select id="p_type" name="p_type">
								<option value="">==========</option>
								<option value="어쿠스틱기타"<c:if test="${vo.p_type=='어쿠스틱기타'}">selected</c:if> >어쿠스틱기타</option>
								<option value="클래식기타"<c:if test="${vo.p_type=='클래식기타'}">selected</c:if> >클래식기타</option>
								<option value="일렉기타"<c:if test="${vo.p_type=='일렉기타'}">selected</c:if> >일렉기타</option>
								<option value="베이스기타"<c:if test="${vo.p_type=='베이스기타'}">selected</c:if> >베이스기타</option>
								<option value="우쿠렐레"<c:if test="${vo.p_type=='우쿠렐레'}">selected</c:if> >우쿠렐레</option>
								<option value="앰프"<c:if test="${vo.p_type=='앰프'}">selected</c:if> >앰프</option>
								<option value="etc"<c:if test="${vo.p_type=='etc'}">selected</c:if> >etc</option>
							</select>
						</td>
					</tr>
					<tr>
						<th>제조사</th>
						<td>
							<input type="text" name="p_brand" value="${vo.p_brand}">
						</td>
					</tr>
					<tr>
						<th>모델명(이름)</th>
						<td>
							<input type="text" name="p_name" value="${vo.p_name}">
						</td>
					</tr>
					<tr>
						<th>판매가</th>
						<td>
							<input type="number" name="p_price" placeholder="숫자만 입력" pattern='\d*' value="${vo.p_price}">
						</td>
					</tr>
					<tr>
						<th>이미지 정사각형(소)</th>
						<td>
							<input type="file" name="img" accept=".jpg, .jpeg, .png" value="사진 선택" style="display: none;">
							<input type="hidden" value="${vo.p_img}" name="old_img1" >
							<img id="old_img1" width="250px;" height="250px;" style="display: block;" alt="" src="${pageContext.request.contextPath}/resources/p_img/${vo.p_img}">
							<input id="del1" type="button" value="삭제하기" onclick="img_del();">
						</td>
					</tr>
					<tr>
						<th>상품 상세설명 이미지(대)</th>
						<td>
							<input type="file" name="img" accept=".jpg, .jpeg, .png" value="사진 선택" style="display: none;">
							<input type="hidden" value="${vo.p_content_img}" name="old_img2" >
							<img id="old_img2" width="250px;" height="250px;" style="display: block;" alt="" src="${pageContext.request.contextPath}/resources/p_img/${vo.p_content_img}">
							<input id="del2" type="button" value="삭제하기" onclick="content_img_del();">
						</td>
					</tr>
					<tr>
						<th>원산지</th>
						<td>
							<input type="text" name="p_origin" value="${vo.p_origin}">
						</td>
					</tr>
					<tr>
						<th>상품요약정보(바디타입 등등)</th>
						<td>
							<input type="text" name="p_content_s" value="${vo.p_content_s}">
						</td>
					</tr>
					<tr>
						<th>상품 상세설명</th>
						<td>
							<textarea rows="5" cols="30" name="p_content" style="resize: none;">${vo.p_content}</textarea>
						</td>
					</tr>
					<tr>
						<th>인기상품 여부</th>
						<td>
							<select name="p_pop">
								<option value="0"<c:if test="${vo.p_pop=='0'}">selected</c:if> >==없음==</option>
								<option value="1"<c:if test="${vo.p_pop=='1'}">selected</c:if> >인기상품</option>
							</select>
						</td>
					</tr>
					<tr>
						<td align="center">
							<input type="hidden" value="${vo.p_idx}" name="p_idx">
							<input type="button" onclick="modify_product(this.form);" value="수정">
						</td>
						<td align="center">
							<input type="button" onclick="img_check();" value="취소">
						</td>
					</tr>
				</table>
			</form>
		</div>
		
	</body>
</html>