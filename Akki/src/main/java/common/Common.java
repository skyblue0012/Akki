package common;

public class Common {
	
	public static class main{ //main 경로
		public static final String VIEW_PATH = "/WEB-INF/views/main/";
	}
	
	public static class admin{ //admin 경로
		public static final String VIEW_PATH = "/WEB-INF/views/admin/";
	}
	
	public static class product{ //product 경로
		public static final String VIEW_PATH = "/WEB-INF/views/product/";
	}
	
	public static class login{ //login 경로
		public static final String VIEW_PATH = "/WEB-INF/views/login/";
	}
	
	public static class policy{ //policy 경로
		public static final String VIEW_PATH = "/WEB-INF/views/policy/";
	}
	
	public static class user{ //user 경로
		public static final String VIEW_PATH = "/WEB-INF/views/user/";
	}
	
	public static class product_page{
		
		//한 페이지당 보여줄 게시물 수
		public final static int BLOCKLIST = 20;
		
		//한 화면에 보여지는 페이지 메뉴 수
		//ㄴ ◀ 1 2 3 4 5 ▶
		public final static int BLOCKPAGE = 5;
		
	}
	
}
