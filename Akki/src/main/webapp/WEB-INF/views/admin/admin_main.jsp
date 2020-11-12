<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
	<head>
	<%@ include file="/WEB-INF/views/admin/admin_index.jsp"%>
	<meta charset="UTF-8">
	<title>삼천리악기 관리자</title>
		<link href="${pageContext.request.contextPath}/resources/css/admin/admin_main.css" rel="stylesheet">
		<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/httpRequest.js"></script>
		<script type="text/javascript">
		
            function search() {
               var what = document.getElementById('what').value;
               var how = document.getElementById('how').value;
               if( what == "" ){
                  what = "*";
               }
               location.href = "admin_searching.do?how=" + encodeURIComponent(how) + "&what=" + encodeURIComponent(what);
            }
            
            function modify(p_idx) {            
               location.href = "admin_modify.do?p_idx=" + p_idx;
               return;
            }
            
            function del(p_idx) {   
               if( confirm("삭제하시겠습니까?") ) {
                  var url = "admin_del.do";
                   var param = "p_idx=" + p_idx;
                   sendRequest(url, param, resultFn, "POST");
                  return;
                 }
            }
            
			function resultFn() {
				if (xhr.readyState == 4 && xhr.status == 200) {
					var data = xhr.responseText;
					if (data == "fail") {
						alert("삭제에 실패했습니다");
						return;
					} else if (data == "success") {
						alert("삭제를 완료했습니다");
						location.href = "admin_main.do";
					}
				}
			}
			
		</script>
	</head>
	<body>
	
		<div id="content">
			<br>
			<div id="search_box">
				<select id="how">
					<option value="*">전체</option>
					<option value="p_type">종류</option>
					<option value="p_brand">제조사</option>
					<option value="p_name">모델명</option>
					<option value="p_origin">원산지</option>
				</select>
				<input id="what" type="search" placeholder="검 색" onkeypress="if(event.keyCode==13){search();}" />
				<img src="${pageContext.request.contextPath}/resources/img/search_black_x2.png" alt="" onclick="search();" style="cursor: pointer;">
			</div>
		</div>
		
		<div id="table_box">
			<c:if test="${ !empty list }">
				<div>
					<table id="pro_list">
						<tr id="table_top">
							<th>종류</th>
							<th>제조사</th>
							<th>모델명</th>
							<th>판매가</th>
							<th>대표이미지</th>
							<th>원산지</th>
							<th>비고</th>
						</tr>
						
						<c:forEach var="vo" items="${ list }">
							<tr>
								<td>${vo.p_type}</td>
								<td>${vo.p_brand}</td>
								<td>${vo.p_name}</td>
								<td><f:formatNumber value="${vo.p_price}" pattern="#,###"/>원</td>
								<td>
									<img width="250px;" height="250px;" alt="대표이미지" src="${pageContext.request.contextPath}/resources/p_img/${ vo.p_img }">
								</td>
								<td>${vo.p_origin}</td>
								<td>
									<input type="button" value="수정" onclick="modify('${vo.p_idx}');">
									<input type="button" value="삭제" onclick="del('${vo.p_idx}');">
								</td>
						</c:forEach>
					</table>
				</div>
				
				<table id="pagemenu">
					<tr height="30">
						<td align="center">${pageMenu}</td>
					</tr>
				</table>
				
			</c:if>
			
			<c:if test="${ empty list }">
			검색한 상품이 존재하지 않습니다.
			</c:if>
			
		</div>
	</body>
</html>