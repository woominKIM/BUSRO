package org.busro.controller;

import org.admin.domain.ScheduleVO;
import org.busro.domain.FaQVO;
import org.busro.domain.NoticeVO;
import org.busro.mapper.FaQMapper;
import org.busro.mapper.NoticeMapper;
import org.busro.mapper.ScheduleMapper;
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
public class AllInsertMapperTests {

	@Setter(onMethod_ = @Autowired )
	
	private ScheduleMapper smapper;
	
	@Setter(onMethod_ = @Autowired )
	private NoticeMapper nmapper;
	
	@Setter(onMethod_ = @Autowired )
	private FaQMapper fmapper;
	
	@Test
	public void testFaqInsert() {
		
		for(int i = 0; i < 1050; i++) {
			
			FaQVO vo = new FaQVO();
			
			vo.setWriter("1");
			vo.setQuestion(i + "번째 질문");
			vo.setAnswer(i + "번째 답변");
			vo.setCategory(i + "번째 카테고리");
			
			fmapper.insert(vo);
			
			log.info("잘 들어갔니? " + vo);
		}
		
	}
	
	@Test
	public void testNoticeInsert() {
		
		for(int i = 0; i < 1200; i++) {
			
			NoticeVO vo = new NoticeVO();
			
			vo.setWriter("1");
			vo.setTitle(i + "번째 제목임");
			vo.setContent(i + "번째 내용임");
			
			nmapper.insert(vo);
			
			log.info("잘 들어갔니? " + vo);
		}
		
	}
	
	
	@Test
	public void testInsert() {
		
		for(int i = 0; i < 60; i++) {
			
			ScheduleVO vo = new ScheduleVO();
			
			vo.setDeparture("동서울");
			vo.setArrival("동대구");
			vo.setGrade("일반");
			vo.setPrice(30000L);
			vo.setEta(200L);
			vo.setSt("11:" + i);
			vo.setWorkday("주말");
			
			smapper.insert(vo);
			log.info("잘 들어갔니? " + vo);
			
		}
		
	}
	
	
	
}
