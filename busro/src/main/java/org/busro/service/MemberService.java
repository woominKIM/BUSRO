package org.busro.service;

import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.busro.domain.Criteria;
import org.busro.domain.MemberVO;

public interface MemberService {

	//회원가입
	public void memberJoin(MemberVO member) throws Exception;
	
	//아이디 중복 검사
	public int idCheck(String id) throws Exception;
	
	//로그인
	public MemberVO memberLogin(MemberVO member) throws Exception;

	//아이디 찾기
	public String find_id(HttpServletResponse response, MemberVO vo) throws Exception;

	public MemberVO find_pw(MemberVO vo);
	
	public int modifyPass(MemberVO vo) throws Exception;

	//마이페이지 회원정보 수정
	public int updateMember(MemberVO vo) throws Exception;
	
	//회원탈퇴
	public void memberDelete(MemberVO vo) throws Exception;
	
	//회원탈퇴를 위한 패스워드 체크
	public int passChk(MemberVO vo) throws Exception;
	
	/* public List<MemberVO> getList() throws Exception; */
	
	public List<MemberVO> getList(Criteria cri) throws Exception;
	
	public List<MemberVO> search(Criteria cri) throws Exception;
	
	public int getTotal(Criteria cri);
	
	//관리자 페이지 - 회원 리스트 회원정보 수정모달
	public int updateMember1(MemberVO vo) throws Exception;
	
	//관리자 페이지 - 회원 리스트 회원정보 수정모달 - 회원삭제
	public void memberDelete1(MemberVO vo) throws Exception;
	
	//아이디 검색
	public MemberVO searchId(String id) throws Exception;
	
	
	
	
		
	
}//interface