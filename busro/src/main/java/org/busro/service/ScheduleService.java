package org.busro.service;
import java.util.List;

import org.admin.domain.Criteria;
import org.admin.domain.ScheduleVO;

public interface ScheduleService {
	
	public List<ScheduleVO> searchDeparture();
	
	public List<ScheduleVO> searchArrival();
	
	public void routeRegister(ScheduleVO snum);	//버스 노선 등록
	
	public ScheduleVO get(int snum); //상세 정보
	
	public boolean modify(ScheduleVO schedule); //버스 노선 수정
	
	public boolean remove(int snum); //버스 노선 삭제
	
	public int sortingDuplicate(ScheduleVO schedule); //노선의 중복 시간 확인
	
	public int getTotal(Criteria cri);

	public List<ScheduleVO> getListPaging(Criteria cri); //게시판 목록(페이징 적용)
	

	
}
