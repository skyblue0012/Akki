<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt"%>

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
   <meta charset="UTF-8">
   <title>삼천리악기</title>
   
      <link href="${pageContext.request.contextPath}/resources/css/user/user_basket.css" rel="stylesheet">
      <script>
      
         function cart_allcheck(){
            if( document.getElementById('all_check').value == "all_uncheck" ){
               document.getElementById('all_check').value = "all_check";
               var chkbox = document.getElementsByName('product_check');
               for(var i = 0; i < chkbox.length; i++) { 
                  document.getElementsByName('product_check')[i].checked = "checked";
               }
            }else if( document.getElementById('all_check').value == "all_check" ){
               document.getElementById('all_check').value = "all_uncheck";
               var chkbox = document.getElementsByName('product_check');
               for(var i = 0; i < chkbox.length; i++) { 
                  document.getElementsByName('product_check')[i].checked = "";
               }
            }
         }
         
         function basket_del( b_idx ) {
            if(!confirm("선택한 상품을 삭제하시겠습니까?")) {
               return;
            }
            var url = "del_basket.do";
            var param = "b_idx="+b_idx;
            sendRequest(url, param, del_basket_res,"POST");
         }

         function basket_del_sel() {
            
            if(!confirm("선택한 상품을 삭제하시겠습니까?")) {
               return;
            }
            
            var b_idx = new Array();
            
            var chkbox = document.getElementsByName('product_check');
            var a = 0;
            var b = 0;
            
            for(var i = 0; i < chkbox.length; i++) { 
               if(chkbox[i].checked) {
                  a = 1;
                  b_idx[b] = document.getElementsByName('b_idx')[i].value;
                  b++;
               }
            }
            
            if(a == 0) {
               alert("구매하실 상품을 선택하세요");
               location.href="user_basket.do";
               return;
            }
            
            var url = "del_basket_sel.do";
            var param = "b_idx="+b_idx;
            sendRequest(url, param, del_basket_res,"POST");
            
         }
         
         function del_basket_res() {
            if (xhr.readyState == 4 && xhr.status == 200) {
               var data = xhr.responseText;
               if (data == "fail") {
                  alert("삭제에 실패하였습니다");
                  return;
               } else if(data == "need_login") {
                  alert("로그인후 이용가능합니다");
                  location.href="login_page.do"
                  return;
               } else if(data == "success") {
                  location.href="user_basket.do";
                  return;
               }
            }
         }
         
         function order_pay_all(f) {
            f.action = "order_payment.do";
            f.submit();
         }
         
         function order_pay_select(f) {
            
            var chkbox = document.getElementsByName('product_check');
            var a = 0;
            
            for(var i = 0; i < chkbox.length; i++) { 
               if(chkbox[i].checked) {
                  a = 1;
               } else {
                  document.getElementsByName('p_idx')[i].value = 0;
                  document.getElementsByName('amount')[i].value = 0;
               }
            }
            
            if(a == 0) {
               alert("구매하실 상품을 선택하세요");
               location.href="user_basket.do";
               return;
            }
            
            f.action = "order_payment.do";
            f.submit();
            
         }

         var pr_total = parseInt("<c:out value='${total_price}'/>");
         
         function set_up(idx, am, pr) {
            var price = parseInt(pr);
            var real_total = 0;
            document.getElementById("amount"+idx).value++;
            document.getElementById("sum"+idx).value = Comma(document.getElementById("amount"+idx).value * price);
            pr_total = pr_total+price;
            var c_total = Comma(pr_total);
            document.getElementById("price_total1").value = c_total;
            document.getElementById("price_total2").value = c_total;
            if(document.getElementById("delivery2").placeholder == "1")
            	document.getElementById("delivery2").placeholder = "2";
            if(pr_total <= 50000){
            	document.getElementById("delivery1").value = "2,500";
            	document.getElementById("delivery2").value = "2,500";
            	real_total = pr_total + 2500;
            }else{
            	document.getElementById("delivery1").value = "0";
            	document.getElementById("delivery2").value = "0";
            	real_total = pr_total;
            }
            c_total = Comma(real_total);
            document.getElementById("price_total1_1").value = c_total;
            document.getElementById("price_total2_1").value = c_total;
         }
         
         function set_down(idx, am, pr) {
            if(document.getElementById("amount"+idx).value == 1){
               return;
            }
            var price = parseInt(pr);
            var real_total = 0;
            document.getElementById("amount"+idx).value--;
            document.getElementById("sum"+idx).value = Comma(document.getElementById("amount"+idx).value * price);
            pr_total = pr_total-price;
            var c_total = Comma(pr_total);
            document.getElementById("price_total1").value = c_total;
            document.getElementById("price_total2").value = c_total;
            if(document.getElementById("delivery2").placeholder <= "1"){
               document.getElementById("delivery2").placeholder = "2";
               if(pr_total <= 50000){
                  real_total = pr_total + 2500;
               }else{
                  document.getElementById("delivery1").value = "0";
                  document.getElementById("delivery2").value = "0";
                  real_total = pr_total;
               }
            }else{
               if(pr_total > 50000){
                  document.getElementById("delivery1").value = "0";
                  document.getElementById("delivery2").value = "0";
                  real_total = pr_total;
               }else{
                  document.getElementById("delivery1").value = "2,500";
                  document.getElementById("delivery2").value = "2,500";
                  real_total = pr_total + 2500;
               }
            }
            c_total = Comma(real_total);
            document.getElementById("price_total1_1").value = c_total;
            document.getElementById("price_total2_1").value = c_total;
         }
         
         function Comma(n) {
             return n.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
         }
         
      </script>
   </head>
   <body>
   
      <div id="cart_box">
         <h2>장바구니</h2>
         <img class="top_navimg" src="${pageContext.request.contextPath}/resources/img/order_step1.gif" alt="" >
         
         <form method="post">
         
         <div id="product_total">
            <div id="menu_name">
               <input type="checkbox" id="all_check" value="all_uncheck" onclick="cart_allcheck();">
               <p>이미지</p>
               <p>상품명</p>
               <p>판매가</p>
               <p>수량</p>
               <p>배송구분</p>
               <p>배송비</p>
               <p>합계</p>
               <p>선택</p>
            </div>
            <div id="for_box">
               <!-- for문 시작부분 (장바구니에 넣은 상품 출력구간)-->
               <c:forEach var="b" items="${list}">
                  <input type="hidden" value="${b.p_idx}" name="p_idx">
                  <input type="hidden" value="${b.b_idx}" name="b_idx">
                  <div class="cart_product">
                     <input id="check_box" type="checkbox" name="product_check" value="produxt_idx">
                     <img id="pro_img1" src="${pageContext.request.contextPath}/resources/p_img/${b.p_img}" alt=""
                        onclick="detail('${b.p_idx}')"/>
                     <p id="pro_content1">${b.p_name}</p>
                     <p id="price1">
                        <f:formatNumber value="${b.p_price}" pattern="#,###" />원
                     </p>
                     <div class="product_cnt">
                        <input type=hidden name="sell_price" id="sell_price" value="${b.p_price}" disabled>
                        <!-- value에 가격넣기 -->
                        <input type="text" name="amount" id="amount${ b.p_idx }" value="${ b.amount }" size="3" readonly="readonly">
                        <input type="button" value="▲" width="26px" onclick="set_up('${ b.p_idx }','${ b.amount }','${b.p_price}');">
                        <input type="button" value="▼" onclick="set_down('${ b.p_idx }','${ b.amount }','${b.p_price}');"><br>
                        <input type="text" class="sum" name="sum" id="sum${ b.p_idx }" size="11" readonly disabled value="${b.p_price*b.amount }">
                     </div>
                     <p class="send_type">기본배송</p>
                     <p class="send_price">
                        <c:if test="${50000 lt b.p_price}">무료</c:if>
                        <c:if test="${50000 gt b.p_price}">2,500 원</c:if>
                     </p>
                     <div class="select_div">
                        <input type="button" value="주문하기" onclick="order_pay_one('${b.p_idx}', document.getElementById('amount${ b.p_idx }').value);">
                        <input type="button" value="삭제하기" onclick="basket_del('${b.b_idx}');">
                     </div>
                  </div>
               </c:forEach>
               <!-- for문 끝나는 부분 -->
            </div>
            
            <div id="total_price">
               <p>상품구매금액</p> 
               <input id="price_total1" value="" readonly="readonly">
               <p>원</p>
               <p>+</p>
               <p>배송비</p> 
               <input id="delivery1" value="" placeholder="" readonly="readonly">
               <p>원</p>
               <p>=<p> 
               <p>합계</p> 
               <p>:</p>
               <input id="price_total1_1" value="" readonly="readonly">
               <p>원</p>
               </div>
            <div id="del_cart">
               <p>선택상품</p>
               <input type="button" value=" X 삭제하기" onclick="basket_del_sel();">
            </div>
            <div id="price_box">
               <div id="price_menu">
                  <p>총 상품금액</p>
                  <p>총 배송비</p>
                  <p>결제예정금액</p>
               </div>
               <div id="price_value">
                  <p><input id="price_total2" value="" readonly="readonly">원</p>
                  <p>+<input id="delivery2" placeholder="" value="" readonly="readonly">원</p>
                  <p>=<input id="price_total2_1" value="" readonly="readonly">원</p>
               </div>
            </div>
            <div id="button_div">
               <input type="button" value="전체상품주문" onclick="order_pay_all(this.form);">
               <input type="button" value="선택상품주문" onclick="order_pay_select(this.form);">
            </div>
         </div>
         
         </form>
         
      </div>
      
   </body>
   <script type="text/javascript">
      window.onload = function() {
         var size = document.getElementsByName('p_idx').length;
         var p_idx = "";
         for (var i = 0; i < size; i++) {
            p_idx = document.getElementsByName('p_idx')[i].value;
            document.getElementById('sum' + p_idx).value = document.getElementById('sum' + p_idx).value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
            p_idx = "";
         }
         var total_price = "<c:out value='${total_price}'/>";
         document.getElementById("price_total1").value = total_price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
         document.getElementById("price_total2").value = total_price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
         if (total_price <= 50000) {
            document.getElementById("delivery1").value = "2,500";
            document.getElementById("delivery1").placeholder = "1";
            document.getElementById("delivery2").value = "2,500";
            document.getElementById("delivery2").placeholder = "1";
            total_price = parseInt(total_price) + 2500;
         } else {
            document.getElementById("delivery1").value = "0";
            document.getElementById("delivery1").placeholder = "1";
            document.getElementById("delivery2").value = "0";
            document.getElementById("delivery2").placeholder = "1";
         }
         document.getElementById("price_total1_1").value = total_price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
         document.getElementById("price_total2_1").value = total_price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
      }
   </script>
   <%@ include file="/WEB-INF/views/main/footer.jsp"%>
   
</html>