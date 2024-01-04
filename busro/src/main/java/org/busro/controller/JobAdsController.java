package org.busro.controller;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.busro.annotation.Auth;
import org.busro.annotation.Auth.Role;
import org.busro.domain.Criteria;
import org.busro.domain.MemberVO;
import org.busro.domain.NoticeAttachVO;
import org.busro.domain.NoticeVO;
import org.busro.domain.PageDTO;
import org.busro.service.NoticeService;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j2;

@Controller
@Log4j2
@RequestMapping("/jobAds/*")
@AllArgsConstructor
public class JobAdsController {
	
	private NoticeService service;
	
//	@GetMapping("/wishList")
//	public void wishList(Model model) {
//		
//		log.info("list진입");
//		
//		model.addAttribute("list", service.getList());
//	}
	
	@Auth(role = Role.ADMIN)
	@GetMapping("/wishList")
	public void wishList(Criteria cri, Model model, HttpSession session) throws Exception {
		
		
		 MemberVO vo = (MemberVO)session.getAttribute("member");
		 
		 log.info("관리자 vo.........." + vo);

			log.info("list: " + cri);
			model.addAttribute("list", service.getList(cri));
			model.addAttribute("toplist", service.getTopList());
			//model.addAttribute("pageMaker", new PageDTO(cri, 123));
			
			int total = service.getTotal(cri);
			
			log.info("total: " + total);
			
			model.addAttribute("pageMaker", new PageDTO(cri, total));
			
			

	
	}


	
	
	@GetMapping("/wishListShow")
	public void wishListShow(Criteria cri, Model model, HttpSession session) throws Exception {
		
		
		log.info("사용자리스트 진입");
			
		MemberVO vo = (MemberVO)session.getAttribute("member");
		log.info("사용자리스트 vo.........." + vo);	
		
		
		log.info("list: " + cri);
		model.addAttribute("list", service.getList(cri));
		model.addAttribute("toplist", service.getTopList());
		//model.addAttribute("pageMaker", new PageDTO(cri, 123));
		
		int total = service.getTotal(cri);
		
		log.info("total: " + total);
		
		model.addAttribute("pageMaker", new PageDTO(cri, total));
		
		
		

		
	}
	
	
	
	@Auth(role = Role.ADMIN)
	@PostMapping("/wishRegister")
	public String wishRegister(NoticeVO notice, RedirectAttributes rttr, HttpSession session) throws Exception{
		
		MemberVO vo = (MemberVO)session.getAttribute("member");
		
		notice.setWriter(vo.getId());
		if(vo != null) {
		
		
		log.info("register: " + notice);
		
		if(notice.getTop() == null) {
			System.out.println("널이라서");
			notice.setTop("n");
		}
		
		if(notice.getAttachList() !=null) {
			
			notice.getAttachList().forEach(attach -> log.info(attach));
		}
		
		log.info("==========================");
		log.info("==========================" + notice);
		service.register(notice);
		
		//rttr.addFlashAttribute("result", notice.getNno());
		
		return "redirect:/jobAds/wishList";
	
		
		
		}else {
			
			return "redirect:/jobAds/wishList";
			
		}
		
	}
	
	
	@Auth(role = Role.ADMIN)
	@GetMapping("/wishRegister")
	public void wishRegister(HttpSession session, Model model) {
		
		MemberVO vo = (MemberVO)session.getAttribute("member");
		
		model.addAttribute("vo", vo);
	}
	
	@Auth(role = Role.ADMIN)
	@GetMapping({"/wishGet", "/wishModify"})
	public void wishGet(@RequestParam("nno") Long nno, @ModelAttribute("cri") Criteria cri, Model model, HttpSession session) {
		
		log.info("관리자용 /wishget or wishmodify");
		
		MemberVO vo = (MemberVO)session.getAttribute("member");
		
		log.info("관리자용 : " + vo);
		
		log.info("crite : "+ cri);
		model.addAttribute("vo", vo);
		model.addAttribute("notice", service.get(nno));
		
	}
	
	
	@GetMapping({"/wishGetShow"})
	public void wishGetShow(@RequestParam("nno") Long nno, @ModelAttribute("cri") Criteria cri, Model model, HttpSession session) throws Exception {
		
		log.info("사용자리스트 진입");
		
		MemberVO vo = (MemberVO)session.getAttribute("member");
		log.info("사용자리스트 vo.........." + vo);	
		
		log.info("/wishgetShow");
		log.info("crite : "+ cri);
		
		model.addAttribute("notice", service.get(nno));
		
	}
	
	@Auth(role = Role.ADMIN)
	@PostMapping("/wishModify")
	public String wishModify(NoticeVO notice, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr) {
		log.info("wishmodify:" + notice);
		log.info("crite : "+ cri);
		if(notice.getTop() == null) {
			System.out.println("널이라서");
			notice.setTop("n");
		}
		
		if (service.modify(notice)) {
			rttr.addFlashAttribute("result", "success");
		   }
		
			rttr.addAttribute("pageNum", cri.getPageNum());
			rttr.addAttribute("amount", cri.getAmount());
			rttr.addAttribute("type", cri.getType());
			rttr.addAttribute("keyword", cri.getKeyword());
		
		
		   return "redirect:/jobAds/wishList";

		  }
	
	@Auth(role = Role.ADMIN)
	@PostMapping("/wishRemove")
	public String wishRemove(@RequestParam("nno") Long nno, Criteria cri, RedirectAttributes rttr) {
		
		log.info("wishremove.........." + nno);
		
		List<NoticeAttachVO> attachList = service.getAttachList(nno);
		
		
		if (service.remove(nno)) {
			
			deleteFiles(attachList);
			
			rttr.addFlashAttribute("result", "success");
		}
		
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword", cri.getKeyword());
		
		
		return "redirect:/jobAds/wishList" + cri.getListLink();
	}
	
	@GetMapping(value = "/getAttachList", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<List<NoticeAttachVO>> getAttachList(Long nno) {
		
		log.info("getAttachList" + nno);
		
		return new ResponseEntity<>(service.getAttachList(nno), HttpStatus.OK);
		
	}
	
	private void deleteFiles(List<NoticeAttachVO> attachList) {
		
		if(attachList == null || attachList.size() == 0) {
			
			return;
		}
		
		log.info("delete attach files...............");
		log.info(attachList);
		
		attachList.forEach(attach -> {
			
			try {
				
				Path file = Paths.get("C:\\upload\\"+attach.getUploadPath()+"\\" + attach.getUuid()+"_"+ attach.getFileName());
				
				Files.deleteIfExists(file);
				
				if(Files.probeContentType(file).startsWith("image")) {
					
					Path thumbNail = Paths.get("C:\\upload\\"+attach.getUploadPath()+"\\s_" + attach.getUuid()+"_"+ attach.getFileName());
					
					Files.delete(thumbNail);
				}
				
			} catch (Exception e) {
				log.error("delete file error" + e.getMessage());
			}	//end catch
		});	//end foreach
	}
}
