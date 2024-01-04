package org.busro.service;

import java.io.PrintWriter;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.busro.domain.Criteria;
import org.busro.domain.MemberVO;
import org.busro.mapper.MemberMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.Setter;
import lombok.extern.log4j.Log4j2;

@Service
@Log4j2
public class MemberServiceImpl implements MemberService {

	@Setter(onMethod_ = @Autowired)
	private MemberMapper memberMapper;
	
	
	/*
	 * @Override public List<MemberVO> getList() throws Exception { return
	 * memberMapper.getList(); }
	 */
	
	@Override
	public List<MemberVO> getList(Criteria cri) throws Exception {
		
		log.info("페이징 처리한 리스트.........." + cri);
		
		return memberMapper.getListWithPaging(cri);
	}
	
	@Override
	public int getTotal(Criteria cri) {
	
		log.info("카운터 수");
		
		return memberMapper.getTotalCount(cri);
		
		
	}
	
	/* 회원가입 */
	@Override
	public void memberJoin(MemberVO member) throws Exception {
		memberMapper.memberJoin(member);
		log.info("아아............................" + member);
	}	
	
	/* 아이디 중복검사 */
	@Override
	public int idCheck(String id) throws Exception {
		
		return memberMapper.idCheck(id);
	}
	
	/* 로그인 */
	@Override
	public MemberVO memberLogin(MemberVO member) throws Exception {
	
		return memberMapper.memberLogin(member);
	}
	
	/* 아이디 찾기 */
	@Override
	public String find_id(HttpServletResponse response, MemberVO vo) throws Exception {
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();
		String id = memberMapper.find_id(vo);
		
		if (id == null) {
			out.println("<script>");
			out.println("alert('가입된 아이디가 없습니다.');");
			out.println("history.go(-1);");
			out.println("</script>");
			out.close();
			return null;
			
		} else {
			
			return id;
		}
		
	}//find_id
	
	@Override
	public int modifyPass(MemberVO vo) throws Exception {
		log.info("vo.................." + vo);
		return memberMapper.modifyPass(vo);
		
		
	}

	@Override
	public MemberVO find_pw(MemberVO vo) {
		//아이디와 휴대폰 일치여부 확인
		return memberMapper.find_pw(vo);
	}
	
	@Override
	public int updateMember(MemberVO vo) throws Exception {
		
		return memberMapper.updateMember(vo);
	}
	
	@Override
	public void memberDelete(MemberVO vo) throws Exception {
		
		memberMapper.memberDelete(vo);
		log.info("회원탈퇴 서비스Impl............." + vo);
	}
	
	@Override
	public int passChk(MemberVO vo) throws Exception {
		int result = memberMapper.passChk(vo);
		return result;
	}
	
	@Override
	public List<MemberVO> search(Criteria cri) throws Exception {	
		return memberMapper.search(cri);
	}
	
	@Override
	public int updateMember1(MemberVO vo) throws Exception {

		return memberMapper.updateMember1(vo);
	}
	
	@Override
	public void memberDelete1(MemberVO vo) throws Exception {
		memberMapper.memberDelete1(vo);
		log.info("관리자 페이지 회원 삭제............." + vo);
		
	}
	
	@Override
	public MemberVO searchId(String id) throws Exception {
		
		return memberMapper.searchId(id);		
	}
	
	
}//class