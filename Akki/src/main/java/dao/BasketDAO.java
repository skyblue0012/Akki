package dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import vo.Add_basketVO;
import vo.BasketVO;

public class BasketDAO {
	
	SqlSession sqlSession;

	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	//장바구니 전체목록 불러오기
	public List<BasketVO> selectList( String id ) {
		
		List<BasketVO> list = sqlSession.selectList("b.basket_list", id);
		
		return list;
	}
	
	//장바구니 추가
	public int add_basket( Add_basketVO add_vo ) {
		
		Add_basketVO check_vo = sqlSession.selectOne("b.check_basket", add_vo);
		int res = 0;
		
		if( check_vo != null ) {
			res = 999;
		} else if( check_vo == null ) {
			res = sqlSession.insert("b.add_basket", add_vo);
		}
		
		return res;
	}
	
	//장바구니 삭제
	public int del_basket( int b_idx, String id ) {
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("b_idx", b_idx);
		map.put("id", id);
			
		int res = sqlSession.delete("b.delete_basket", map);
		
		return res;
	}
	
	//장바구니 선택삭제
	public int del_basket_sel( int b_idx[], String id ) {
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		int result = 0;
		
		for( int i = 0; i < b_idx.length; i++ ) {

			map.put("b_idx", b_idx[i]);
			map.put("id", id);
			
			int res = sqlSession.delete("b.delete_basket", map);
			
			if( res > 0 ) {
				result++;
			}
			
		}
		
		return result;
	}
	
}
