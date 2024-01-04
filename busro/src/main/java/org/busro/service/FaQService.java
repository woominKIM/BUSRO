package org.busro.service;

import java.util.List;

import org.busro.domain.Criteria;
import org.busro.domain.FaQVO;

public interface FaQService {
	
	public FaQVO get(Long bno);
	
	public List<FaQVO> getList(Criteria cri);
	
	public void register(FaQVO faqVO);
	
	public boolean modify(FaQVO faq);
	
	public boolean remove(Long fno);

	public FaQVO findgetone(FaQVO vo);
	
	public int getTotal(Criteria cri);
	
	

}
