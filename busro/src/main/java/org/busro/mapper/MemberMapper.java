package org.busro.mapper;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.SqlSession;
import org.busro.domain.Criteria;
import org.busro.domain.MemberVO;
import org.springframework.transaction.annotation.Transactional;

public interface MemberMapper {

	//회원가입
	public void memberJoin(MemberVO member);
		
	//아이디 중복확인
	public int idCheck(String id);
	
	//로그인
	public MemberVO memberLogin(MemberVO member);
	
	//아이디 찾기
	public String find_id(MemberVO vo);
	
	//비번 찾기
	public MemberVO find_pw(MemberVO vo);
	
	//비번 변경
	public int modifyPass(MemberVO vo);
	
	//마이페이지 회원정보 수정
	public int updateMember(MemberVO vo);
	
	//회원 탈퇴
	public void memberDelete(MemberVO vo);
	
	//회원탈퇴를 위한 패스워드 체크
	public int passChk(MemberVO vo);
	
	public List<MemberVO> getList();
	
	public List<MemberVO> getListWithPaging(Criteria cri);
	
	public int getTotalCount(Criteria cri);
	
	public List<MemberVO> search(Criteria cri);
	
	//관리자 페이지 - 회원 리스트 회원정보 수정모달
	public int updateMember1(MemberVO vo); 

	//관리자 페이지 - 회원 리스트 회원정보 수정모달 - 회원삭제
	public void memberDelete1(MemberVO vo);
	
	//아이디 검색
	public MemberVO searchId(String id);
	
	
	
	
}