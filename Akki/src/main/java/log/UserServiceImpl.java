package log;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import dao.UserDAO;
import vo.UserVO;

public class UserServiceImpl implements UserService{

	@Inject
	UserDAO user_dao;
	
	public void setUser_dao(UserDAO user_dao) {
		this.user_dao = user_dao;
	}
	
	@Override
	public boolean loginCheck(UserVO vo, HttpSession session) {
		
		boolean result = false;
		
		UserVO user = user_dao.loginCheck(vo);
		
		if(user != null) {
			result = true;
		}
		return result;
	}
	
	@Override
	public void logOut(HttpSession session) {
		session.invalidate();
	}
	
}
