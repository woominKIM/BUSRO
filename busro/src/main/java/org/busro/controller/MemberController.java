package org.busro.controller;

import java.text.SimpleDateFormat;
import java.time.LocalDate;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.busro.annotation.Auth;
import org.busro.annotation.Auth.Role;
import org.busro.domain.Criteria;
import org.busro.domain.MemberVO;
import org.busro.domain.PageDTO;
import org.busro.service.MemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.Setter;
import lombok.extern.log4j.Log4j2;

@Log4j2
@Controller
@RequestMapping(value = "/member/*")
public class MemberController {

	@Setter(onMethod_ = @Autowired)
	private MemberService memberService;

	// 약관 페이지 이동
	@GetMapping("/beforeJoin")
	public void joinGET() {
		
		log.info("약관 페이지 진입");
		
	} //.약관 페이지 이동
	

	// 회원가입 페이지 이동
	@GetMapping("/join")
	public void joinGetAfter() {
				
		log.info("회원가입 페이지로 이동");
		
	} //.회원가입 페이지 이동
	

	// 회원가입
	@RequestMapping(value = "/join", method = RequestMethod.POST)
	public String joinPost(MemberVO member) throws Exception {		
		
		log.info("join 진입");

		LocalDate date = LocalDate.of(Integer.parseInt(member.getYear()), Integer.parseInt(member.getMonth()),
				Integer.parseInt(member.getDay()));

		java.sql.Date date2 = java.sql.Date.valueOf(date);	

		member.setBirth(date2);

		String tel = member.getTel1() + "-" + member.getTel2() + "-" + member.getTel3();

		member.setTel(tel);

		log.info(date);
		log.info(tel);

		// 회원가입 서비스 실행
		memberService.memberJoin(member);

		log.info("join service success................");

		return "redirect:/main";

	} //.회원가입
	

	// 아이디 중복 검사
	@RequestMapping(value = "/memberIdChk", method = RequestMethod.POST)
	@ResponseBody
	//			public void memberIdChkPost(String memberId) throws Exception {
	public String memberIdChkPost(String memberId) throws Exception {

		log.info("memberIdChk() 진입");

		int result = memberService.idCheck(memberId);

		log.info("아이디 중복검사 결과값..........: " + result);

		if (result != 0) {

			return "fail"; // 중복 아이디가 존재

		} else {			

			return "success"; // 중복아이디 없음
			
		}

	}//.아이디 중복 검사 
	

	// 로그인 페이지 이동
	@RequestMapping(value = "login", method = RequestMethod.GET)
	public void loginGET() {

		log.info("로그인 페이지 진입");

	}//.로그인 페이지 이동
	

	//로그인
	@RequestMapping(value = "login", method = RequestMethod.POST)
	public String loginPost(MemberVO member, HttpServletRequest request, RedirectAttributes rttr) throws Exception {

		HttpSession session = request.getSession();
		MemberVO lvo = memberService.memberLogin(member);
		// lvo 값은 아이디, 비밀번호가 존재할 경우 Id, Name 등의 데이터가 담긴 MemberVO 객체가 저장

		if (lvo == null) { // 일치하지 않는 아이디, 비번 입력 시(실패)
			int result = 0;
			rttr.addFlashAttribute("result", result);
			return "redirect:/member/login";
		}

		session.setAttribute("member", lvo); // 일치하는 아이디, 비번 입력 시(성공)

		return "redirect:/main";

	}//.로그인 
	

	//로그아웃
	@RequestMapping(value = "logout.do", method = RequestMethod.GET)
	public String logoutMainGet(HttpServletRequest request) throws Exception {

		log.info("logoutMainGet 메서드 진입");

		HttpSession session = request.getSession();

		session.invalidate(); // invalidate() 세션 전체를 무효화하는 메서드

		return "redirect:/main";

	}//.로그아웃
	

	// 마이페이지
	@Auth
	@RequestMapping(value = "/myPage.do")
	public String myPage(Model model, HttpSession session) throws Exception {

		log.info("마이페이지 진입");

		MemberVO vo = (MemberVO)session.getAttribute("member");
		log.info("마이페이지 vo.........." + vo);		

		if(vo != null) {
			
			SimpleDateFormat smt = new SimpleDateFormat("yyyy-MM-dd");
			String sDate = smt.format(vo.getBirth());
			log.info("sDate.........." + sDate);		

			String[] array = sDate.split("-");

			for(int i=0; i<array.length; i++) {		
				vo.setYear(array[0]);	//yyyy
				vo.setMonth(array[1]);	//mm
				vo.setDay(array[2]);	//dd

			}//for		

			String tel = vo.getTel(); // 010-1234-5678
			vo.setTel1(tel.substring(0, 3)); //010
			vo.setTel2(tel.substring(4, 8)); //1234
			vo.setTel3(tel.substring(9, 13)); //5678

			vo.setTel(tel);	

			model.addAttribute("vo", vo);
			log.info("vo.........." + vo);
			return "/member/myPage";

		}else {
			
			log.info("마이페이지 이동 실패.........." + vo);
			return "/member/login";
			
		}

	}//.마이페이지
	

	//개인정보 수정	
	@RequestMapping(value = "update.do", method = RequestMethod.POST)
	public String updateMember(HttpSession session, Model model, MemberVO vo) throws Exception {
		log.info("업데이트 멤버 vo........" + vo);

		String tel = vo.getTel1() + "-" + vo.getTel2() + "-" + vo.getTel3();

		vo.setTel(tel);

		LocalDate date = LocalDate.of(Integer.parseInt(vo.getYear()), Integer.parseInt(vo.getMonth()),
				Integer.parseInt(vo.getDay()));
		java.sql.Date date2 = java.sql.Date.valueOf(date);
		vo.setBirth(date2);
		log.info("date2..." + date2);

		if(memberService.updateMember(vo)> 0) {
			session.setAttribute("loginUser", memberService.memberLogin(vo));

			session.setAttribute("alertMsg", "성공적으로 변경하였습니다");

			session.setAttribute("member", vo);
			
			return "redirect:/main";

		}else {
			model.addAttribute("alertMsg", "수정에 실패하였습니다");
			return "myPage";
		}

	}//.개인정보 수정
	

	// 아이디/비밀번호 찾기로 이동
	@RequestMapping(value = "/find_idpw_form.do")
	public String find_idpw_form() throws Exception {
		
		log.info("아이디/비밀번호 찾기로 이동........");
		
		return "/member/find_idpw_form";
		
	}//.아이디/비밀번호 찾기로 이동
	

	// 아이디 찾기 결과로 이동
	@RequestMapping(value = "/find_id.do", method = RequestMethod.POST)
	public String find_id(HttpServletResponse response, MemberVO vo, Model model) throws Exception {

		log.info("파라미터 값 :" + vo.getTel() + vo.getName() + vo.getBirth());

		model.addAttribute("id", memberService.find_id(response, vo));

		return "/member/find_id";
		
	}//.아이디 찾기 결과로 이동
	

	//아이디/전화번호 정보 갖고 비밀번호 변경으로 이동
	@RequestMapping(value = "/modifyPass.do", method = RequestMethod.POST)
	public String modifyPOST(MemberVO vo, RedirectAttributes ra, Model model) throws Exception {

		log.info("modifyPOST 진입..............." + vo); 

		MemberVO vo1 = memberService.find_pw(vo);

		if(vo1 != null) { //값이 null이 아니면 비번변경 페이지로 이동 
			
			log.info("참 진입..........");
			model.addAttribute("vo", vo);
			
			return "/member/modifyPass";

		}else { 
			
			log.info("거짓 진입.........."); //값이 null이면 오류메시지 가지고 다시 돌아감(find_idpw_form.do) 
			
			ra.addFlashAttribute("result", "실패");
			
			return "redirect:find_idpw_form.do";		  
		}		  

	}//.아이디/전화번호 정보 갖고 비밀번호 변경으로 이동


	//비밀번호 변경 완료
	@RequestMapping(value = "/modifyPass1.do", method = RequestMethod.POST)		
	public String modify(HttpSession session, Model model, MemberVO vo) throws Exception {
		log.info("modify 진입.................... " + vo);
		log.info("변경될 내용 " + vo);	
		
		if(memberService.modifyPass(vo) > 0) {
			session.setAttribute("loginUser", memberService.memberLogin(vo));
			
			session.setAttribute("alertMsg", "성공적으로 변경하였습니다.");
			
			return "redirect:/member/login";
			
		}else {
			model.addAttribute("alertMsg", "수정에 실패하였습니다.");
			return "modifyPass";
		}

	}//.비밀번호 변경 완료
	
	
	//회원탈퇴 진입
	@Auth
	@RequestMapping(value = "/memberDeleteView", method = RequestMethod.GET)
	public String memberDeleteView() throws Exception {
		log.info("회원탈퇴 페이지 진입.....");
		return "/member/memberDeleteView";
	}//.회원탈퇴 진입

	//회원탈퇴
	@RequestMapping(value = "/memberDelete", method = RequestMethod.POST)
	public String memberDelete(MemberVO vo, HttpSession session, RedirectAttributes rttr) throws Exception {
		
		//세션에 있는 member를 가져와 member변수에 넣어줌
		MemberVO member = (MemberVO)session.getAttribute("member");
		log.info("회원탈퇴 member........" + member);

		//세션에 있는 비밀번호
		String sessionPass = member.getPass();

		//vo로 들어오는 비밀번호
		String voPass = vo.getPass();
		
		log.info("회원탈퇴 sessionPass....." + sessionPass);
		log.info("회원탈퇴 voPass....." + voPass);

		if(!(sessionPass.equals(voPass))) {
			rttr.addFlashAttribute("msg", false);
			return "redirect:/member/memberDeleteView";
		}
		memberService.memberDelete(vo);
		session.invalidate();		
		return "redirect:/member/login";
		
	}//.회원탈퇴
	
	
	//회원탈퇴를 위한 패스워드 체크
	@ResponseBody
	@RequestMapping(value = "/passChk", method = RequestMethod.POST)
	public int passChk(MemberVO vo, HttpSession session) throws Exception {
		
		int result = memberService.passChk(vo);		
		
		log.info("패스워드 체크 vo....." + vo);
		log.info("패스워드 체크 result....." + result);
		
		return result;
		
	}//.회원탈퇴를 위한 패스워드 체크

	
/* 관리자용  *//* 관리자용  *//* 관리자용  *//* 관리자용  *//* 관리자용  *//* 관리자용  *//* 관리자용  *//* 관리자용  *//* 관리자용  */

	// 관리자용 회원가입 양식 페이지
	@Auth(role = Role.ADMIN)
	@GetMapping("/join_admin")
	public void joinGetAfter2() {
		
		log.info("관리자용 회원가입 페이지로 이동");
		
	}//.관리자용 회원가입 양식 페이지

	//관리자용 회원가입
	@Auth(role = Role.ADMIN)
	@RequestMapping(value = "/join_admin", method = RequestMethod.POST)
	public String joinPost2(MemberVO member) throws Exception {
		log.info("join_admin 진입");
		//				Date date = new Date();
		LocalDate date = LocalDate.of(Integer.parseInt(member.getYear()), Integer.parseInt(member.getMonth()),
				Integer.parseInt(member.getDay()));

		java.sql.Date date2 = java.sql.Date.valueOf(date);

		member.setBirth(date2);

		String tel = member.getTel1() + "-" + member.getTel2() + "-" + member.getTel3();

		member.setTel(tel);

		log.info(date);
		log.info(tel);

		// 회원가입 서비스 실행
		memberService.memberJoin(member);

		log.info("join service success................");

		return "redirect:/main";
		
	}//.관리자용 회원가입

	// 관리자용 리스트 페이지 이동
	@Auth(role = Role.ADMIN)
	@GetMapping("/list")
	public void listGET(Model model, Criteria cri, HttpSession session) throws Exception {
		log.info("리스트 페이지 진입" + cri);		

		//list.jsp에서 사용할 키워드
		model.addAttribute("list", memberService.search(cri));
		
		
		model.addAttribute("list", memberService.getList(cri));
		
		int total = memberService.getTotal(cri);
		
		log.info("total.......: " + total);
		
		model.addAttribute("pageMaker", new PageDTO(cri, total));
		
	}//.관리자용 리스트 페이지 이동

	//관리자용 회원정보 수정	
	@Auth(role = Role.ADMIN)
	@RequestMapping(value = "updateMember1.do", method = RequestMethod.POST)
	public String updateMember1(HttpSession session, Model model, @RequestBody MemberVO vo) throws Exception {
		log.info("업데이트 멤버 vo........" + vo);
		if(memberService.updateMember1(vo)> 0) {
			session.setAttribute("loginUser", memberService.memberLogin(vo));

			session.setAttribute("alertMsg", "성공적으로 변경하였습니다");

			return "/main";

		}else {
			model.addAttribute("alertMsg", "수정에 실패하였습니다");
			return "/myPage";
		}

	}//.관리자용 회원정보 수정

	//관리자용 회원삭제
	@Auth(role = Role.ADMIN)
	@RequestMapping(value = "/memberDelete1.do", method = RequestMethod.POST)
	public String memberDelete1(MemberVO vo, HttpSession session, RedirectAttributes rttr) throws Exception {
		MemberVO member = (MemberVO)session.getAttribute("member");			

		memberService.memberDelete1(vo);		
		return "redirect:/member/list";
		
	}//.관리자용 회원삭제	 

}// class