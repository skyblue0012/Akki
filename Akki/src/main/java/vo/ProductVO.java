package vo;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

public class ProductVO {
   
	private int p_idx;				//p_idx
	private String p_type;			//종류
	private String p_brand;			//제조사
	private String p_name;			//이름(모델명)
	private int p_price;			//판매가
	private String p_img;			//상품이미지(소) 정사각형
	private String p_content;		//상품상세설명
	private String p_content_img;	//상품상세설명 이미지(대)
	private String p_origin;		//원산지
	private String p_content_s;		//상품간략설명(기타 바디타입등등)
	private int p_pop;				//인기상품 여부
	private String p_date;			//상품등록일
	private List<MultipartFile> img;
	
	public int getP_idx() {
		return p_idx;
	}
	public void setP_idx(int p_idx) {
		this.p_idx = p_idx;
	}
	public String getP_type() {
		return p_type;
	}
	public void setP_type(String p_type) {
		this.p_type = p_type;
	}
	public String getP_brand() {
		return p_brand;
	}
	public void setP_brand(String p_brand) {
		this.p_brand = p_brand;
	}
	public String getP_name() {
		return p_name;
	}
	public void setP_name(String p_name) {
		this.p_name = p_name;
	}
	public int getP_price() {
		return p_price;
	}
	public void setP_price(int p_price) {
		this.p_price = p_price;
	}
	public String getP_img() {
		return p_img;
	}
	public void setP_img(String p_img) {
		this.p_img = p_img;
	}
	public String getP_content() {
		return p_content;
	}
	public void setP_content(String p_content) {
		this.p_content = p_content;
	}
	public String getP_content_img() {
		return p_content_img;
	}
	public void setP_content_img(String p_content_img) {
		this.p_content_img = p_content_img;
	}
	public String getP_origin() {
		return p_origin;
	}
	public void setP_origin(String p_origin) {
		this.p_origin = p_origin;
	}
	public String getP_content_s() {
		return p_content_s;
	}
	public void setP_content_s(String p_content_s) {
		this.p_content_s = p_content_s;
	}
	public int getP_pop() {
		return p_pop;
	}
	public void setP_pop(int p_pop) {
		this.p_pop = p_pop;
	}
	public String getP_date() {
		return p_date;
	}
	public void setP_date(String p_date) {
		this.p_date = p_date;
	}
	public List<MultipartFile> getImg() {
		return img;
	}
	public void setImg(List<MultipartFile> img) {
		this.img = img;
	}
	
}