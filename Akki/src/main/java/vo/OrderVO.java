package vo;

public class OrderVO {
	
	private int o_idx;
	private long o_no;
	private String o_date;
	private String p_img;
	private String p_name;
	private int amount;
	private int p_price;
	private int o_deliver;
	private String o_status;
	
	public int getO_idx() {
		return o_idx;
	}
	public void setO_idx(int o_idx) {
		this.o_idx = o_idx;
	}
	public long getO_no() {
		return o_no;
	}
	public void setO_no(long o_no) {
		this.o_no = o_no;
	}
	public String getO_date() {
		return o_date;
	}
	public void setO_date(String o_date) {
		this.o_date = o_date.substring(0, 19);
	}
	public String getP_img() {
		return p_img;
	}
	public void setP_img(String p_img) {
		this.p_img = p_img;
	}
	public String getP_name() {
		return p_name;
	}
	public void setP_name(String p_name) {
		this.p_name = p_name;
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
	public int getO_deliver() {
		return o_deliver;
	}
	public void setO_deliver(int o_deliver) {
		this.o_deliver = o_deliver;
	}
	public String getO_status() {
		return o_status;
	}
	public void setO_status(String o_status) {
		this.o_status = o_status;
	}
	
}
