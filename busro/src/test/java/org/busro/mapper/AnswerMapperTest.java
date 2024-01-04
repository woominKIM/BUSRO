package org.busro.mapper;

import java.util.List;

import org.admin.domain.AnswerVO;
import org.admin.domain.InquiryVO;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.Setter;
import lombok.extern.log4j.Log4j2;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j2
public class AnswerMapperTest {
	
	@Setter(onMethod_ = @Autowired )
	private AnswerMapper amapper;
	
	@Setter(onMethod_ = @Autowired )
	private InquiryMapper imapper;
	
	
	
	@Test
	public void answerGet() {
		
		int targetIno = 53;
		
		AnswerVO vo = amapper.answerGet(targetIno);
		
		log.info("답변 : " + vo);
		
		
	}
	
	/*
	 * @Test public void aa() {
	 * 
	 * 
	 * List<InquiryVO> vo = imapper.aa(); vo.forEach(a -> log.info("리스트 : " + a));
	 * 
	 * for(InquiryVO a :vo ) { log.info("리스트1 : " + a); }
	 * 
	 * }
	 */
	
	/*
	 * @Test public void testUpdate() {
	 * 
	 * int targetIno = 3;
	 * 
	 * AnswerVO vo = amapper.answerGet(targetIno);
	 * 
	 * vo.setContent("수정된 답변");
	 * 
	 * int count = amapper.updateAnswer(vo);
	 * 
	 * log.info("업데이트 카운트 : " + count);
	 * 
	 * }
	 */

}
