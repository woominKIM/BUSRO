package org.busro.service;

import java.util.List;

import org.admin.domain.Criteria;
import org.admin.domain.InquiryVO;
import org.busro.domain.MemberVO;



public interface InquiryService {
	
	public List<InquiryVO> getInquiryList(Criteria cri); //페이징 처리
	

	
	public int getTotal(Criteria cri);
	
	public int getUserTotal(String writer);
	
	public InquiryVO inquiryDetail(int ino); //문의글 상세 보기
	
	public List<InquiryVO> myList(InquiryVO vo);
	
	public void inquiryRegister(InquiryVO vo); //회원용 문의 수정
	
	public boolean userInquiryChange(InquiryVO vo); //회원용 문의 수정
	
	public boolean userInquiryDelete(int ino); //회원용 문의 삭제
	

}
