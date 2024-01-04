package org.busro.controller;

import java.util.List;

import org.admin.domain.ScheduleVO;
import org.busro.annotation.Auth;
import org.busro.domain.SearchScheduleDTO;
import org.busro.domain.TicketListDTO;
import org.busro.service.CommonScheduleService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j2;

@Controller
@Log4j2
@RequestMapping("/schedule/*")
@AllArgsConstructor
public class CommonScheduleController {
	
	private CommonScheduleService service;
	
	@Auth
	@GetMapping("/scheduleList")
	public void scheduleList(TicketListDTO tDTOList, SearchScheduleDTO ssDTO, Model model) {
		List<ScheduleVO> sList = service.getSearchedList(ssDTO);
		log.info("tDTOList:"+tDTOList);
		log.info("searchDTO:"+ssDTO+",scheduleList:"+sList);
		if(tDTOList != null) {
			//왕복선택일시 이전 좌석선택정보를 보존함
			model.addAttribute("tDTOList",tDTOList.getTDTOList());
		}
		model.addAttribute("searchDTO",ssDTO);
		model.addAttribute("scheduleList", sList);
	}

	@ResponseBody
	@GetMapping("/getScheduleList")
	public List<ScheduleVO> getScheduleList() {
		List<ScheduleVO> sList = service.getList();
		return sList;
	}
	
	@ResponseBody
	@GetMapping("/getDepartureList")
	public List<String> getDepartureList() {
		List<String> dList = service.getDepartureList();
		return dList;
	}
	
	@ResponseBody
	@GetMapping("/getArrivalList/{departure}")
	public List<String> getArrivalList(@PathVariable String departure) {
		List<String> aList = service.getArrivalList(departure);
		return aList;
	}
}
