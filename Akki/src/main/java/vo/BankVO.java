package vo;

public class BankVO {
	
	private int bk_idx;
	private long o_no;			//주문번호
	private String b_name;		//입금자이름
	private String b_account;	//입금계좌
	private int b_status;		//입금여부 0(입금취소), 1(입금대기), 2(입금완료)
	
	public int getBk_idx() {
		return bk_idx;
	}
	public void setBk_idx(int bk_idx) {
		this.bk_idx = bk_idx;
	}
	public long getO_no() {
		return o_no;
	}
	public void setO_no(long o_no) {
		this.o_no = o_no;
	}
	public String getB_name() {
		return b_name;
	}
	public void setB_name(String b_name) {
		this.b_name = b_name;
	}
	public String getB_account() {
		return b_account;
	}
	public void setB_account(String b_account) {
		this.b_account = b_account;
	}
	public int getB_status() {
		return b_status;
	}
	public void setB_status(int b_status) {
		this.b_status = b_status;
	}
	
}
