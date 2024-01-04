package org.busro.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.admin.domain.AnswerVO;
import org.admin.domain.Criteria;
import org.admin.domain.InquiryVO;
import org.admin.domain.PageDTO;
import org.busro.annotation.Auth;
import org.busro.annotation.Auth.Role;
import org.busro.domain.MemberVO;
import org.busro.service.AnswerService;
import org.busro.service.InquiryService;
import org.busro.service.MemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.Setter;
import lombok.extern.log4j.Log4j2;

@Controller
@Log4j2
/* @RequestMapping("/admin/*") */
public class InquiryController {
	
	@Setter(onMethod_ = @Autowired)
	private InquiryService inquiryService;
	
	@Setter(onMethod_ = @Autowired)
	private AnswerService answerService;
	
	@Setter(onMethod_ = @Autowired)
	private MemberService memberService;
	
	
	
	//회원용 문의 삭제
	@Auth
	@PostMapping("/personalAsk/userInquiryDelete")
	public String userInquiryDelete(@RequestParam("ino") int ino, RedirectAttributes rttr) {
		
		log.info("회원용 문의 삭제 번호 : " + ino);
		
		if(inquiryService.userInquiryDelete(ino)) {
			
			rttr.addAttribute("result", "success");
			log.info("삭제성공");
			
		}else {
			log.info("삭제 실패");
		}
		
		return "redirect:/personalAsk/myPageInquiryList";
		
	}
	
	//회원용 문의 수정
	@Auth
	@PostMapping("/personalAsk/toChangeInquiry")
	public String userInquiryChange(InquiryVO vo, RedirectAttributes rttr) {
		
		log.info("컨트롤러 문의 진입");
		
		if(inquiryService.userInquiryChange(vo) ) {
			rttr.addAttribute("result", "success");
		}
		
		
		return "redirect:/personalAsk/myPageInquiryList";
		
	}
	
	
	//회원 문의 등록
	@Auth
	@GetMapping("/personalAsk/ihaveAQ")
	public void inquiryRegister() {
		
	}
	
	@Auth
	@PostMapping("/personalAsk/ihaveAQ")
	public String inquiryRegister(InquiryVO vo, RedirectAttributes rttr, Model model, HttpSession session) {
		
		MemberVO mvo = (MemberVO)session.getAttribute("member"); //member 객체 
		
		log.info("==========================");
		
		log.info("컨트롤러 문의 등록 : " + vo);
		
		inquiryService.inquiryRegister(vo);
		
		rttr.addAttribute("result", vo.getIno());
		
		String writer = mvo.getId();
		
		
		model.addAttribute("id", writer);
		
		return "redirect:/personalAsk/myPageInquiryList";
		
	}
	
	//회원용 리스트 호출
	  @Auth
	  @GetMapping("/personalAsk/myPageInquiryList") 
	  public void myList(Model model, Criteria cri, HttpSession session) throws Exception {
		  
		  MemberVO vo = (MemberVO)session.getAttribute("member"); //member 객체 
		 
		  InquiryVO voi = new InquiryVO();
		  //mylist메소드에 담을 문의 VO
		  
		  log.info("voi : " + cri);
		  
		  voi.setCri(cri);
		  voi.setMemberVO(vo); //문의 vo에 멤버 객체 담아줌
		 //문의 VO에 필요한 정보 set해줌. 
		  
			
		  String writer = vo.getId(); 
		  
		  log.info("writer : " + writer);
			 
		  
		  int totalInquiry = inquiryService.getUserTotal(writer);
		 
		  log.info("totalInquiry : " + totalInquiry);
		  
		  List<InquiryVO> list = inquiryService.myList(voi);
		  
		  log.info("리스트 : " + list);
		  
		  PageDTO pages = new PageDTO(cri, totalInquiry);
			
		  int[] a = new int[list.size()]; //문의 리스트의 사이즈를 배열로 만들기
			
			for(int i = 0; i < list.size(); i++) {
				a[i] = list.get(i).getIno();
				//a의 i번째는 문의리스트에서 i번째 ino를 가져옴
			}
			
			
			List<Integer> result = answerService.answerTotal(a);
			
			//result는 답변의 카운트를 가지고 있음
			
		
			for(int j =0; j < result.size(); j++) {
				list.get(j).setTf(result.get(j));
				
				
			}
			
			 result.size(); //.size() : 리스트의 숫자를 반환함
		  
		  
		  model.addAttribute("ilist", list);
		  model.addAttribute("result", result); 
		  model.addAttribute("pages", pages); 
	  }
	  
	 
	  //회원용 상세 보기 & 수정
	  
	  	@Auth
		@GetMapping({"/personalAsk/myPageInquiryDetail", "/personalAsk/toChangeInquiry"})
		public void userInquiryDetail(@RequestParam("ino") int ino, Model model, HttpSession session) {
			
		log.info("관리자용 문의 내용 상세보기");
			
		MemberVO vo = (MemberVO)session.getAttribute("member");
			  
		log.info("==============");
		  
		log.info("상세보기 : " + vo);
			
		//List<AnswerVO> answer;
		AnswerVO answer = answerService.answerGet(ino);
			
		log.info("답변 조회 : " + answer);
			
		model.addAttribute("view", inquiryService.inquiryDetail(ino));
		model.addAttribute("get", answer);
		
		}
	  
	  
	
	//관리자용 전체 리스트 호출 ======================================
	@Auth(role = Role.ADMIN)
	@GetMapping("/admin/adminInquirylist")
	public void getInquiryList(Model model, Criteria cri, HttpSession session) throws Exception {
		System.out.println("criteria : " + cri);
		MemberVO vo = (MemberVO)session.getAttribute("member");
		  
		 log.info("==============");
		  
		 log.info("리스트 페이지 : " + vo);
		
		List<InquiryVO> inquiryList = inquiryService.getInquiryList(cri);
		
		
		int totalInquiry = inquiryService.getTotal(cri);
		
		PageDTO pages = new PageDTO(cri, totalInquiry);
		
		int[] a = new int[inquiryList.size()]; //문의 리스트의 사이즈를 배열로 만들기
	
		
		for(int i = 0; i < inquiryList.size(); i++) {
			a[i] = inquiryList.get(i).getIno();
			//a의 i번째는 문의리스트에서 i번째 ino를 가져옴
			
		}
		
		
		List<Integer> result = answerService.answerTotal(a);
		
		//result는 답변의 카운트를 가지고 있음
		
	
		
		 result.size(); //.size() : 리스트의 숫자를 반환함
		 
		 inquiryList.forEach(c -> log.info("화긴" + c));
		 
		 
		 
		model.addAttribute("result", result); 
		model.addAttribute("ilist", inquiryList);
		model.addAttribute("pages", pages);
		

		
	}
	
	
	//관리자용 문의 상세 보기 ================================
	
	@Auth(role = Role.ADMIN)
	@GetMapping("/admin/adminInquirydetails")
	public void inquiryDetail(@RequestParam("ino") int ino, Model model, HttpSession session) {
		
		log.info("관리자용 문의 내용 상세보기");
		
		MemberVO vo = (MemberVO)session.getAttribute("member");
		  
		log.info("==============");
		  
		log.info("상세보기 : " + vo);
		
		//List<AnswerVO> answer;
		AnswerVO answer = answerService.answerGet(ino);
		
		log.info("답변 조회 : " + answer);
		
		model.addAttribute("view", inquiryService.inquiryDetail(ino));
		model.addAttribute("get", answer);
	}
	
	
	
} // class
