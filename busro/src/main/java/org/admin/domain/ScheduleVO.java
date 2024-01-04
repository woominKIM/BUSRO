package org.admin.domain;

import lombok.Data;

@Data
public class ScheduleVO {
	
	private Long snum;	//스케줄번호(pk)
	private String grade;	//버스등급
	private String departure;
	private String arrival;
	private String workday; //운영요일
	private String st; //운영요일
	private String sth;	//출발시
	private String stm;	//출발분
	private Long eta;	//소요시간
	private Long price; //요금
	
	

}
