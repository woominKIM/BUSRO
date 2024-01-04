package org.admin.domain;

import java.time.LocalDateTime;

import lombok.Data;

@Data
public class TicketVO implements Comparable<TicketVO>{
	private Long mnum; //관리번호
	private Long snum; //스케줄번호
	private String rno; //예매번호
	private LocalDateTime tdate; //예매일
	private LocalDateTime ddate; //출발일
	private String id; //예매한 아이디
	private String seatnum; //예약한 좌석
	private char ptype; //나이정보
	private char pet; //반려동물 동승유무("Y","N")
	
	@Override
	public int compareTo(TicketVO tVO) {
		int comp = (int)(this.getSnum() - tVO.getSnum());
		if (comp != 0) {
			return comp;
		}else {
			int comp2 = this.getDdate().compareTo(tVO.getDdate());
			return comp2;
		}
	}
}
