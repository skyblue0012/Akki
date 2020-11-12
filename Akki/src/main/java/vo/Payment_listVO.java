package vo;

public class Payment_listVO {
	
	private int od_idx;
	private long o_no;
	private int p_idx;
	private int amount;
	private int p_price;
	private String p_name;
	private String p_img;
	
	public int getOd_idx() {
		return od_idx;
	}
	public void setOd_idx(int od_idx) {
		this.od_idx = od_idx;
	}
	public long getO_no() {
		return o_no;
	}
	public void setO_no(long o_no) {
		this.o_no = o_no;
	}
	public int getP_idx() {
		return p_idx;
	}
	public void setP_idx(int p_idx) {
		this.p_idx = p_idx;
	}
	public int getAmount() {
		return amount;
	}
	public void setAmount(int amount) {
		this.amount = amount;
	}
	public int getP_price() {
		return p_price;
	}
	public void setP_price(int p_price) {
		this.p_price = p_price;
	}
	public String getP_name() {
		return p_name;
	}
	public void setP_name(String p_name) {
		this.p_name = p_name;
	}
	public String getP_img() {
		return p_img;
	}
	public void setP_img(String p_img) {
		this.p_img = p_img;
	}
	
}
