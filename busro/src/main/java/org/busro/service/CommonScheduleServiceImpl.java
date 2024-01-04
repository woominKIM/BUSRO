package org.busro.service;

import java.util.List;

import org.admin.domain.ScheduleVO;
import org.busro.domain.SearchScheduleDTO;
import org.busro.mapper.CommonScheduleMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j2;

@Service
@Log4j2
@AllArgsConstructor
public class CommonScheduleServiceImpl implements CommonScheduleService{
	
	@Autowired
	private CommonScheduleMapper mapper;

	@Override
	public List<ScheduleVO> getList(){
		log.info("get whole Schedule List");
		return mapper.getList();
	};
	@Override
	public ScheduleVO readBySnum(int snum) {
		log.info("get one Schedule by snum");;
		return mapper.readBySnum(snum);
	}
	@Override
	public List<ScheduleVO> getSearchedList(SearchScheduleDTO ssDto){
		log.info("get Searched Schedule List:" + ssDto);
		return mapper.getSearchedList(ssDto);
	};
	@Override
	public List<String> getDepartureList(){
		log.info("get Departure List");
		return mapper.getDepartureList();
	}
	@Override
	public List<String> getArrivalList(String departure){
		log.info("get Arrival List");
		return mapper.getArrivalList(departure);
	}
}
