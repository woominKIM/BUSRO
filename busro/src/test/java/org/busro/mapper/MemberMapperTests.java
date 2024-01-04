package org.busro.mapper;

import java.util.Date;
import java.util.List;

import org.busro.domain.Criteria;
import org.busro.domain.MemberVO;
import org.busro.mapper.MemberMapper;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.extern.log4j.Log4j2;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j2
public class MemberMapperTests {

	@Autowired
	private MemberMapper memberMapper;	//MemberMapper.java 인터페이스 의존성 주입
	
//	//회원가입 쿼리 테스트 메소드
//	@Test
//	public void memberJoin() throws Exception {
//		MemberVO member = new MemberVO();
//		java.sql.Date day = new java.sql.Date(2008,8,4);
//		
//		
//		member.setId("테스트아이디");
//		member.setPass("테스트비번");
//		member.setName("테스트이름");		
//		member.setTel("전화번호");
//		member.setGender("M");
//		member.setAuth("ADMIN");
//		
//		memberMapper.memberJoin(member);
//	}
	
	@Test
	public void memberIdChk() throws Exception {
		String id = "admin"; //존재하지 않는 아이디
		String id2 = "test123"; //존재하지 않는 아이디
		memberMapper.idCheck(id);
		memberMapper.idCheck(id2);
		
	}
	
	@Test
	public void memberLogin() throws Exception {
		MemberVO vo = new MemberVO();
		
		/* 올바른 아이디 비번 입력 경우 */
		vo.setId("ee");
		vo.setPass("ee");
		
//		/* 올바르지 않은 아이디 비번 입력 경우 */
//		vo.setId("sdjklhdjfh");
//		vo.setPass("sfdjsdlsldj");
		
		memberMapper.memberLogin(vo);	
		log.info("결과값......: " + memberMapper.memberLogin(vo));
	}
	
	@Test
	public void modifyPassTest() throws Exception {
		MemberVO vo = new MemberVO();
		
		vo.setId("111");
		vo.setTel("010-0000-0000");		
	
		vo.setPass("asdf1234");
		log.info("비밀번호 변경 완료.........!!");
		
		int a = memberMapper.modifyPass(vo);
		if(a==1) {
			log.info("성공..............: " + a);
		}else {
			log.info("실패..............: " + a);
		}
		
		
	}
	
	@Test
	public void testGETList() throws Exception {
		memberMapper.getList().forEach(a -> log.info(a));
		
	}
	
	@Test
	public void testPaging() {
		Criteria cri = new Criteria();
		
		cri.setPageNum(3);
		cri.setAmount(10);
		
		List<MemberVO> list = memberMapper.getListWithPaging(cri);
		
		list.forEach(board -> log.info(board));
	}
	
	
}//class