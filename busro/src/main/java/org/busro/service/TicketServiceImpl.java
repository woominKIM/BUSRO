package org.busro.service;

import java.util.List;

import org.busro.domain.TicketDTO;
import org.admin.domain.Criteria;
import org.admin.domain.TicketVO;
import org.apache.ibatis.annotations.Param;
import org.busro.mapper.TicketMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.AllArgsConstructor;

@Service
@AllArgsConstructor
public class TicketServiceImpl implements TicketService{
	
	@Autowired
	private TicketMapper mapper;
	
	@Override
	public List<TicketVO> getList(){
		return mapper.getList();
	}
	
	@Override
	public List<TicketVO> getList(Criteria cri){
		return mapper.getList(cri);
	}
	
	@Override
	public List<TicketVO> getListBySnum(int snum){
		return mapper.getListBySnum(snum);
	}

	@Override
	public List<TicketVO> getListBySnumAndDDate(int snum,String ddate){
		return mapper.getListBySnumAndDDate(snum, ddate);
	}
	
	@Override
	public int getCountBySnumAndDDate(int snum,String ddate){
		return mapper.getCountBySnumAndDDate(snum, ddate);
	}
	
	@Override
	public int insertOneWay(String id,TicketDTO ticketDTO) {
		return mapper.insertOneWay(id,ticketDTO);
	}

	@Override
	public int insertRoundTrip(String id, TicketDTO ticketDTO) {
		return mapper.insertRoundTrip(id,ticketDTO);
	}
	
	@Override
	public int insertRoundTrip(String id, TicketDTO ticketDTO,int seqIncrease) {
		return mapper.insertRoundTripWithSequenceIncrease(id,ticketDTO);
	}
	
	@Override
	public int deleteOneWayTicket(String rno) {
		return mapper.deleteOneWayTicket(rno);
	}
	
	@Transactional
	@Override
	public int deleteRoundTripTicket(@Param("rno")String rno, @Param("snum")int snum) {
		mapper.deleteRoundTripTicket(rno, snum);
		int result = mapper.updateRoundTripToOneWay(rno);
		return result;
	}
}
