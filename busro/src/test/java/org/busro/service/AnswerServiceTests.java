package org.busro.service;

import java.util.List;

import org.admin.domain.AnswerVO;
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
public class AnswerServiceTests {
	
	@Setter(onMethod_ = @Autowired )
	private AnswerService answerService;
	
	
	
	@Test
	public void answerTotal() { //테스트 완료
		
		int[] arr = {1,2,3, 32};
		List<Integer> at = answerService.answerTotal(arr);
		
		at.forEach(a -> log.info("답변 : " + a));
		
		
		
		
	}

}
