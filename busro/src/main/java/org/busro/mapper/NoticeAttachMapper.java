package org.busro.mapper;

import java.util.List;

import org.busro.domain.NoticeAttachVO;

public interface NoticeAttachMapper {
	
	public void insert(NoticeAttachVO vo);
	
	public void delete(String uuid);
	
	public List<NoticeAttachVO> findByNno(Long nno);
	
	public void deleteAll(Long nno);
	
	public List<NoticeAttachVO> getOldFiles();
		
	

}
