package org.busro.controller;

import java.util.Arrays;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.admin.domain.AnswerVO;
import org.admin.domain.Criteria;
import org.admin.domain.PageDTO;
import org.admin.domain.ScheduleVO;
import org.busro.annotation.Auth;
import org.busro.annotation.Auth.Role;
import org.busro.domain.MemberVO;
import org.busro.service.AnswerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j2;

@RequestMapping("/admin/*")
@RestController
@Log4j2

public class AnswerController {

	@Setter(onMethod_ = @Autowired)
	private AnswerService answerService;

	/*
	 * @PostMapping(value="/add", consumes = "application/json", produces =
	 * {MediaType.TEXT_PLAIN_VALUE}) public ResponseEntity<String>
	 * answerRegister(@RequestBody AnswerVO vo){
	 * 
	 * log.info("답변 등록 " + vo);
	 * 
	 * int insertCount = answerService.answerRegister(vo);
	 * 
	 * log.info("등록 수 " + insertCount);
	 * 
	 * return insertCount == 1 ? new ResponseEntity<>("success", HttpStatus.OK) :
	 * new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	 * 
	 * }
	 */
	
	@Auth(role = Role.ADMIN)
	@PostMapping("/add")
	public String answerRegister(AnswerVO vo, RedirectAttributes rttr, HttpSession session) throws Exception {

		MemberVO mvo = (MemberVO)session.getAttribute("member");
		  
		log.info("==============");
		  
		log.info("등록 세션 : " + mvo);
		
		log.info("등록되었음 : " + vo);

		answerService.answerRegister(vo);

		rttr.addFlashAttribute("add", vo.getAno());

		return "redirect:/admin/adminInquirydetails";
	}

	/*
	 * @RequestMapping(method = {RequestMethod.GET}, value = "/status", produces = {
	 * MediaType.APPLICATION_XML_VALUE, MediaType.APPLICATION_JSON_UTF8_VALUE })
	 * public ResponseEntity<List<AnswerVO>> searchArrival(){
	 * 
	 * List<AnswerVO> status = answerService.answerGet();
	 * 
	 * log.info("진입 : ");
	 * 
	 * log.info("vo: " + status);
	 * 
	 * return new ResponseEntity<>(status, HttpStatus.OK); }
	 */

	/*
	 * @GetMapping(value= "/status", produces = {MediaType.TEXT_PLAIN_VALUE}) public
	 * List<Integer> status(@RequestBody int b) {
	 * 
	 * int[] ino = {1,2,3, 32}; log.info("확인 : " + b); List<Integer> result =
	 * answerService.answerTotal(ino);
	 * 
	 * 
	 * result.forEach(a -> log.info(a));
	 * 
	 * return result;
	 * 
	 * 
	 * }
	 */

	  
	  @PostMapping(value = "/status", produces = { MediaType.APPLICATION_XML_VALUE, MediaType.APPLICATION_JSON_UTF8_VALUE }) 
	  public ResponseEntity<List<Integer>> status(int[] ino){
	   
	  //String[] ino1 = request.getParameterValues("ino"); //파라미터 수집을 못하는것
	  
	  log.info("확인 : " + ino);
	  
	  List<Integer> result = answerService.answerTotal(ino);
	  
	  
	  result.forEach(a -> log.info(a));
	  
	  
	  
	  return new ResponseEntity<>(result, HttpStatus.OK);
	  
	  }
	 
	
	
		/*
		 * @PostMapping(value="/status", produces = {MediaType.TEXT_PLAIN_VALUE}) public
		 * void status(int[] ino) {
		 * 
		 * log.info("상태 : " + Arrays.toString(ino));
		 * 
		 * }
		 */

	//관리자용 답변 조회 =====================
	
	
	@GetMapping(value = "/check", produces = { MediaType.TEXT_PLAIN_VALUE })
	public String checkAnswer(AnswerVO vo, HttpSession session) {

		MemberVO mvo = (MemberVO)session.getAttribute("member");
		  
		log.info("==============");
		  
		log.info("답변 상세 보기에서 쓸 용 세션 : " + mvo);
		
		//log.info("답변 있니? : " + vo);

		log.info("확인 : " + answerService.checkAnswer(vo));

		return answerService.checkAnswer(vo);

		// answerService.checkAnswer(vo)의 리턴값이 1과 같다면 보여준다 0과 같다면 안보여준다?
		// answerService.checkAnswer(vo) 를 로그로 찍어보고 1인지 0인지가 출력되는지 확인해볼필요가 있음
		// String으로 반환해준다고 했는데 무슨값을 반환을 해주는지 jsp에서는 다 1일찍힌다 고로 들어가는값이 전부
		// 1이다 vo값이 전부 까지 확인했는데 리로드하면서 값이 잘들어왔음 restart문제였나봄
		// 해결이 잘 된것들은 jsp에서 콘솔을 주석처리해서 계속해서 같은 값이 클릭해서 혼동없도록 정리 필요
		// mapper만들었으면 꼭 test를 해야함
	}
	
	
	
	

	/*
	 * @GetMapping(value = "/{ino}", produces = {MediaType.APPLICATION_XML_VALUE,
	 * MediaType.APPLICATION_JSON_UTF8_VALUE}) public ResponseEntity<AnswerVO>
	 * answerGet(@PathVariable("ino") int ino) {
	 * 
	 * log.info("상세 조회 : " + ino);
	 * 
	 * return new ResponseEntity<>(answerService.answerGet(ino), HttpStatus.OK);
	 * 
	 * }
	 */

	// 답변 삭제
	
	@Auth(role = Role.ADMIN)
	@DeleteMapping(value = "/{ino}", produces = { MediaType.TEXT_PLAIN_VALUE })
	public ResponseEntity<String> answerDelete(@PathVariable("ino") int ino, HttpSession session) {

		MemberVO mvo = (MemberVO)session.getAttribute("member");
		  
		log.info("==============");
		  
		log.info("삭제용 세션 : " + mvo);
		
		log.info("답변 삭제 " + ino);

		return answerService.answerDelete(ino) == 1 ? new ResponseEntity<>("success", HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);

	}

//	  @RequestMapping( method = {RequestMethod.PUT, RequestMethod.PATCH}, 
//			  			value = "/{ino}", consumes = "application/json", 
//			  			produces = {MediaType.TEXT_PLAIN_VALUE, MediaType.APPLICATION_JSON_UTF8_VALUE})
//	  public ResponseEntity<String> updateAnswer (@RequestBody AnswerVO vo, @PathVariable("ino") int ino){

//		  vo.setAno(ino);

//		  log.info("답변 번호 ino : " + ino); log.info("수정할 답변 : " + vo);

//		  return answerService.updateAnswer(vo) == 1 ? 
//				  new ResponseEntity<>("success", HttpStatus.OK) : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR); 

//	  }
	
	@Auth(role = Role.ADMIN)
	@PostMapping("/update")
	public String updateAnswer(AnswerVO vo, RedirectAttributes rttr, HttpSession session) {

		MemberVO mvo = (MemberVO)session.getAttribute("member");
		  
		log.info("==============");
		  
		log.info("답변 수정용 세션 : " + mvo);
		
		log.info("modify" + "수정페이지");

		if (answerService.updateAnswer(vo)) {

			rttr.addFlashAttribute("result", "success");

		}

		return "redirect:/admin/adminInquirydetails";

	}

}
