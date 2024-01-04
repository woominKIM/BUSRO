package org.admin.domain;

import org.busro.domain.MemberVO;
import org.springframework.web.util.UriComponentsBuilder;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Criteria {
	
	private int pageNum;	//현재 페이지
	private int amount;		//한 페이지의 게시물 수
	
	private String type;
	private String keyword;
	
	private MemberVO memberVO;
	
	//검색 조건 type 지정을 위해 scheduleVO와 같은 컬럼 선언해줌
	private String grade;	//버스등급
	private String departure;
	private String arrival;
	private String st; //출발시간 
	
	
	public Criteria() {
		this(1,10);
	}

	public Criteria(int pageNum, int amount) {
		this.pageNum = pageNum;
		this.amount = amount;
		

	}
	

	public String[] getTypeArr() {
		
		return type == null? new String[] {}: type.split("");
	}

	
	public String getListLink() { //게시물 삭제 후 페이지 번호 or 검색 조건 유지
		
		UriComponentsBuilder builder = UriComponentsBuilder.fromPath("")
			.queryParam("pageNum", this.pageNum)
			.queryParam("amount", this.getAmount())
			.queryParam("type", this.getType())
			.queryParam("keyword", this.getKeyword());
		
		return builder.toUriString();
		
	}
	
}
