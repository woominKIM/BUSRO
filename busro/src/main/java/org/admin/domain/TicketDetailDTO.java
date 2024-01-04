package org.admin.domain;

import java.time.LocalDateTime;

import org.busro.domain.MemberVO;
import org.busro.service.CommonScheduleService;
import org.busro.service.MemberService;

import lombok.Data;

@Data
public class TicketDetailDTO{
	//기존 ticketVO 정보
	private Long mnum; //관리번호
	private String rno; //예매번호
	private String id; //예매한 아이디
	private LocalDateTime tdate; //예매일
	private LocalDateTime ddate; //출발일
	private String seatnum; //예약한 좌석
	
	//Schedule테이블에서 가져옴
	private String departure;//출발지
	private String arrival;//도착지
	private String st; // 출발시각
	
	//ticket테이블의 pType과 Schedule테이블의 price를 가져와 실 결제금액 산출
	private int realprice;
	
	//Member테이블에서 가져옴
	private String name; //예매한 이름
	private String tel; //전화번호
	
	public TicketDetailDTO(TicketVO tVO,CommonScheduleService sService, MemberService mService) throws Exception {
		ScheduleVO sVO = sService.readBySnum(tVO.getSnum().intValue());
		MemberVO mVO =  mService.searchId(tVO.getId());
		this.mnum = tVO.getMnum();
		this.rno = tVO.getRno();
		this.id = tVO.getId();
		this.tdate = tVO.getTdate();
		this.ddate = tVO.getDdate();
		this.seatnum = tVO.getSeatnum();
		
		this.departure = sVO.getDeparture();
		this.arrival = sVO.getArrival();
		this.st = sVO.getSt();
		this.name = mVO.getName();
		this.tel = mVO.getTel();
		
		switch(tVO.getPtype()){
			//어른
			case 'A':
				this.realprice = sVO.getPrice().intValue();
				break;
			//청소년
			case 'T':
				this.realprice = (int)(sVO.getPrice().intValue()*0.9f);
				break;
			//아동
			case 'K':
				this.realprice = (int)(sVO.getPrice().intValue()*0.7f);
				break;
			//장애
			case 'D':
				this.realprice = sVO.getPrice().intValue();
				break;
			default:
				this.realprice = sVO.getPrice().intValue();
				break;
		}
	}
}
