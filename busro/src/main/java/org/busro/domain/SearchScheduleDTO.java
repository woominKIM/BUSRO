package org.busro.domain;

import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;
import lombok.extern.log4j.Log4j2;

@Log4j2
@Data
public class SearchScheduleDTO {
	private String leaveDayWeek;
	private String comebackDayWeek;
	
	private int chkRoundTrip;
	private String departure;
	private String arrival;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private LocalDate leaveDay;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private LocalDate comebackDay;
	
	public SearchScheduleDTO(int chkRoundTrip, String departure,String arrival,String leaveDay,String comebackDay){
		this.departure = departure;
		this.arrival = arrival;
		this.leaveDay = LocalDate.parse(leaveDay,DateTimeFormatter.ISO_DATE);
		this.comebackDay = LocalDate.parse(comebackDay,DateTimeFormatter.ISO_DATE);
		
		
		DayOfWeek depWeek = this.leaveDay.getDayOfWeek();
		log.info("depweek ="+depWeek);
		switch(depWeek) {
			case SATURDAY: case SUNDAY:
				this.leaveDayWeek = "주말";
				break;
			case MONDAY: case TUESDAY: case WEDNESDAY: case THURSDAY: case FRIDAY:
				this.leaveDayWeek = "평일";
				break;
			default:
				this.leaveDayWeek = "평일";
				break;
		}

		DayOfWeek arrWeek = this.comebackDay.getDayOfWeek();
		log.info("arrweek ="+depWeek);
		switch(arrWeek) {
			case SATURDAY: case SUNDAY:
				this.comebackDayWeek = "주말";
				break;
			case MONDAY: case TUESDAY: case WEDNESDAY: case THURSDAY: case FRIDAY:
				this.comebackDayWeek = "평일";
				break;
			default:
				this.comebackDayWeek = "평일";
				break;
		}
	}
}
