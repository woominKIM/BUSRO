package org.busro.domain;

import java.time.LocalDate;
import java.time.LocalDateTime;

import org.admin.domain.ScheduleVO;
import org.admin.domain.TicketVO;
import org.busro.service.CommonScheduleService;

import lombok.Data;

@Data
public class UserTicketDetailDTO{
	//기존 ticketVO 정보
	private Long snum; //스케줄번호
	private String rno; //예매번호(누적)
	private LocalDateTime tdate; //예매일
	private LocalDateTime ddate; //출발일
	private String seatnum; //예약한 좌석 (누적)
	private char pet; //반려동물 탑승여부 (누적, 단 하나라도 있으면 Y로 고정)
	
	//Schedule테이블에서 가져옴
	private String departure;//출발지
	private String arrival;//도착지
	private String st; // 출발시각
	private String grade; // 버스등급
	
	//ticket테이블의 pType과 Schedule테이블의 price를 가져와 실 결제금액 산출 (누적)
	private int realprice;
	//wholeprice-realprice
	private int discount;
	
	//출발일 당일 취소가능 => 취소불가 상태로 바뀜. 
	private String status;
	
	//인수
	private int headcount;
	
	public UserTicketDetailDTO(TicketVO tVO,CommonScheduleService sService) throws Exception {
		ScheduleVO sVO = sService.readBySnum(tVO.getSnum().intValue());
		this.snum = tVO.getSnum();
		this.rno = tVO.getRno();
		this.tdate = tVO.getTdate();
		this.ddate = tVO.getDdate();
		this.seatnum = tVO.getSeatnum();
		this.pet = tVO.getPet();
		
		this.departure = sVO.getDeparture();
		this.arrival = sVO.getArrival();
		this.st = sVO.getSt();
		this.grade = sVO.getGrade();
		
		this.headcount = 1;
		
		if((this.ddate).toLocalDate().isAfter(LocalDate.now())) {
			this.status = "취소가능";
		}else {
			this.status = "취소불가";
		}
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
	
	public void calcPrice(Long price, char ptype) {
		switch(ptype){
		//어른
		case 'A':
			this.realprice += price;
			break;
		//청소년
		case 'T':
			this.realprice += (int)(price*0.9f);
			this.discount += (price-(int)(price*0.9f));
			break;
		//아동
		case 'K':
			this.realprice += (int)(price*0.7f);
			this.discount += (price-(int)(price*0.7f));
			break;
		//장애
		case 'D':
			this.realprice += price;
			break;
		default:
			this.realprice += price;
			break;
		}
	}
	
	public void calcPet(char pet) {
		if(this.pet != 'Y') this.pet = pet;
	}

	public void calcSeatNum(String seatnum) {
		this.seatnum = (this.seatnum).concat(", "+seatnum);
		this.headcount += 1;
	}
	public void calcRno(String rno) {
		this.rno = (this.rno).concat(", "+rno);
	}
}
