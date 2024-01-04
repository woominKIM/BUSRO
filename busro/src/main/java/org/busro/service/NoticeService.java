package org.busro.service;

import java.util.List;

import org.busro.domain.Criteria;
import org.busro.domain.NoticeAttachVO;
import org.busro.domain.NoticeVO;

public interface NoticeService {
	
	public void register(NoticeVO notice);
	
	public NoticeVO get(Long nno);
	
	public boolean modify(NoticeVO notice);
	
	public boolean remove(Long nno);
	
	// public List<NoticeVO> getList();
	
	public List<NoticeVO> getList(Criteria cri);
	
	public int getTotal(Criteria cri);
	
	public List<NoticeVO> getTopList();
	
	public List<NoticeAttachVO> getAttachList(Long nno);

}
