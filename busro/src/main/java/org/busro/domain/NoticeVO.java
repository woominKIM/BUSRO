package org.busro.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class NoticeVO {
	
	private Long nno;
	private String writer;
	private String title;
	private String content;
	private Date regdate;
	private String top;
	private Criteria cri;
	
	private List<NoticeAttachVO> attachList;
	

}
