package org.busro.controller;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import lombok.Setter;
import lombok.extern.log4j.Log4j2;

@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/root-context.xml","file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"})
@Log4j2
public class ScheduleControllerTests {
	
	@Setter(onMethod_ = @Autowired)
	private WebApplicationContext ctx;
	private MockMvc mockMvc;
	
	@Before
	public void setup() {
		this.mockMvc = MockMvcBuilders.webAppContextSetup(ctx).build();
		
	}
	
	@Test
	public void testList() throws Exception{
		
		log.info("보여줄거"+mockMvc.perform(MockMvcRequestBuilders.get("/busro/routeschedulelist")).andReturn().getModelAndView().getModel().toString());

	}
	
	@Test
	public void testRegister() throws Exception{
		
		String resultPage = mockMvc.perform(MockMvcRequestBuilders.post("/busro/routescheduleadd")
				.param("grade",	"일반")
				.param("departure", "강릉")
				.param("arrival", "경주")
				.param("workday", "평일")
				.param("sth", "10")
				.param("stm", "25")
				.param("eta", "190")
				.param("price", "15000")).andReturn().getModelAndView().getViewName();
		
		log.info("결과 : " + resultPage);
	}
	
	@Test
	public void testModify() throws Exception{
		
		String resultPage = mockMvc.perform(MockMvcRequestBuilders.post("/busro/routeschedulemodify")
				.param("snum", "1")
				.param("grade",	"우등")
				.param("departure", "서울")
				.param("arrival", "부산")
				.param("workday", "평일")
				.param("st", "09:10")
				.param("eta", "678")
				.param("price", "13000")).andReturn().getModelAndView().getViewName();
		
		log.info("주소 : " + resultPage);
				
		
	}
	
}
