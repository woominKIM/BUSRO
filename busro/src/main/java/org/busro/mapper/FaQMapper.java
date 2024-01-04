package org.busro.mapper;

import java.util.List;

import org.busro.domain.Criteria;
import org.busro.domain.FaQVO;

public interface FaQMapper {	
	//List 완료
	public List<FaQVO> getList(Criteria cri);
	
	public List<FaQVO> getListWithPaging(Criteria cri);
	
	public void insert(FaQVO faq);
	
	public void insertSelectKey(FaQVO board);
	
	public FaQVO read(Long fno);
	
	public int delete(Long fno);
	
	public int update(FaQVO faq);
	
	public int getTotalCount(Criteria cri);
	
	public List<FaQVO> serch(FaQVO faq);
}
