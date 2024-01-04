package org.busro.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.busro.domain.TicketDTO;
import org.admin.domain.Criteria;
import org.admin.domain.TicketVO;

public interface TicketMapper {
	public List<TicketVO> getList();
	public List<TicketVO> getList(Criteria cri);
	public List<TicketVO> getListBySnum(int snum);
	public List<TicketVO> getListBySnumAndDDate(@Param("snum")int snum,@Param("ddate")String ddate);
	public int getCountBySnumAndDDate(@Param("snum")int snum,@Param("ddate")String ddate);
	public int insertOneWay(@Param("id")String id, @Param("ticketDTO")TicketDTO ticketDTO);
	public int insertRoundTrip(@Param("id")String id, @Param("ticketDTO")TicketDTO ticketDTO);
	public int insertRoundTripWithSequenceIncrease(@Param("id")String id, @Param("ticketDTO")TicketDTO ticketDTO);
	public int deleteOneWayTicket(String rno);
	public int deleteRoundTripTicket(@Param("rno")String rno, @Param("snum")int snum);
	public int updateRoundTripToOneWay(String rno);
}
