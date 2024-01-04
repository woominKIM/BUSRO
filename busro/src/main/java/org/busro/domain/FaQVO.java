package org.busro.domain;

import lombok.Data;

@Data
public class FaQVO {
	
	private Long fno;
	private String writer;
	private String question;
	private String answer;
	private String regdate;
	private String category;
	


}
