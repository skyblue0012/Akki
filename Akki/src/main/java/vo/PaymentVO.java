package vo;

import java.math.BigDecimal;
import java.util.List;

public class PaymentVO {
	
	private BigDecimal total_price;		//예정결제금액
	private List<Integer> p_idx;		//구매한 상품 idx
	private List<BigDecimal> p_amount;	//구매한 상품 개수
	private int o_idx;					//idx
	private long o_no;					//주문번호
    private String o_pg;				//pg사
    private String o_id;				//구매자 id
    private String o_pay;				//결제방법
    private String o_status;			//결제상태
	private int o_price;				//실제결제금액
	private int o_deliver;				//배송상태  0(입금대기), 1(배송준비중), 2(배송중), 3(배송완료), 4(결제취소), 5(교환), 6(반품)
	private int o_dnumber;				//운송장번호
	private String o_date;				//결제날짜시간
	
	public BigDecimal getTotal_price() {
		return total_price;
	}
	public void setTotal_price(BigDecimal total_price) {
		this.total_price = total_price;
	}
	public List<Integer> getP_idx() {
		return p_idx;
	}
	public void setP_idx(List<Integer> p_idx) {
		this.p_idx = p_idx;
	}
	public List<BigDecimal> getP_amount() {
		return p_amount;
	}
	public void setP_amount(List<BigDecimal> p_amount) {
		this.p_amount = p_amount;
	}
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
	public String getO_pg() {
		return o_pg;
	}
	public void setO_pg(String o_pg) {
		this.o_pg = o_pg;
	}
	public String getO_id() {
		return o_id;
	}
	public void setO_id(String o_id) {
		this.o_id = o_id;
	}
	public String getO_pay() {
		return o_pay;
	}
	public void setO_pay(String o_pay) {
		this.o_pay = o_pay;
	}
	public String getO_status() {
		return o_status;
	}
	public void setO_status(String o_status) {
		this.o_status = o_status;
	}
	public int getO_price() {
		return o_price;
	}
	public void setO_price(int o_price) {
		this.o_price = o_price;
	}
	public int getO_deliver() {
		return o_deliver;
	}
	public void setO_deliver(int o_deliver) {
		this.o_deliver = o_deliver;
	}
	public int getO_dnumber() {
		return o_dnumber;
	}
	public void setO_dnumber(int o_dnumber) {
		this.o_dnumber = o_dnumber;
	}
	public String getO_date() {
		return o_date;
	}
	public void setO_date(String o_date) {
		this.o_date = o_date;
	}
	
}
