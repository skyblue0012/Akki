package dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import vo.CategoryVO;
import vo.ProductVO;

public class ProductDAO {
	
	SqlSession sqlSession;
	
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	//상품하나 가져오기
	public ProductVO oneVO(int p_idx) {
		
		ProductVO vo = sqlSession.selectOne("pro.one_vo", p_idx);

		return vo;
	}
	
	//카테고리 목록
	public List<CategoryVO> category() {
		
		List<CategoryVO> list = sqlSession.selectList("cate.category");
		
		return list;
	}
	
	//카테고리 상품 개수
	public int product_cnt_all( String p_type ) {
		
		int p_cnt = sqlSession.selectOne("pro.product_count_all", p_type);
		
		return p_cnt;
	}
	
	//브랜드별 상품 개수
	public int product_cnt( String p_type, String p_brand ) {
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("p_type", p_type);
		map.put("p_brand", p_brand);
		
		int p_cnt = sqlSession.selectOne("pro.product_count", map);
		
		return p_cnt;
	}
	
	//카테고리 전체상품 목록
	public List<ProductVO> product_category_all( Map<String, Object> map, int order ) {
		
		List<ProductVO> list = null;
		
		switch (order) {
			case 1:
				list = sqlSession.selectList("pro.product_category_condition_1",map);
				break;
			
			case 2:
				list = sqlSession.selectList("pro.product_category_condition_2",map);
				break;
			
			case 3:
				list = sqlSession.selectList("pro.product_category_condition_3",map);
				break;
			
			case 4:
				list = sqlSession.selectList("pro.product_category_condition_4",map);
				break;
		}
		
		return list;
	}
	
	//카테고리 상품목록
	public List<ProductVO> product_category( Map<String, Object> map, int order ) {
		
		List<ProductVO> list = null;
		
		switch (order) {
			case 1:
				list = sqlSession.selectList("pro.product_category_condition_1",map);
				break;
			
			case 2:
				list = sqlSession.selectList("pro.product_category_condition_2",map);
				break;
			
			case 3:
				list = sqlSession.selectList("pro.product_category_condition_3",map);
				break;
			
			case 4:
				list = sqlSession.selectList("pro.product_category_condition_4",map);
				break;
		}
		
		return list;
	}
	
	//유저 상품 검색
	public List<ProductVO> user_searching( Map<String, Object> map, int order ){
		
		List<ProductVO> list = null;
		
		list = sqlSession.selectList("pro.all_search", map);
		
		return list;
	}
	
	//검색 상품 개수 구하기
	public int getRowTotal_search( String what ) {
		
		int count = sqlSession.selectOne("pro.product_search_list", what);

		return count;

	}
	
	//페이징을 포함한 조건별 검색
	public List<ProductVO> selectList( Map<String, Integer> map, int order ){
		
		List<ProductVO> list = null;
		
		switch (order) {
			case 1:
				list = sqlSession.selectList("pro.product_list_condition_1",map);
				break;
			
			case 2:
				list = sqlSession.selectList("pro.product_list_condition_2",map);
				break;
			
			case 3:
				list = sqlSession.selectList("pro.product_list_condition_3",map);
				break;
			
			case 4:
				list = sqlSession.selectList("pro.product_list_condition_4",map);
				break;
		}
		
		return list;

	}
	
	//전체 게시물 개수 구하기
	public int getRowTotal() {

		int count = sqlSession.selectOne("pro.product_count_list");
		
		return count;

	}
	
	//=========================Admin DAO=========================
	
	//상품등록
	public int regi_product( ProductVO vo, Map<String, String> map ) {
		
		if( vo.getP_content().length() == 0 || vo.getP_content() == "" || vo.getP_content() == null || vo.getP_content().trim().length() == 0 ){
			vo.setP_content("");
		}
		
		//카테고리 중복여부 체크
		CategoryVO check = sqlSession.selectOne("cate.check_category", map);
		
		//중복 없으면 카테고리 추가
		if( check == null ) {
			sqlSession.insert("cate.regi_category", map);
		}
		
		int res = sqlSession.insert("pro.regi_product", vo);
		
		return res;
	}
	
	//상품 수정하기
	public void modify_product(ProductVO vo, Map<String, String> map) {
		
		if( vo.getP_content().length() == 0 || vo.getP_content() == "" || vo.getP_content() == null || vo.getP_content().trim().length() == 0 ){
			vo.setP_content("");
		}
		
		//카테고리 중복여부 체크
		CategoryVO check = sqlSession.selectOne("cate.check_category", map);
		
		//중복 없으면 카테고리 추가
		if( check == null ) {
			sqlSession.insert("cate.regi_category", map);
		}
		
		ProductVO old_vo = sqlSession.selectOne("pro.one_vo", vo.getP_idx());
		
		sqlSession.update("pro.modify_product",vo);
		
		Map<String, String> old_map = new HashMap<String, String>();
		old_map.put("p_type", old_vo.getP_type());
		old_map.put("p_brand", old_vo.getP_brand());
		
		List<ProductVO> check2 = sqlSession.selectList("pro.product_cate_check", old_map);
		
		//카테고리 관련된 상품이 없을시 카테고리 삭제
		if( check2 == null ) {
			sqlSession.delete("cate.del_category", old_map);
		}
		
		return;
	}
	
	//상품 삭제하기
	public int del_product(int p_idx, Map<String, String> map) {
		
		int res = sqlSession.delete("pro.del",p_idx);
		
		ProductVO check = sqlSession.selectOne("pro.product_cate_check", map);
		
		//카테고리 관련된 상품이 없을시 카테고리 삭제
		if( check == null ) {
			sqlSession.delete("cate.del_category", map);
		}
		
		return res;
	}

	//관리자전용 검색하기
	public List<ProductVO> admin_searching( Map<String, Object> map ){
		
		List<ProductVO> list = null;
		
		String what = (String) map.get("what");
		String how = (String) map.get("how");
		
		if(what.contains("*")) {
			list = sqlSession.selectList("pro.product_list");
			return list;
		}else if(how.contains("*")) { 
			list = sqlSession.selectList("pro.all_search",map);
			return list; 
		}
		list = sqlSession.selectList("pro.choose_search",map);
		return list; 
	}
	
	//관리자 검색 상품 개수 구하기
	public int getRowTotal_search_admin( Map<String, Object> map ) {

		String what = (String) map.get("what");
		String how = (String) map.get("how");
		
		if(what.contains("*")) {
			int count = sqlSession.selectOne("pro.product_count_list");
			return count;
		}else if(how.contains("*")) {
			int count = sqlSession.selectOne("pro.all_search_count",map);
			return count; 
		}
		int count = sqlSession.selectOne("pro.choose_search_count",map);
		
		return count;

	}
	
}
