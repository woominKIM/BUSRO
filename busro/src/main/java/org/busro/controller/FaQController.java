package org.busro.controller;

import javax.servlet.http.HttpSession;

import org.busro.annotation.Auth;
import org.busro.annotation.Auth.Role;
import org.busro.domain.Criteria;
import org.busro.domain.FaQVO;
import org.busro.domain.MemberVO;
import org.busro.domain.PageDTO;
import org.busro.service.FaQService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.Setter;
import lombok.extern.log4j.Log4j2;

@Controller
@Log4j2
@RequestMapping("/daetaFooter/")
public class FaQController {
	
	@Setter(onMethod_ = @Autowired)
	private FaQService service;

	@GetMapping("oftenFAQ")
	public void oftenFAQ(Model model, HttpSession session, Criteria cri) {
		
		log.info("cri : "+cri);
		/* List<FaQVO> list = service.getList(FaQCriteria cri); */
		/* model.addAttribute("list",list); */
		int total = service.getTotal(cri); 
		
		model.addAttribute("pageMaker", new PageDTO(cri, total));
		
		model.addAttribute("list", service.getList(cri));
		
	}
	
	@Auth(role = Role.ADMIN)
	@GetMapping("adminFAQ")
	public void adminFAQ(Model model, HttpSession session, Criteria cri) {
		
		int total = service.getTotal(cri); 
		
		model.addAttribute("pageMaker", new PageDTO(cri, total));
		
		model.addAttribute("list", service.getList(cri));
		
		
	}

	@Auth(role = Role.ADMIN)
	@GetMapping("registerFAQ")
	public void registerFAQ() {
		
	}

	@Auth(role = Role.ADMIN)
	@PostMapping("registerFAQ")
	public String registerFAQpost(FaQVO vo) {
		log.info("registerFAQ : "  + vo);
		service.register(vo);
		
		return "redirect:adminFAQ";
		
	}	
	
	@GetMapping(value = "aaa",
			produces = {MediaType.APPLICATION_JSON_UTF8_VALUE,
						MediaType.APPLICATION_XML_VALUE})
	public ResponseEntity<FaQVO> getSample(FaQVO vo) {
		
		FaQVO vo1 = service.findgetone(vo);
		
		
		return new ResponseEntity<FaQVO>(vo1,HttpStatus.OK);
	}
	
	/*
	 * // 수정처리 (put, /member/5)
	 * 
	 * @PutMapping("update/{vo}") // json 으로 데이터가 전달되면 @RequestBody로 받아줘야함. public
	 * ResponseEntity update(@RequestBody FaQVO vo) { boolean result =
	 * service.modify(vo); if(result) { return new ResponseEntity(HttpStatus.OK); }
	 * else { return new ResponseEntity(HttpStatus.FAILED_DEPENDENCY); }
	 * 
	 * }
	 */
	
	@Auth(role = Role.ADMIN)
	@PostMapping("update")
	public String modify(FaQVO vo) {
		log.info("입력값 vo update : " + vo);
	 boolean vo1 = service.modify(vo);
		if(vo1) {
			return "redirect:/daetaFooter/adminFAQ";
		}else {
			return "redirect:/daetaFooter/adminFAQ";
		}
		
		
	}

	@Auth(role = Role.ADMIN)
	@PostMapping("delete")
	public String delete(FaQVO vo, Model model) {
		log.info("입력값 vo delete : " + vo);
		Long fno =  vo.getFno();
		
		boolean result =  service.remove(fno);//삭제
		log.info("삭제여부 : " + result);
	 
		if(result) {
			model.addAttribute("result", "성공");
			return "redirect:/daetaFooter/adminFAQ";
		}else {
			model.addAttribute("result", "실패");
			return "redirect:/daetaFooter/adminFAQ";
		}
	}
	
	
	
	
}
