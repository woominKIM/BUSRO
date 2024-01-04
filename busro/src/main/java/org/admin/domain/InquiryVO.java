package org.admin.domain;

import java.util.Date;

import org.busro.domain.MemberVO;

import lombok.Data;

@Data
public class InquiryVO { 
	
	private int ino;
	private String writer;
	private String title;
	private String content;
	private Date regdate;
	private String category;
	private MemberVO memberVO;
	private AnswerVO answerVO;
	private Criteria cri;
	private String ano;
	private String name;
	private int tf;
	
	//private int ancnt; //답변 유무에 따른 상태용
	
	
	  //public InquiryVO() {
	 
	  //Criteria cri = new Criteria(); this.cri = cri; }
	 //다른 객체(클래스)를 가져오면 새로 세팅을 해줘야 쓸 수 있음. 아니면 서비스나 컨트롤러에서 set해줘야 함
	
	 
	
	
	
	
	
	
	
	
	
	
	

}
