package org.busro.service;

import java.util.List;

import org.admin.domain.Criteria;
import org.admin.domain.InquiryVO;
import org.busro.domain.MemberVO;
import org.busro.mapper.InquiryMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.Setter;
import lombok.extern.log4j.Log4j2;

@Service
@Log4j2
public class InquiryServiceImpl implements InquiryService {
	
	@Setter(onMethod_ = @Autowired)
	private InquiryMapper imapper;
	

	@Override
	public List<InquiryVO> getInquiryList(Criteria cri) {
	
		
		return imapper.getInquiryList(cri);
	}
	

	
	

	@Override
	public int getTotal(Criteria cri) {
		// TODO Auto-generated method stub
		return imapper.getTotal(cri);
	}

	@Override
	public InquiryVO inquiryDetail(int ino) {
		
		return imapper.inquiryDetail(ino);
	}

	@Override
	public List<InquiryVO> myList(InquiryVO vo) {
		
		
		// TODO Auto-generated method stub
		return imapper.myList(vo);
	}

	@Override
	public int getUserTotal(String writer) {
		
		
		return imapper.getUserTotal(writer);
	}

	@Override
	public void inquiryRegister(InquiryVO vo) {
		
		log.info("문의 등록 : " + vo);
		
		imapper.inquiryRegister(vo);
		
	}

	@Override
	public boolean userInquiryChange(InquiryVO vo) {

		log.info("문의글 수정 잘 되니? " + vo);
		
		boolean updateResult = imapper.userInquiryChange(vo) == 1;
		
		return updateResult;
	}

	@Override
	public boolean userInquiryDelete(int ino) {
		
		log.info("문의글 삭제 잘 되니? " + ino);
		
		
		return imapper.userInquiryDelete(ino) == 1;
	}




	
}
