package org.busro.mapper;
import java.util.List;

import org.admin.domain.Criteria;
import org.admin.domain.ScheduleVO;

public interface ScheduleMapper {
	
	public List<ScheduleVO> searchDeparture();
	
	public List<ScheduleVO> searchArrival();
	
	public void insert(ScheduleVO schedule);
	
	public ScheduleVO read(int snum);
	
	public int update(ScheduleVO snum);
	
	public int delete(int snum);
	
	public int sortingDuplicate(ScheduleVO schedule);
	
	public int getTotal(Criteria cri); //전체 노선 수
	
	public List<ScheduleVO> getListPaging(Criteria cri);
	
	
	

	
	
	
	

}
