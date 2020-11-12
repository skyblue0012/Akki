package dao;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import vo.UserVO;

public class UserDAO {
	
	SqlSession sqlSession;

	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	// 아이디 중복체크
	public int check_id(String id) {   
		int res = sqlSession.selectOne("u.check_id",id);
		return res;
	}

	//회원가입
	public int regi(UserVO vo) {
		int res = sqlSession.insert("u.regi",vo);
		return res;
	}
	
	//회원 정보 체크
	public UserVO check_vo(String id, String pwd) {
		
		Map<String, String> map = new HashMap<String, String>();
		
		map.put("id", id);
		map.put("pwd", pwd);
		
		UserVO vo = sqlSession.selectOne("u.check_vo",map);
		
		return vo;
	}
	
	//비밀번호 변경
	public void change_pwd(String id, String pwd) {
		
		Map<String, String> map = new HashMap<String, String>();
		
		map.put("id", id);
		map.put("pwd", pwd);
		
		sqlSession.update("u.change_pwd", map);
		
		return;
	}
	
	//로그인 체크
	public UserVO loginCheck(UserVO vo) {
		UserVO user = sqlSession.selectOne("u.check_login",vo);
		return user;
	}
	
	//회원정보 수정
	public int modify_user(String id, String email, String tel, String addr_1, String addr_2) {
		
		Map<String, String> map = new HashMap<String, String>();
		
		map.put("id", id);
		map.put("email", email);
		map.put("tel", tel);
		map.put("addr_1", addr_1);
		map.put("addr_2", addr_2);
		
		int res = sqlSession.update("u.change_info", map);
		return res;
	}
	
	//아이디 찾기
	public String checking_id(String name, String email, String tel) {
		
		String str = "";
		Map<String, String> map = new HashMap<String, String>();
		
		if(tel.equals("no")) {
			map.put("name", name);
			map.put("email", email);
			str = sqlSession.selectOne("u.check_email_id", map);
			if(str == null) {
				str = "no";
			}
			return str;
		}else {
			map.put("name", name);
			map.put("tel", tel);
			str = sqlSession.selectOne("u.check_tel_id", map);	
			if(str == null) {
				str = "no";
			}
			return str;
		}
	}
			
	//비밀번호 찾기
	public String checking_pwd(String id ,String name, String email, String tel) {
				
		String restr = "no";
		Map<String, String> map = new HashMap<String, String>();
		
		if(tel.equals("no")) {
			map.put("id", id);
			map.put("name", name);
			map.put("email", email);
			String pwd = sqlSession.selectOne("u.check_email_pwd", map);
			if(pwd == null)
				restr = "no";
		}else{
			map.put("id", id);
			map.put("name", name);
			map.put("tel", tel);
			String pwd  = sqlSession.selectOne("u.check_tel_pwd", map);	
			if(pwd == null)
				restr = "no";
		}
		
		return restr;
	}
	
}