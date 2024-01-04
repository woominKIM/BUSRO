package org.busro.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.admin.domain.Criteria;
import org.admin.domain.PageDTO;
import org.admin.domain.ScheduleVO;
import org.busro.annotation.Auth;
import org.busro.annotation.Auth.Role;

import org.busro.domain.MemberVO;
import org.busro.service.ScheduleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;


import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j2;

@Controller
@Log4j2
@RequestMapping("/admin/*")
public class ScheduleController {
	
	
	  @Setter(onMethod_ = @Autowired)
	  private ScheduleService scheduleService;
	 
	  //노선들 불러와
	  
	  //스케줄 출발지 리스트 뽑기
	  @RequestMapping(method = {RequestMethod.GET}, 
				value = "/searchD", 
						produces = {
								MediaType.APPLICATION_XML_VALUE,
								MediaType.APPLICATION_JSON_UTF8_VALUE })
		public ResponseEntity<List<ScheduleVO>> searchDeparture(){
			
		  	List<ScheduleVO> searchD = scheduleService.searchDeparture();
			log.info("진입 : ");
			
			log.info("searchD" + searchD);
			
			return new ResponseEntity<>(searchD, HttpStatus.OK);
		}
	  
	  @RequestMapping(method = {RequestMethod.GET}, 
				value = "/searchA", 
						produces = {
								MediaType.APPLICATION_XML_VALUE,
								MediaType.APPLICATION_JSON_UTF8_VALUE })
		public ResponseEntity<List<ScheduleVO>> searchArrival(){
			
		  	List<ScheduleVO> searchA = scheduleService.searchArrival();
			log.info("진입 : ");
			
			log.info("vo: " + searchA);
			
			return new ResponseEntity<>(searchA, HttpStatus.OK);
		}
	  
	
	  @Auth(role = Role.ADMIN)
	  @GetMapping("/routeschedulelist") 
	  public void routeList(Model model, Criteria cri, HttpServletRequest request) {
	  
		  HttpSession session = request.getSession();
		  Object lvo = session.getAttribute("member");
		  
		  log.info("로그인 정보 : " + lvo);
		  
		  log.info("리스트 " + cri);
		 
		  
		  List<ScheduleVO> scheduleList = scheduleService.getListPaging(cri);
		  
		  int total = scheduleService.getTotal(cri);
		  
		  PageDTO pages = new PageDTO(cri, total);
		  
		  
		  
		  for(ScheduleVO a : scheduleList) {
			  
			  log.info("왔니" + a);
			  
			  log.info(a.getSnum());
		  }
		 
		  
		  log.info("스케줄 조회");
		  
		  model.addAttribute("list", scheduleList);
		  model.addAttribute("pages", pages);
		  
	  
	  
	  
	  } // 노선 리스트 =========================
	  
	  
	  // 노선 등록 ================
	  @Auth(role = Role.ADMIN)
	  @GetMapping("/routescheduleadd")
	  public void routeRegister(HttpSession session) {
		  
		  MemberVO vo = (MemberVO)session.getAttribute("member");
		  
		  log.info("==============");
		  
		  log.info("로그인 정보 : " + vo);
		  
	  }
	  
	  @Auth(role = Role.ADMIN)
	  @GetMapping("/adminMain")
	  public void aaaaa() {
		  System.out.println("들어옴");
	  }
	  
	  @Auth(role = Role.ADMIN)
	  @PostMapping("/routescheduleadd")
	  public String routeRegister(ScheduleVO schedule, RedirectAttributes rttr, HttpServletRequest req) throws Exception{
		  
		  HttpSession session = req.getSession();
		  Object lvo = session.getAttribute("member");
		  
		  log.info("등록 로그인 정보 : " + lvo);
		  
		  log.info("==============");
		  
		  log.info("운영요일 등록 : " + schedule.getWorkday());
		  if(schedule.getWorkday().length() > 2) {
			  schedule.setWorkday("상시");
		  }
		  
		  log.info("register 등록 : " + schedule);
		  
		  schedule.setSt(schedule.getSth() + ":" + schedule.getStm());
		  
		  log.info("시간확인 : " + schedule.getSt());
		  
		  log.info("중복체크 진입");
		  
		  int a = scheduleService.sortingDuplicate(schedule);
		  
		  log.info("결과값 : " + a);
		  
		  if(a == 0) {
			 
			  System.out.println("널" + a);
			  scheduleService.routeRegister(schedule);
			  rttr.addFlashAttribute("result", schedule.getSnum());
			  
			  return "redirect:/admin/routescheduleadd";
		  }else {
			  System.out.println("널이 아님" + a);
			  
			  rttr.addFlashAttribute("result", "실패");
			  
			  
			  return "redirect:/admin/routescheduleadd";
		  }
		
	  }
	  
	  @Auth(role = Role.ADMIN)
	  @GetMapping({"/routescheduleget" , "/routeschedulemodify"})
	  public void get(@RequestParam("snum") int snum, Model model, HttpServletRequest req) {
		  
		  HttpSession session = req.getSession();
		  Object lvo = session.getAttribute("member");
		  
		  log.info("상세 혹은 수정 로그인 정보 : " + lvo);
		  
		  log.info("상세 혹은 수정");
		  
		model.addAttribute("schedule", scheduleService.get(snum));
		  
	  }
	  
	 // @RequestMapping(value = "/busro/routeschedulemodify", method = {RequestMethod.GET, RequestMethod.POST} )
	  @Auth(role = Role.ADMIN)
	  @PostMapping("/routeschedulemodify")
	  public String routeModify(ScheduleVO schedule, RedirectAttributes rttr, HttpSession req) {
		  
		  MemberVO vo = (MemberVO)req.getAttribute("member");
		  
		  log.info("==============");
		  
		  log.info("수정하는 사람 정보 : " + vo);
		  
		  log.info("수정페이지 : " + schedule.getWorkday());
		  if(schedule.getWorkday().length() > 2) {
			  schedule.setWorkday("상시");
		  }
		  
		  log.info("수정페이지");
		  	schedule.setSt(schedule.getSth() + ":" + schedule.getStm());
		  
		  log.info("시간확인" + schedule.getSt());
		  
		  if(scheduleService.modify(schedule)) {
			  
			  rttr.addFlashAttribute("result", "success");
			  
			  log.info("성공 : " + schedule);
		  }
		  
		  	  log.info("실패 : " + schedule);
		  
		  return "redirect:/admin/routeschedulelist";
		  
	  }
	
	  
	  @Auth(role = Role.ADMIN)
	  @PostMapping("/delete")
	  public String routeDelete(@RequestParam("snum") int snum, RedirectAttributes rttr, HttpSession session) {
		  
		  MemberVO vo = (MemberVO)session.getAttribute("member");
		  
		  log.info("==============");
		  
		  log.info("삭제 : " + vo);
		  
		  
		  log.info("노선 삭제 : " + snum);
		  
		  if(scheduleService.remove(snum)) {
				
				rttr.addFlashAttribute("result", "success");
				
				log.info("삭제 되었나?");
				
			} else {
				log.info("삭제 실패함");
			}
		  
		  return "redirect:/admin/routeschedulelist";
		  
	  }
	  
	
	  
	  
	

}
