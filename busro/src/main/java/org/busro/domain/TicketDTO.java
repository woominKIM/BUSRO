package org.busro.domain;

import lombok.Data;

@Data
public class TicketDTO implements Comparable<TicketDTO>{
	private int snum;
	private int order;
	private String dDate;
	private String seatNum;
	private String pType;
	private String pet;
	
	@Override
	public int compareTo(TicketDTO tDTO) {
		return this.getOrder() - tDTO.getOrder();
	}
}
