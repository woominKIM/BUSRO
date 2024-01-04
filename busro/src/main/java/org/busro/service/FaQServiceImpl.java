package org.busro.service;

import java.util.List;

import org.busro.domain.Criteria;
import org.busro.domain.FaQVO;
import org.busro.mapper.FaQMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.Setter;
import lombok.extern.log4j.Log4j2;

@Service
@Log4j2
public class FaQServiceImpl implements FaQService {

	@Setter(onMethod_ = @Autowired)
	private FaQMapper mapper;
	
	
	@Override
	public List<FaQVO> getList(Criteria cri) {
		log.info("FaQservice 진입");
		return mapper.getList(cri);
	}
	
	@Override
	public void register(FaQVO faqVO) {
		log.info("get......" + faqVO);
		mapper.insert(faqVO);
	}

	@Override
	public FaQVO get(Long fno) {
		log.info("get......... " + fno);
		return mapper.read(fno) ;
	}

	@Override
	public FaQVO findgetone(FaQVO vo) {
		FaQVO vo1 = mapper.read(vo.getFno());
		return vo1;
	}

	@Override
	public boolean modify(FaQVO faq) {
		// TODO Auto-generated method stub
		return mapper.update(faq)==1;
	}

	@Override
	public boolean remove(Long fno) {
		log.info("remove....." + fno);
		return mapper.delete(fno)==1;
	}

	@Override
	public int getTotal(Criteria cri) {
		// TODO Auto-generated method stub
		return mapper.getTotalCount(cri);
	}

}
