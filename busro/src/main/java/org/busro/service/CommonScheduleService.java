package org.busro.service;

import java.util.List;

import org.admin.domain.ScheduleVO;
import org.busro.domain.SearchScheduleDTO;


public interface CommonScheduleService {

	public List<ScheduleVO> getList();
	public ScheduleVO readBySnum(int snum);
	public List<ScheduleVO> getSearchedList(SearchScheduleDTO ssDto);
	public List<String> getDepartureList();
	public List<String> getArrivalList(String departure);
	
}
