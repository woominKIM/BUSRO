package org.admin.domain;

import java.util.Date;

import lombok.Data;

@Data
public class AnswerVO {

	private int ano;	//답변용 관리번호
	private int ino;	//참조할 문의용 관리번호
	private String writer;	//작성자(관리자)
	private String content;
	private Date regdate;
	//private int ancnt; //답변 유무에 따른 상태용
	
}
