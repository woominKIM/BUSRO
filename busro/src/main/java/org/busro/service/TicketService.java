package org.busro.service;


import java.util.List;

import org.busro.domain.TicketDTO;
import org.admin.domain.Criteria;
import org.admin.domain.TicketVO;
import org.apache.ibatis.annotations.Param;


public interface TicketService {
	
	public List<TicketVO> getList();
	public List<TicketVO> getList(Criteria cri);
	public List<TicketVO> getListBySnum(int snum);
	public List<TicketVO> getListBySnumAndDDate(int snum,String ddate);
	public int getCountBySnumAndDDate(int snum,String ddate);
	public int insertOneWay(String id, TicketDTO ticketDTO);
	public int insertRoundTrip(String id, TicketDTO ticketDTO);
	public int insertRoundTrip(String id, TicketDTO ticketDTO,int seqIncrease);
	public int deleteOneWayTicket(String rno);
	public int deleteRoundTripTicket(String rno,int snum);
}
