package com.korea.akki;

import java.io.File;
import java.io.IOException;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.siot.IamportRestClient.IamportClient;
import com.siot.IamportRestClient.exception.IamportResponseException;
import com.siot.IamportRestClient.request.CancelData;
import com.siot.IamportRestClient.response.IamportResponse;
import com.siot.IamportRestClient.response.Payment;

import common.Common;
import common.Paging;
import dao.BasketDAO;
import dao.PaymentDAO;
import dao.ProductDAO;
import dao.UserDAO;
import log.UserService;
import vo.Add_basketVO;
import vo.BankVO;
import vo.BasketVO;
import vo.CategoryVO;
import vo.DeliveryVO;
import vo.OrderVO;
import vo.PaymentVO;
import vo.Payment_listVO;
import vo.ProductVO;
import vo.UserVO;

@Controller
public class AkkiController {

	ProductDAO product_dao;
	UserDAO user_dao;
	BasketDAO basket_dao;
	PaymentDAO payment_dao;
	
	@Inject
	UserService user_service;
	
	@Autowired 
	ServletContext application;

	@Autowired
	HttpServletRequest request;

	@Autowired
	HttpSession session;
	
	public void setProduct_dao(ProductDAO product_dao) {
		this.product_dao = product_dao;
	}
	public void setUser_dao(UserDAO user_dao) {
		this.user_dao = user_dao;
	}
	public void setBasket_dao(BasketDAO basket_dao) {
		this.basket_dao = basket_dao;
	}
	public void setPayment_dao(PaymentDAO payment_dao) {
		this.payment_dao = payment_dao;
	}
	
	//메인페이지
	@RequestMapping(value = { "/", "main.do" })
	public String Main_do(Model model, Integer page, Integer order) {
		
		List<CategoryVO> category = product_dao.category();
		
		session.setAttribute("category", category);
		
		int nowPage = 1;
		
		if( page != null ) {
			nowPage = page;
		}
		if( order == null ) {
			order = 1;
		}
		
		int start = (nowPage -1) * Common.product_page.BLOCKLIST;
		int end = start + Common.product_page.BLOCKLIST;
		
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("start", start);
		map.put("end", end);
		
		List<ProductVO> list = null;
		list = product_dao.selectList(map, order);	
		
		int row_total = product_dao.getRowTotal();
		
		//페이지 메뉴 생성
		String pageMenu = Paging.getPaging(
				"main.do", nowPage, row_total, Common.product_page.BLOCKLIST, Common.product_page.BLOCKPAGE, order, "", "", "", "", "", 10, "", "");
		
		model.addAttribute("list", list);
		model.addAttribute("pageMenu", pageMenu);
		
		return Common.main.VIEW_PATH + "main.jsp";
	}

	//회원가입페이지 이동
	@RequestMapping("sign_up.do")
	public String sign_up() {
		return Common.login.VIEW_PATH + "signup_page.jsp";
	}
	
	//회원가입페이지 이동2
	@RequestMapping("sign_up2.do")
	public String sign_up2(String clause) {
		if(clause==null) {
			return Common.login.VIEW_PATH + "warning.jsp";
		}
		return Common.login.VIEW_PATH + "signup_page2.jsp";
	}
	
	//아이디 체크
	@RequestMapping("check_id.do")
	@ResponseBody
	public String check_id(String id) {

		String str = "no";

		int res = user_dao.check_id(id);

		if(res == 0) {
			str="yes";
		}
		return str;
	}
	
	//회원가입
	@RequestMapping("regi.do")
	@ResponseBody
	public String regi( UserVO vo ) {

		String str = "no";

		int res = user_dao.regi(vo);

		if(res > 0) {
			str = "yes";
			return str;
		}
		
		return str; 
	}

	//로그인 페이지
	@RequestMapping("login_page.do")
	public String login_page() {
		return Common.login.VIEW_PATH + "login_page.jsp";
	}
	
    //로그인 처리
	@RequestMapping("loginCheck.do")
    @ResponseBody
    public String loginCheck(String id, String pwd) {
		
    	String restr = "no_find";
		UserVO check_vo = user_dao.check_vo(id,pwd);
		UserVO haveLogin = new UserVO();
		haveLogin = (UserVO)session.getAttribute("user");
		
		if(haveLogin != null) {
			if(haveLogin.getId().equals(id)) {
				restr = "h_idLogin";
				return restr;
			}
		}
		
		if( check_vo != null ) {
			
	    		boolean result = user_service.loginCheck(check_vo, session);
	    	
	    		if(result == true) {
		    		session.setAttribute("user", check_vo);
	    			session.setMaxInactiveInterval(30*60);//30분
	    			restr = "yes";
	    		}else {
	    			restr = "error";
	    		}
		}else {
			int check_id = 0;
			check_id = user_dao.check_id(id);
    			if(check_id > 0) {
    				restr = "no_pwd";
    			}
		}
		
    	return restr;
    }
    
    //로그아웃 처리
    @RequestMapping("logOut.do")
    @ResponseBody
    public String logOut(String str, String id) {
        	session.removeAttribute("user");
        	UserVO haveLogin = (UserVO)session.getAttribute("user");
    	if(haveLogin == null) {
    		str = "yes";
    	}
    	
    	return str;
    }
    
	//상품카테고리 브랜드 선택 페이지 이동
	@RequestMapping("product_category.do")
	public String product_category( String p_type, String p_brand, Integer page, Integer order, Model model ) {
		
		int nowPage = 1;
		
		if( page != null ) {
			nowPage = page;
		}
		if( order == null ) {
			order = 1;
		}
		if( p_brand == null ) {
			p_brand = "all";
		}
		
		int start = (nowPage -1) * Common.product_page.BLOCKLIST;
		int end = start + Common.product_page.BLOCKLIST;
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("start", start);
		map.put("end", end);
		
		List<ProductVO> list = null;
		int row_total = 0;
		
		System.out.println("여기까지옴" + p_type);
		System.out.println("여기까지옴" + p_brand);
		
		if( p_brand.equals("all") ) {
			
			System.out.println("여기들어옴");
			
			map.put("p_type", p_type);
			list = product_dao.product_category_all( map, order );
			int p_cnt = product_dao.product_cnt_all( p_type );
			row_total = p_cnt;
			
			model.addAttribute("list", list);
			model.addAttribute("p_cnt", p_cnt);
			
		} else if( !p_brand.equals("all") ) {
			
			System.out.println("저기 들어감");
			
			map.put("p_type", p_type);
			map.put("p_brand", p_brand);
			list = product_dao.product_category( map, order );
			int p_cnt = product_dao.product_cnt(p_type, p_brand);
			row_total = p_cnt;
			
			model.addAttribute("list", list);
			model.addAttribute("p_cnt", p_cnt);
			
		}
		
		//페이지 메뉴 생성
		String pageMenu = Paging.getPaging(
				"product_category.do", nowPage, row_total, Common.product_page.BLOCKLIST, Common.product_page.BLOCKPAGE, order, p_type, p_brand, "", "", "", 10, "", "");
		
		model.addAttribute("pageMenu", pageMenu);
		model.addAttribute("p_brand", p_brand);
		
		return Common.product.VIEW_PATH + "product_category.jsp";
	}
	
	//상품상세설명 페이지 이동
	@RequestMapping("product_detail.do")
	public String product_detail( int p_idx, Model model ) {
		
		ProductVO vo = product_dao.oneVO(p_idx);
		
		model.addAttribute("vo", vo);
		
		return Common.product.VIEW_PATH + "product_detail.jsp";
	}
	
	//유저페이지 검색란
	@RequestMapping("user_searching.do")
	public String user_searching(String what, Integer page, Integer order, Model model) {
		
		int nowPage = 1;
		
		if( page != null ) {
			nowPage = page;
		}
		if( order == null ) {
			order = 1;
		}
		
		int start = (nowPage -1) * Common.product_page.BLOCKLIST;
		int end = start + Common.product_page.BLOCKLIST;
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("start", start);
		map.put("end", end);
		map.put("what", what);
		
		List<ProductVO> list = null;
		list = product_dao.user_searching(map, order);
		
		int row_total = product_dao.getRowTotal_search( what );
		
		//페이지 메뉴 생성
		String pageMenu = Paging.getPaging(
				"user_searching.do", nowPage, row_total, Common.product_page.BLOCKLIST, Common.product_page.BLOCKPAGE, order, "", "", what, "", "", 10, "", "");
		
		model.addAttribute("list", list);
		model.addAttribute("pageMenu", pageMenu);
		
		return Common.main.VIEW_PATH + "search.jsp";
	}
	
	//이용약관 이동
	@RequestMapping("service.do")
	public String service() {
		return Common.policy.VIEW_PATH + "service.jsp";
	}
	
	//개인정보 취급방침 이동
	@RequestMapping("privacy.do")
	public String privacy() {
		return Common.policy.VIEW_PATH + "privacy.jsp";
	}
	
	
	
	//=========================User 컨트롤러=========================
	
	//로그아웃 처리
	@RequestMapping("just_logout.do")
	public String just_logout() {
		
		session.removeAttribute("user");
		
		return Common.login.VIEW_PATH + "login_page.jsp";
	}
	
	//마이페이지 비밀번호 확인 이동
	@RequestMapping("userPage_check.do")
	public String userPage_check() {
		
		UserVO vo = (UserVO) session.getAttribute("user");
		if( vo == null ) {
			return Common.login.VIEW_PATH + "need_login.jsp";
		}
		
		return Common.user.VIEW_PATH + "userPage_check.jsp";
	}
	
	//회원정보 변경 이동전 체크
	@ResponseBody
	@RequestMapping("userInfo_check.do")
	public String userInfo_check( String password_check ) {
		
		UserVO vo = (UserVO) session.getAttribute("user");
		if( vo == null ) {
			return Common.login.VIEW_PATH + "need_login.jsp";
		}
		
		String result = "wrong";
		
		if( vo.getPwd().equals(password_check) ) {
			result = "correct";
			session.setAttribute("result", result);
			return result;
		} else if( password_check == null ) {
			return Common.main.VIEW_PATH + "wrong_access.jsp";
		}
		
		return result;
	}
	
	//회원정보변경 페이지 이동
	@RequestMapping("userInfo_change.do")
	public String userInfo_change( String password_check ) {
		
		UserVO vo = (UserVO) session.getAttribute("user");
		if( vo == null ) {
			return Common.login.VIEW_PATH + "need_login.jsp";
		}
		
		String result = (String) session.getAttribute("result");
		
		if( result == null || !result.equals("correct") ) {
			return Common.main.VIEW_PATH + "wrong_access.jsp";
		}
		
		session.removeAttribute("result");
		
		return Common.user.VIEW_PATH + "userInfo_change.jsp";
	}
	
	//회원정보수정 처리
    @RequestMapping("modify_user.do")
    @ResponseBody
    public String modify_user(String id, String email, String tel, String addr_1, String addr_2) {
    	String str = "no";
    	
    	int res = user_dao.modify_user(id,email, tel, addr_1, addr_2);
    	
    	if(res > 0) {
    		str = "yes";
    	}
    	
    	return str;
    }
	
	//비밀번호 변경 이동
	@RequestMapping("pwd_change.do")
	public String pwd_change() {

		UserVO vo = (UserVO) session.getAttribute("user");
		if( vo == null ) {
			return Common.main.VIEW_PATH + "wrong_access.jsp";
		}
		
		return Common.user.VIEW_PATH + "userPwd_change.jsp";
	}
	
	//비밀번호 변경 확인
	@ResponseBody
	@RequestMapping("pwd_change_check.do")
	public String pwd_change_check( String pwd1, String pwd2, String pwd3 ) {

		UserVO vo = (UserVO) session.getAttribute("user");
		if( vo == null ) {
			return Common.main.VIEW_PATH + "wrong_access.jsp";
		}
		
		String result = "fail";
		
		if( !vo.getPwd().equals(pwd1) ) {
			result = "wrong_pwd";
			return result;
		} else if( !pwd2.equals(pwd3) ) {
			result = "different_pwd";
		} else if( vo.getPwd().equals(pwd1) && pwd2.equals(pwd3)) {
			user_dao.change_pwd(vo.getId(), pwd2);
			result = "success";
			return result;
		}
		
		return result;
	}
	
	//아이디 비밀번호 찾기 선택창 이동
	@RequestMapping("which_id_pwd.do")
	public String which_id_pwd() {
		
		UserVO vo = (UserVO) session.getAttribute("user");
		if( vo != null ) {
			return Common.main.VIEW_PATH + "wrong_access.jsp";
		}
		
		return Common.login.VIEW_PATH + "which_id_pwd.jsp";
	}
	
	//아이디 찾기 이동
	@RequestMapping("find_id.do")
	public String find_id() {
		
		UserVO vo = (UserVO) session.getAttribute("user");
		if( vo != null ) {
			return Common.main.VIEW_PATH + "wrong_access.jsp";
		}
		
		return Common.login.VIEW_PATH + "find_id.jsp";
	}
	
	//비밀번호 찾기 이동
	@RequestMapping("find_pwd.do")
	public String find_pwd( Model model, String id ) {
		
		UserVO vo = (UserVO) session.getAttribute("user");
		if( vo != null ) {
			return Common.main.VIEW_PATH + "wrong_access.jsp";
		}
		
		if( id != null ) {
			model.addAttribute("id", id);
		}
		
		return Common.login.VIEW_PATH + "find_pwd.jsp";
	}
	
	//아이디 찾기
	@ResponseBody
	@RequestMapping("checking_id.do")
	public String checking_id(String name, String email, String tel) {
		  
		String str = "no";
		str = user_dao.checking_id(name, email, tel);
		
		return str;
	}
	
	//비밀번호 찾기
	@ResponseBody
	@RequestMapping("checking_pwd.do")
	public String checking_pwd(String id, String name, String email, String tel) {
		
		char[] charSet = new char[] { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 
				'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 
				'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 
				'U', 'V', 'W', 'X', 'Y', 'Z' };  
		int idx = 0; 
		StringBuffer sb = new StringBuffer();  
		
		String str = user_dao.checking_pwd(id, name, email, tel);
		if(str != null) { 
			for (int i = 0; i < 6; i++) { 
				idx = (int) (charSet.length * Math.random());
				sb.append(charSet[idx]); 
			}
			str = sb.toString(); 
			user_dao.change_pwd(id, str);
		}
		
		return str;
	}
	
	//====================================================================
	
	//=========================Basket Order 컨트롤러=========================
	
	//장바구니 추가
	@ResponseBody
	@RequestMapping("add_basket.do")
	public String add_basket( Add_basketVO add_vo ) {

		String result = "fail";
		
		UserVO vo = (UserVO) session.getAttribute("user");
		if( vo == null ) {
			result = "need_login";
			return result;
		}

		add_vo.setId(vo.getId());
		
		if( add_vo.getAmount() == 0 ) {
			add_vo.setAmount(1);
		}
		
		int res = basket_dao.add_basket( add_vo );
		
		if( res == 999 ) {
			result = "already_basket";
			return result;
		}
		
		if( 999 > res || res > 0 ) {
			result = "success";
			return result;
		}
		
		return result;
	}
	
	//장바구니 삭제
	@ResponseBody
	@RequestMapping("del_basket.do")
	public String del_basket( int b_idx ) {
		
		String result = "fail";
		
		UserVO vo = (UserVO) session.getAttribute("user");
		if( vo == null ) {
			result = "need_login";
			return result;
		}
		
		int res = basket_dao.del_basket(b_idx, vo.getId());
		
		if( res > 0 ) {
			result = "success";
			return result;
		}
		
		return result;
	}
	
	//장바구니 선택삭제
	@ResponseBody
	@RequestMapping("del_basket_sel.do")
	public String del_basket_sel( int b_idx[] ) {
		
		String result = "fail";
		
		UserVO vo = (UserVO) session.getAttribute("user");
		if( vo == null ) {
			result = "need_login";
			return result;
		}
		
		int res = basket_dao.del_basket_sel(b_idx, vo.getId());
		
		if( res > 0 ) {
			result = "success";
			return result;
		}
		
		return result;
	}
	
	//장바구니 이동
	@RequestMapping("user_basket.do")
	public String user_basket( Model model ) {
		
		UserVO vo = (UserVO) session.getAttribute("user");
		if( vo == null ) {
			return Common.login.VIEW_PATH + "need_login.jsp";
		}
		
		List<BasketVO> list = basket_dao.selectList( vo.getId() );
		
		int total_price = 0;
		
		for( int i = 0; i < list.size(); i++ ) {
			total_price = total_price + list.get(i).getP_price() * list.get(i).getAmount(); 
		}
		
		model.addAttribute("list", list);
		model.addAttribute("total_price", total_price);
		
		return Common.user.VIEW_PATH + "user_basket.jsp";
	}
	
	//결제페이지 이동
	@RequestMapping("order_payment.do")
	public String order_payment( @RequestParam List<Integer> p_idx, @RequestParam List<Integer> amount, Model model ) {
		
		UserVO vo = (UserVO) session.getAttribute("user");
		if( vo == null ) {
			return Common.login.VIEW_PATH + "need_login.jsp";
		}

		int total_price = 0;
		
		if( p_idx.size() > 1 && amount.size() > 1 ) {
			
			List<BasketVO> list = basket_dao.selectList(vo.getId());

			int check = list.size()-1;
			
			for( int i = check; i >= 0; i-- ) {
				if( list.get(i).getP_idx() != p_idx.get(i) ) {
					list.remove(i);
				} else if( list.get(i).getP_idx() == p_idx.get(i) ) {
					list.get(i).setAmount(amount.get(i));
				}
			}
			
			for( int i = 0; i < list.size(); i++ ) {
				total_price = total_price + list.get(i).getP_price() * list.get(i).getAmount(); 
			}
			
			String p_name = list.get(0).getP_name();
			p_name += " 외";
			p_name += list.size() - 1;
			p_name += "개";
			
			model.addAttribute("p_name", p_name);
			model.addAttribute("list", list);
			model.addAttribute("total_price", total_price);
			
			return Common.user.VIEW_PATH + "order_payment.jsp";
		
		} else if( 2 > p_idx.size() && 2 > amount.size() ) {
			
			ProductVO product = product_dao.oneVO(p_idx.get(0));
			
			total_price = product.getP_price() * amount.get(0);
			
			model.addAttribute("p_name", product.getP_name());
			model.addAttribute("product", product);
			model.addAttribute("amount", amount.get(0));
			model.addAttribute("total_price", total_price);
			
			return Common.user.VIEW_PATH + "order_payment.jsp";
		}
		
		return Common.user.VIEW_PATH + "order_payment.jsp";
	}
	
	private final IamportClient client = new IamportClient("1665404222674809",
			"N8FqmcntQZ3l2wCiLf3d358tsTxpuj1isHIOU6hK6l58RIrDYuR1AZv3T2tomvGOcpC6vURCgXL8GcME");
	
	//결제
	@ResponseBody
	@RequestMapping("complete.do")
	public ResponseEntity<String> complete(String imp_uid, PaymentVO pay_vo, DeliveryVO d_vo, int date_unix) {
		
		String res = "error";
		
		UserVO vo = (UserVO) session.getAttribute("user");
		
		pay_vo.setO_id(vo.getId());
		pay_vo.setO_deliver(1);
		
		long t = Long.parseLong(date_unix + "000");
		SimpleDateFormat simpleDate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss",Locale.KOREA);
		pay_vo.setO_date(simpleDate.format(t));
		
		BigDecimal amount = payment_dao.getAmount(pay_vo.getP_idx(), pay_vo.getP_amount());
		
		try {
			
			IamportResponse<Payment> payment_response = client.paymentByImpUid(imp_uid);
			
			Payment result = payment_response.getResponse();
			
			BigDecimal imp_amount = result.getAmount();
			
			if( imp_amount.compareTo(pay_vo.getTotal_price()) == 0 || imp_amount.compareTo(amount) == 0 ) {
				
				int res_pay = payment_dao.pay_complete(pay_vo);
				int res_del = payment_dao.add_delivery(d_vo);
				
				if( res_pay == 0 || res_del == 0 ) {
					CancelData cancel_data = new CancelData(imp_uid, true);
					
					cancel_data.setReason("가맹점 DB오류");
					
					IamportResponse<Payment> cancel = client.cancelPaymentByImpUid(cancel_data);
					
					System.out.println(cancel.getResponse().getStatus());
					
					payment_dao.del_pay_complete(pay_vo.getO_no());
					
					return new ResponseEntity<String>(res, HttpStatus.OK);
				}

				payment_dao.del_complete_basket(pay_vo.getP_idx(), vo.getId());
				
				res = "success";
				
				return new ResponseEntity<String>(res, HttpStatus.OK);
			} else {
				
				CancelData cancel_data = new CancelData(imp_uid, true);
				
				cancel_data.setReason("결제 위변조 시도");
				
				IamportResponse<Payment> cancel = client.cancelPaymentByImpUid(cancel_data);
				
				System.out.println(cancel.getResponse().getStatus());
				
				res = "hack";
				
				return new ResponseEntity<String>(res, HttpStatus.OK);
			}
			
		} catch (IamportResponseException e) {
			System.out.println(e.getMessage());
			
			switch(e.getHttpStatusCode()) {
			case 401 :
				//TODO : 401 Unauthorized
				res = "401";
				return new ResponseEntity<String>(res, HttpStatus.OK);
			case 404 :
				//TODO : imp_123412341234 에 해당되는 거래내역이 존재하지 않음
				res = "404";
				return new ResponseEntity<String>(res, HttpStatus.OK);
			case 500 :
				//TODO : 서버 응답 오류
				res = "500";
				return new ResponseEntity<String>(res, HttpStatus.OK);
			}
		} catch (IOException e) {
			//서버 연결 실패
			e.printStackTrace();
			return new ResponseEntity<String>(res, HttpStatus.OK);
		}
		
		return new ResponseEntity<String>(res, HttpStatus.OK);
	}
	
	@RequestMapping("m_complete.do")
	@ResponseBody
	public String m_complete() {
		
		String res = "";
		
		System.out.println("들어옴");
		
		return res;
	}
	
	//무통장입금 결제
	@RequestMapping("complete_bank.do")
	@ResponseBody
	public String complete_bank( PaymentVO pay_vo, DeliveryVO d_vo, BankVO bank_vo ) {
		
		String res = "error";
		
		UserVO vo = (UserVO) session.getAttribute("user");
		
		SimpleDateFormat simpleDate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss",Locale.KOREA);
		
		pay_vo.setO_id(vo.getId());
		pay_vo.setO_pg("bank");
		pay_vo.setO_status("wait");
		pay_vo.setO_pay("bank");
		pay_vo.setO_deliver(0);
		pay_vo.setO_date(simpleDate.format(pay_vo.getO_no()));
		
		bank_vo.setB_status(1);
		
		int res_pay = payment_dao.pay_complete(pay_vo);
		int res_del = payment_dao.add_delivery(d_vo);
		int res_bank = payment_dao.add_bank(bank_vo);
		
		if( res_pay == 0 || res_del == 0 || res_bank == 0 ) {

			payment_dao.del_pay_complete(pay_vo.getO_no());
			payment_dao.del_bank(pay_vo.getO_no());
			
			return res;
		}
		
		payment_dao.del_complete_basket(pay_vo.getP_idx(), vo.getId());
		
		res = "success";
		
		return res;
	}
	
	//결제완료 페이지 이동
	@RequestMapping("order_success.do")
	public String order_success( long no, Model model ) {
		
		UserVO vo = (UserVO) session.getAttribute("user");
		if( vo == null ) {
			return Common.login.VIEW_PATH + "need_login.jsp";
		}
		
		PaymentVO pay_vo = payment_dao.recent_order(no);
		List<Payment_listVO> pay_list = payment_dao.recent_list(no);
		DeliveryVO del_vo = payment_dao.recent_delivery(no);
		
		if( pay_vo.getO_pay().equals("bank") ) {
			BankVO bank_vo = payment_dao.recent_bank(no);
			model.addAttribute("bank_vo", bank_vo);
		}
		
		model.addAttribute("pay_vo", pay_vo);
		model.addAttribute("pay_list", pay_list);
		model.addAttribute("del_vo", del_vo);
		
		return Common.user.VIEW_PATH + "order_success.jsp";
	}
	
	//주문조회 이동
	@RequestMapping("order_list.do")
	public String order_list( String start_date, String end_date, Integer o_deliver, String mode, Integer page, Model model ) {
		
		UserVO vo = (UserVO) session.getAttribute("user");
		if( vo == null ) {
			return Common.login.VIEW_PATH + "need_login.jsp";
		}
		
		if( o_deliver == null ) {
			o_deliver = 99;
		}
		
		if( mode == null ) {
			mode = "buy";
		}
		
		if ( start_date == null || end_date == null ) {
			
			Date date = new Date();
			SimpleDateFormat date_cal = new SimpleDateFormat("yyyy-MM-dd");
			
			Calendar cal = Calendar.getInstance();
			
			cal.setTime(date);
			cal.add(Calendar.MONTH, -3);
			
			start_date = date_cal.format(cal.getTime());
			end_date = date_cal.format(date);
			
		}
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("mode", mode);
		map.put("o_deliver", o_deliver);
		map.put("start_date", start_date);
		map.put("end_date", end_date);
		map.put("id", vo.getId());
		
		int nowPage = 1;
		
		if( page != null ) {
			nowPage = page;
		}
		
		int start = (nowPage -1) * Common.product_page.BLOCKLIST;
		int end = start + Common.product_page.BLOCKLIST;
		
		map.put("start", start);
		map.put("end", end);
		
		List<OrderVO> list = null;
		
		list = payment_dao.select_order(map);
		
		int row_total = payment_dao.getRowTotal_order(map);
		
		map.remove("id");
		
		String pageMenu = Paging.getPaging(
				"order_list.do", nowPage, row_total, Common.product_page.BLOCKLIST, Common.product_page.BLOCKPAGE, 0, "", "", "", "", mode, o_deliver, start_date, end_date);
		
		model.addAttribute("list", list);
		model.addAttribute("pageMenu", pageMenu);
		model.addAttribute("map", map);
		
		return Common.user.VIEW_PATH + "order_list.jsp";
	}
	
	//결제취소
	@RequestMapping("cancel_order.do")
	@ResponseBody
	public String cancel_order( long o_no ) {
		
		String res = "fail";
		
		PaymentVO pay_vo = payment_dao.recent_order(o_no);
		
		switch (pay_vo.getO_deliver()) {
			case 0:
				res = "accept";
				break;
			case 1:
				res = "accept";
				break;
			case 2:
				res = "deliverying";
				break;
			case 3:
				res = "done";
				break;
			case 4:
				res = "cancel";
				break;
			case 5:
				res = "trade";
				break;
			case 6:
				res = "return";
				break;
		}
		
		if( res.equals("accept") ) {
			
			if( pay_vo.getO_pg().equals("kcp") ) {
				String no = Long.toString(o_no);
				
				try {
					CancelData cancel_data = new CancelData(no, false);
					
					cancel_data.setReason("고객 결제 취소");
					
					IamportResponse<Payment> cancel = client.cancelPaymentByImpUid(cancel_data);
					
					System.out.println(cancel.getResponse().getStatus());
				} catch (IamportResponseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				
			}
			
			int result = payment_dao.cancel_order(o_no);
			
			if( result > 0 ) {
				res = "success";
				return res;
			}
			
		}

		return res;
	}
	
	//=============================================================
	
	//=========================Admin 컨트롤러=========================

	//관리자 페이지 이동
	@RequestMapping("admin_main.do")
	public String admin_main(Integer page, Integer order, Model model) {
		
		UserVO ad_vo = (UserVO)session.getAttribute("user");
		if(ad_vo==null || !ad_vo.getId().equals("admin")) {
			return Common.main.VIEW_PATH + "wrong_access.jsp";
		}
		
		int nowPage = 1;
		
		if( page != null ) {
			nowPage = page;
		}
		if( order == null ) {
			order = 1;
		}
		
		int start = (nowPage -1) * Common.product_page.BLOCKLIST;
		int end = start + Common.product_page.BLOCKLIST;
		
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("start", start);
		map.put("end", end);
		
		List<ProductVO> list = null;
		list = product_dao.selectList(map, order);	
		
		int row_total = product_dao.getRowTotal();
		
		//페이지 메뉴 생성
		String pageMenu = Paging.getPaging(
				"admin_main.do", nowPage, row_total, Common.product_page.BLOCKLIST, Common.product_page.BLOCKPAGE, order, "", "", "", "", "", 10, "", "");
		
		model.addAttribute("list", list);
		model.addAttribute("pageMenu", pageMenu);
		
		return Common.admin.VIEW_PATH + "admin_main.jsp";
	}

	//상품등록 폼으로 이동
	@RequestMapping("add_product.do")
	public String add_product() {
		UserVO ad_vo = (UserVO)session.getAttribute("user");
		if(ad_vo==null || !ad_vo.getId().equals("admin")) {
			return Common.main.VIEW_PATH + "wrong_access.jsp";
		}
		return Common.admin.VIEW_PATH + "add_product.jsp";
	}

	//상품DB등록
	@RequestMapping("regi_product.do")
	public String regi_product( ProductVO vo, Model model ) {
		UserVO ad_vo = (UserVO)session.getAttribute("user");
		if(ad_vo==null || !ad_vo.getId().equals("admin")) {
			return Common.main.VIEW_PATH + "wrong_access.jsp";
		}
		String webPath = "/resources/p_img/";
		String savePath = application.getRealPath(webPath);
		System.out.println(savePath);

		for( int i = 0; i < vo.getImg().size(); i++ ) {

			// 사용자가 업로드 한 파일 정보
			MultipartFile photo = vo.getImg().get(i);

			String filename = "no_file";

			if (!photo.isEmpty()) {
				// 업로드 된 실제 파일명
				filename = photo.getOriginalFilename();

				// 저장할 파일의 경로
				File saveFile = new File(savePath, filename);
				if (!saveFile.exists()) {
					// 저장할 경로가 존재하지 않는다면 새로운 폴더를 생성
					saveFile.mkdirs();
				} else {
					// 동일파일명을 방지하기 위해 현재 업로드 시간을 붙여서 중복을 방지한다.
					long time = System.currentTimeMillis();
					filename = String.format("%d_%s", time, filename);
					saveFile = new File(savePath, filename);
				}

				try {
					// 업로드를 요청받은 파일은 MultipartResolver클래스가
					// 지정한 임시 저장소에 있는데 임시저장소에 있는 파일은 일정 시간이 지나면 사라지므로
					// 내가 지정해놓은 경로로 복사를 해준다.
					photo.transferTo(saveFile);
				} catch (Exception e) {
					e.printStackTrace();
				}

			}

			if( i == 0 ) {
				vo.setP_img(filename);
			}else if( i == 1 ) {
				vo.setP_content_img(filename);
			}

		}//for()

		Map<String, String> map = new HashMap<String, String>();
		map.put("p_type", vo.getP_type());
		map.put("p_brand", vo.getP_brand());

		product_dao.regi_product(vo, map);

		return "redirect:admin_main.do";
	}

	//상품 수정폼으로 이동
	@RequestMapping("admin_modify.do")
	public String admin_modify(int p_idx, Model model){
		UserVO ad_vo = (UserVO)session.getAttribute("user");
		if(ad_vo==null || !ad_vo.getId().equals("admin")) {
			return Common.main.VIEW_PATH + "wrong_access.jsp";
		}
		ProductVO vo = product_dao.oneVO(p_idx);
		model.addAttribute("vo",vo); 

		return Common.admin.VIEW_PATH + "modify_product.jsp";
	}

	//상품 수정
	@RequestMapping("modify_product.do")
	public String after_product(ProductVO vo, String old_img1, String old_img2, Model model) {
		UserVO ad_vo = (UserVO)session.getAttribute("user");
		if(ad_vo==null || !ad_vo.getId().equals("admin")) {
			return Common.main.VIEW_PATH + "wrong_access.jsp";
		}
		String webPath = "/resources/p_img/";
		String savePath = application.getRealPath(webPath);
		System.out.println(savePath);

		for (int i = 0; i < vo.getImg().size(); i++) {

			// 사용자가 업로드 한 파일 정보 
			MultipartFile photo = vo.getImg().get(i);

			String filename = "no_file";

			if( !vo.getImg().get(i).isEmpty() ) {

				if( i == 0 ) {
					File file = new File(savePath, old_img1);
					file.delete();
				} else if( i == 1 ) {
					File file = new File(savePath, old_img2);
					file.delete();
				}
				
				if (!photo.isEmpty()) {
					// 업로드 된 실제 파일명
					filename = photo.getOriginalFilename();

					// 저장할 파일의 경로
					File saveFile = new File(savePath, filename);
					if (!saveFile.exists()) {
						// 저장할 경로가 존재하지 않는다면 새로운 폴더를 생성
						saveFile.mkdirs();
					} else {
						// 동일파일명을 방지하기 위해 현재 업로드 시간을 붙여서 중복을 방지한다.
						long time = System.currentTimeMillis();
						filename = String.format("%d_%s", time, filename);
						saveFile = new File(savePath, filename);
					}

					try {
						// 업로드를 요청받은 파일은 MultipartResolver클래스가
						// 지정한 임시 저장소에 있는데 임시저장소에 있는 파일은 일정 시간이 지나면 사라지므로
						// 내가 지정해놓은 경로로 복사를 해준다.
						photo.transferTo(saveFile);
					} catch (Exception e) {
						e.printStackTrace();
					}

				}

				if (i == 0) {
					vo.setP_img(filename);
					System.out.println("1번이미지 변경 : " + filename);
				} else if (i == 1) {
					vo.setP_content_img(filename);
					System.out.println("2번이미지 변경 : " + filename);
				}
				//!isEmpty if()
			} else if( vo.getImg().get(i).isEmpty() ) {

				if (i == 0) {
					System.out.println("1번 기본이미지 유지 설정");
					vo.setP_img(old_img1);
				} else if (i == 1) {
					System.out.println("2번 기본이미지 유지 설정");
					vo.setP_content_img(old_img2);
				}

			}//isEmpty if()

		} //for()

		Map<String, String> map = new HashMap<String, String>();
		map.put("p_type", vo.getP_type());
		map.put("p_brand", vo.getP_brand());

		product_dao.modify_product(vo, map);

		return "redirect:admin_main.do";
	}

	//상품 삭제
	@ResponseBody
	@RequestMapping("admin_del.do")   
	public String admin_del(int p_idx, Model model) {
		UserVO ad_vo = (UserVO)session.getAttribute("user");
		if(ad_vo==null || !ad_vo.getId().equals("admin")) {
			return Common.main.VIEW_PATH + "wrong_access.jsp";
		}
		String result = "fail";
		String webPath = "/resources/p_img/";
		String savePath = application.getRealPath(webPath);

		ProductVO vo = product_dao.oneVO(p_idx);

		File file = new File(savePath, vo.getP_img());
		file.delete();

		File file2 = new File(savePath, vo.getP_content_img());
		file2.delete();

		Map<String, String> map = new HashMap<String, String>();
		map.put("p_type", vo.getP_type());
		map.put("p_brand", vo.getP_brand());

		int res = product_dao.del_product(p_idx, map);

		if( res == 1 ) {
			result = "success";
		}

		return result;
	}

	// 관리자 페이지 검색상품 뿌려주기
	@RequestMapping("admin_searching.do")
	public String admin_searching(String how, String what, Integer page, Integer order, Model model) {
		UserVO ad_vo = (UserVO)session.getAttribute("user");
		if(ad_vo==null || !ad_vo.getId().equals("admin")) {
			return Common.main.VIEW_PATH + "wrong_access.jsp";
		}
		
		int nowPage = 1;
		
		if( page != null ) {
			nowPage = page;
		}
		if( order == null ) {
			order = 1;
		}
		
		int start = (nowPage -1) * Common.product_page.BLOCKLIST;
		int end = start + Common.product_page.BLOCKLIST;
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("how", how);
		map.put("what", what);
		map.put("start", start);
		map.put("end", end);
		
		List<ProductVO> list = null;
		list = product_dao.admin_searching(map);
		
		int row_total = product_dao.getRowTotal_search_admin(map);
		
		//페이지 메뉴 생성
		String pageMenu = Paging.getPaging(
				"admin_searching.do", nowPage, row_total, Common.product_page.BLOCKLIST, Common.product_page.BLOCKPAGE, order, "", "", what, how, "", 10, "", "");
		
		model.addAttribute("list", list);
		model.addAttribute("pageMenu", pageMenu);
		
		return Common.admin.VIEW_PATH + "admin_main.jsp";
	}
	
	//==============================================================

}