package dao;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import vo.BankVO;
import vo.DeliveryVO;
import vo.OrderVO;
import vo.PaymentVO;
import vo.Payment_listVO;

public class PaymentDAO {
	
	SqlSession sqlSession;

	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	//구매금액 합계
	public BigDecimal getAmount( List<Integer> p_idx, List<BigDecimal> p_amount ) {
		
		BigDecimal amount = new BigDecimal(0);
		
		for ( int i = 0; i < p_idx.size(); i++ ) {
			BigDecimal amt = sqlSession.selectOne("pro.get_amount", p_idx.get(i));
			amt = amt.multiply(p_amount.get(i));
			amount = amount.add(amt);
		}
		
		return amount;
	}
	
	//결제관련DB 추가
	public int pay_complete(PaymentVO pay_vo) {
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		int res = sqlSession.insert("pay.add_order", pay_vo);
		
		for( int i = 0; i < pay_vo.getP_idx().size(); i++ ) {
			
			int p_price = sqlSession.selectOne("pay.get_price", pay_vo.getP_idx().get(i));
			
			map.put("o_no", pay_vo.getO_no());
			map.put("p_idx", pay_vo.getP_idx().get(i));
			map.put("amount", pay_vo.getP_amount().get(i));
			map.put("p_price", p_price);
			
			int ress = sqlSession.insert("pay.add_order_detail", map);
			
			if( ress == 0 ) {
				res = 0;
			}
			map.clear();
		}
		
		return res;
	}
	
	//배송정보 추가
	public int add_delivery( DeliveryVO d_vo ) {
		
		int res = sqlSession.insert("pay.add_delivery", d_vo);
		
		return res;
	}
	
	//무통장입금시 정보추가
	public int add_bank( BankVO bank_vo ) {
		
		int res = sqlSession.insert("pay.add_bank", bank_vo);
		
		return res;
	}
	
	//결제정보 및 배송정보 삭제
	public void del_pay_complete( long no ) {
		
		sqlSession.delete("pay.del_order", no);
		sqlSession.delete("pay.del_order_detail", no);
		sqlSession.delete("pay.del_delivery", no);
		
		return;
	}
	
	//무통장입금 정보 삭제
	public void del_bank( long no ) {
		
		sqlSession.delete("pay.del_bank", no);
		
		return;
	}

	//구매한 상품삭제
	public void del_complete_basket( List<Integer> p_idx, String id ) {
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		for( int i = 0; i < p_idx.size(); i++ ) {

			map.put("p_idx", p_idx.get(i));
			map.put("id", id);
			
			sqlSession.delete("b.del_complete_order", map);
			
		}
		
		return;
	}
	
	//주문완료한 정보 가져오기
	public PaymentVO recent_order( long no ) {
		
		PaymentVO pay_vo = sqlSession.selectOne("pay.recent_order", no);
		
		return pay_vo;
	}
	
	//주문완료한 상품정보 가져오기
	public List<Payment_listVO> recent_list( long no ) {
		
		List<Payment_listVO> pay_list = sqlSession.selectList("pay.recent_order_list", no);
		
		return pay_list;
	}
	
	//주문완료한 배송정보 가져오기
	public DeliveryVO recent_delivery( long no ) {
		
		DeliveryVO del_vo = sqlSession.selectOne("pay.recent_deliver", no);
		
		return del_vo;
	}
	
	//주문완료한 무통장입금정보 가져오기
	public BankVO recent_bank( long no ) {
		
		BankVO bank_vo = sqlSession.selectOne("pay.recent_bank", no);
		
		return bank_vo;
	}
	
	//주문조회 가져오기
	public List<OrderVO> select_order( Map<String, Object> map ) {
		
		List<OrderVO> list = sqlSession.selectList("pay.order_select", map);
		
		return list;
	}
	
	//총 주문개수 가져오기
	public int getRowTotal_order( Map<String, Object> map ) {
		
		int res = sqlSession.selectOne("pay.order_total", map);
		
		return res;
	}
	
	//주문취소
	public int cancel_order( long o_no ) {
		
		int res = sqlSession.update("pay.cancel_order", o_no);
		
		return res;
	}
	
}
