package org.busro.mapper;

import java.util.List;
import java.util.Map;

import org.admin.domain.Criteria;
import org.admin.domain.InquiryVO;


public interface InquiryMapper {
	
	
	public List<InquiryVO> getInquiryList(Criteria cri); //관리자용 전체 리스트
	

	
	public int getTotal(Criteria cri); //전체 게시판 수 (관리자)
	
	public int getUserTotal(String writer); ////전체 게시판 수 (로그인한 회원용)
	
	public InquiryVO inquiryDetail(int ino); //회원 문의 상세보기
	
	public List<InquiryVO> myList(InquiryVO vo); //InquiryVO 에 Criteria & memberVO 다 있음 //회원용 전체 리스트
	
	public void inquiryRegister(InquiryVO vo); //회원용 문의 등록
	
	public int userInquiryChange(InquiryVO vo); //회원용 문의 수정
	
	public int userInquiryDelete(int ino); //회원용 문의 삭제
	
	
}
