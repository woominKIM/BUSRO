package org.busro.mapper;

import java.util.List;

import org.busro.domain.Criteria;
import org.busro.domain.NoticeVO;

public interface NoticeMapper {
	
	//@Select("select * from NOTICE where nno > 0")
	public List<NoticeVO> getList();
	
	public List<NoticeVO> getListWithPaing(Criteria cri);
	
	public void insert(NoticeVO notice);
	
	public Integer insertSelectKey(NoticeVO notice);
	
	public NoticeVO read(Long nno);
	
	public int delete(Long nno);
	
	public int update(NoticeVO notice);
	
	public int getTotalCount(Criteria cri);
	
	public List<NoticeVO> getTopList();
	
	
}
