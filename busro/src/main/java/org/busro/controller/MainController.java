package org.busro.controller;

import java.util.List;

import org.busro.domain.NoticeVO;
import org.busro.service.NoticeService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j2;

@Controller
@Log4j2
@RequestMapping("/")
@AllArgsConstructor
public class MainController {

	private NoticeService nService;

	// 메인 페이지 이동
	@GetMapping("/main")
	public void mainPageGET(Model model) {
		log.info("메인 페이지 진입");
		List<NoticeVO> nList = nService.getTopList();
		//상위공지 4개까지 보여줌
		if(nList.size() > 4) {
			nList = nList.subList(0, 4);
		}
		model.addAttribute("nList",nList);
	}

	@GetMapping("/introduce")
	public void introduce(Model model) {}
}
