package org.busro.service;

import java.util.List;

import org.admin.domain.Criteria;
import org.admin.domain.ScheduleVO;
import org.busro.mapper.ScheduleMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.Setter;
import lombok.extern.log4j.Log4j2;

@Service
@Log4j2
public class ScheduleServiceImpl implements ScheduleService{

	@Setter(onMethod_ = @Autowired )
	private ScheduleMapper smapper;

	@Override
	public List<ScheduleVO> getListPaging(Criteria cri) {
		
		log.info("페이징 처리 된 전체 목록");
		
		List<ScheduleVO> list = smapper.getListPaging(cri);
		
		return list;
	}



	@Override
	public void routeRegister(ScheduleVO schedule) {
		// TODO Auto-generated method stub
		log.info("등록 완료 : " + schedule);
		
		//schedule.setSt(schedule.getSth() + ":" + schedule.getStm());
		
		//log.info("시간확인" + schedule.getSt());
		
		//ScheduleVO checkRoute = smapper.sortingDuplicate(schedule);
		
		smapper.insert(schedule);
		
		
	}



	@Override
	public boolean modify(ScheduleVO schedule) {
		
		log.info("수정임" + schedule);
		
		return smapper.update(schedule) == 1;
	}



	@Override
	public ScheduleVO get(int snum) {
		log.info("get임 " + snum) ;
		ScheduleVO vo = smapper.read(snum);
		String times = vo.getSt();
		vo.setSth(times.substring(0, 2)); 
		vo.setStm(times.substring(3));
		
		log.info(vo.getSth() + " : " + vo.getStm());
		
		return vo;
	}



	@Override
	public boolean remove(int snum) {
		
		log.info("삭제한거 : " + snum);
		
		return smapper.delete(snum) == 1;
	}



	@Override
	public int sortingDuplicate(ScheduleVO schedule) {
		// TODO Auto-generated method stub
		return smapper.sortingDuplicate(schedule);
	}



	@Override
	public int getTotal(Criteria cri) {
		//등록된 노선 총 개수
		return smapper.getTotal(cri);
	}



	@Override
	public List<ScheduleVO> searchDeparture() {
		
		return smapper.searchDeparture();
	}



	@Override
	public List<ScheduleVO> searchArrival() {
		
		return smapper.searchArrival();
	}









	
	
}
