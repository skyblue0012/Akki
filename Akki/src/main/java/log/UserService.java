package log;

import javax.servlet.http.HttpSession;

import vo.UserVO;

public interface UserService {
	
	//로그인 체크
	public boolean loginCheck(UserVO vo, HttpSession session);
	
	//로그아웃
	public void logOut(HttpSession session);

}
