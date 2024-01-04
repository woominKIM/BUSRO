package org.busro.controller;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.servlet.http.HttpSession;

import org.admin.domain.Criteria;
import org.admin.domain.PageDTO;
import org.admin.domain.ScheduleVO;
import org.admin.domain.TicketDetailDTO;
import org.busro.annotation.Auth;
import org.busro.annotation.Auth.Role;
import org.busro.domain.MemberVO;
import org.busro.domain.SearchScheduleDTO;
import org.busro.domain.TicketDTO;
import org.busro.domain.TicketListDTO;
import org.busro.domain.UserTicketDetailDTO;
import org.admin.domain.TicketVO;
import org.busro.service.CommonScheduleService;
import org.busro.service.MemberService;
import org.busro.service.TicketService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.gson.Gson;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j2;

@Controller
@Log4j2
@RequestMapping("/ticket/*")
@AllArgsConstructor
public class TicketController {
	
	private TicketService service;
	private CommonScheduleService sService;
	private MemberService mService;
	
	@Auth
	@GetMapping("/seatList")
	public void seatList(int snum,TicketListDTO tDTOList,SearchScheduleDTO ssDTO, Model model) {
		log.info("tDTOList:"+tDTOList);
		log.info("ssDTO:"+ssDTO);
		log.info("snum:"+snum);
		List<TicketVO>tList = service.getListBySnumAndDDate(snum,ssDTO.getLeaveDay().toString());
		log.info("reserved Seat List:"+tList);
		Gson gson = new Gson();
		if(tDTOList != null) {
			//왕복선택일시 이전 좌석선택정보를 보존함
			model.addAttribute("tDTOList",tDTOList.getTDTOList());
		}
		model.addAttribute("snum",snum);
		model.addAttribute("searchDTO",ssDTO);
		model.addAttribute("ticketList",gson.toJson(tList));
	}

	@ResponseBody
	@GetMapping("/getReservedSeatCount/{snum}/{ddate}")
	public int getReservedSeatCount(@PathVariable int snum,@PathVariable String ddate) {
		int seatCount = service.getCountBySnumAndDDate(snum, ddate);
		return seatCount;
	}
	
	@Auth
	@PostMapping("/ticketConfirm")
	public String ticketConfirm(TicketListDTO tDTOList,SearchScheduleDTO ssDTO, RedirectAttributes rttr, Model model) {
		log.info("tDTOList:"+tDTOList);
		log.info("ssDTO:"+ssDTO);
		
		//왕복 가는편을 선택할 시 처리 구현
		if(ssDTO.getChkRoundTrip() > 1) {
			List<TicketDTO> ticketList = tDTOList.getTDTOList();
			Collections.sort(ticketList);
			
			//가는편의 좌석 지정순서 재정렬
	        tDTOList.setTDTOList(ticketList);
	        
			//왕복일경우 출발지,도착지를 반전시켜 다시 스케쥴 조회
			String dep = ssDTO.getDeparture();
			String arr = ssDTO.getArrival();
			String leaveWeek = ssDTO.getLeaveDayWeek();
			String comebackWeek = ssDTO.getComebackDayWeek();
			LocalDate leaveDay = ssDTO.getLeaveDay();
			LocalDate comebackDay = ssDTO.getComebackDay();
			ssDTO.setArrival(dep);
			ssDTO.setDeparture(arr);
			ssDTO.setComebackDay(leaveDay);
			ssDTO.setLeaveDay(comebackDay);
			ssDTO.setComebackDayWeek(leaveWeek);
			ssDTO.setLeaveDayWeek(comebackWeek);
			ssDTO.setChkRoundTrip(1);
			rttr.addFlashAttribute(tDTOList);
			rttr.addFlashAttribute(ssDTO);
			return "redirect:/schedule/scheduleList";
		}else {
			//편도이거나 왕복 선택을 완료했을 시 최종 결제확인페이지로 넘어감
			Set<Integer> snumList = new HashSet<>();
			List<ScheduleVO> sList = new ArrayList<>();
			for(TicketDTO tDTO : tDTOList.getTDTOList()) {
				snumList.add(tDTO.getSnum());
			}
			for(int snum:snumList) {
				sList.add(sService.readBySnum(snum));
			}
			log.info("스케쥴번호:"+snumList);
			
			//왕복일 경우 출발지, 도착지를 다시 반전시켜 원상복구
			if(sList.size()>1) {
				String dep = ssDTO.getDeparture();
				String arr = ssDTO.getArrival();
				String leaveWeek = ssDTO.getLeaveDayWeek();
				String comebackWeek = ssDTO.getComebackDayWeek();
				LocalDate leaveDay = ssDTO.getLeaveDay();
				LocalDate comebackDay = ssDTO.getComebackDay();
				ssDTO.setArrival(dep);
				ssDTO.setDeparture(arr);
				ssDTO.setComebackDay(leaveDay);
				ssDTO.setLeaveDay(comebackDay);
				ssDTO.setComebackDayWeek(leaveWeek);
				ssDTO.setLeaveDayWeek(comebackWeek);
				
				//왕복일 경우의 출발편,오는편 정보의 순서가 틀어질경우 재정렬
				if(sList.size()==2 && !sList.get(0).getDeparture().equals(ssDTO.getDeparture())) {
					Collections.reverse(sList);
				}
			}

			model.addAttribute("tDTOList",tDTOList.getTDTOList());
			model.addAttribute("scheduleList",sList);
			model.addAttribute("searchDTO",ssDTO);
			return "ticket/ticketConfirm";
		}
	}
	
	@Auth
	@PostMapping("/doTicketing")
	public String doTicketing(String chkRoundTrip, TicketListDTO tDTOList, HttpSession session, RedirectAttributes rttr) {
		String userID = ((MemberVO)session.getAttribute("member")).getId();
		log.info("tDTOList:"+tDTOList);
		List<TicketDTO> ticketList = tDTOList.getTDTOList();
		
		try {
			//왕복일경우의 티켓팅 처리
			if(chkRoundTrip.equals("1")) {
		        List<TicketDTO> leaveList = ticketList.subList(0, (ticketList.size() + 1) / 2);
		        List<TicketDTO> comebackList= ticketList.subList((ticketList.size() + 1) / 2, ticketList.size());
		        Collections.sort(leaveList);
		        Collections.sort(comebackList);
		        String leaveDay =  leaveList.get(0).getDDate();
		        String comebackDay =  comebackList.get(0).getDDate();
		        String leaveTime = sService.readBySnum(leaveList.get(0).getSnum()).getSt();
		        String comebackTime = sService.readBySnum(comebackList.get(0).getSnum()).getSt();
				for(int i=0; i<leaveList.size();i++) {
					//(년,월,일) 에 (시,분) 데이터 추가
					leaveList.get(i).setDDate(leaveDay+" "+leaveTime);
					comebackList.get(i).setDDate(comebackDay+" "+comebackTime);
					log.info("leave Time:"+leaveList.get(i).getDDate());
					log.info("comeback Time:"+comebackList.get(i).getDDate());
					//왕복인경우 같은 식별번호를 가진 한쌍씩 DB에 들어감.
					service.insertRoundTrip(userID, leaveList.get(i),0);
					service.insertRoundTrip(userID, comebackList.get(i));
				}
			}
			//편도일경우의 티켓팅 처리
			else {
				Collections.sort(ticketList);
				String leaveDay = ticketList.get(0).getDDate();
		        String leaveTime = sService.readBySnum(ticketList.get(0).getSnum()).getSt();
				for(TicketDTO ticketDTO:ticketList) {
					//(년,월,일) 에 (시,분) 데이터 추가
					ticketDTO.setDDate(leaveDay+" "+leaveTime);
					service.insertOneWay(userID, ticketDTO);
				}
			}
		}catch(Exception e) {
			log.warn(e.getStackTrace());
		}
		return "redirect:/main";
	}
	
	@Auth(role = Role.ADMIN)
	@GetMapping("/bookingmanagelist")
	public String getTicketListForAdmin(Criteria cri, HttpSession session,Model model) throws Exception {
		List<TicketVO> ticketList = new ArrayList<>();
		if(cri == null) cri = new Criteria();
		if(cri.getKeyword() == null) {
			ticketList = service.getList();
		}else {
			ticketList = service.getList(cri);
		}
		
		List<TicketDetailDTO> tdList = new ArrayList<>();
		for(TicketVO ticket:ticketList) {
			TicketDetailDTO tdDTO = new TicketDetailDTO(ticket, sService, mService);
			tdList.add(tdDTO);
		}
		
		int total = tdList.size();
		PageDTO pages = new PageDTO(cri,total);
		
		if(total>0) {
			int startIdx = (cri.getPageNum()-1)*cri.getAmount();
			int endIdx = cri.getPageNum()*cri.getAmount()-1;
			int realEndIdx = total-1;
			if(startIdx>realEndIdx) {
				if((startIdx-=cri.getAmount())<0) {
					startIdx+=cri.getAmount();
				}
				endIdx = realEndIdx;
			}
			if(endIdx>realEndIdx) {
				endIdx = realEndIdx;
			}
			tdList = tdList.subList(startIdx,endIdx+1);
			log.info("startIdx:"+startIdx);
			log.info("endIdx:"+endIdx);
			log.info("realEndIdx:"+realEndIdx);
		}else {
			log.info("no data:tdList");
		}
		log.info("ticketList:"+tdList.size());
		model.addAttribute("ticketList",tdList);
		model.addAttribute("pages",pages);
		
		return "/admin/bookingmanagelist";
	}
	
	@Auth
	@GetMapping("/bookinglist")
	public void getTicketList(Criteria cri, HttpSession session,Model model) throws Exception {
		String userID = ((MemberVO)session.getAttribute("member")).getId();
		List<TicketVO> ticketList = new ArrayList<>();
		if(cri == null) {
			cri = new Criteria();
		}
		cri.setType("I");
		cri.setKeyword(userID);
		ticketList = service.getList(cri);
		List<UserTicketDetailDTO> utdList = new ArrayList<>();
		
		if(ticketList.size()>0){
			//스케줄번호, 출발시각 순으로 정렬하여 동일한 예약건 묶어서 처리
			Collections.sort(ticketList);
			UserTicketDetailDTO utDTO = new UserTicketDetailDTO(ticketList.get(0), sService);
			Long snum = utDTO.getSnum();
			LocalDateTime ddate = utDTO.getDdate();
			for(int idx=1; idx<ticketList.size(); idx++) {
				TicketVO ticket = ticketList.get(idx);
				
				//동일 스케줄 예약건일경우
				if(snum.equals(ticket.getSnum())&&ddate.isEqual(ticket.getDdate())) {
					utDTO.calcPet(ticket.getPet());
					utDTO.calcPrice(sService.readBySnum(ticket.getSnum().intValue()).getPrice(),ticket.getPtype());
					utDTO.calcSeatNum(ticket.getSeatnum());
					utDTO.calcRno(ticket.getRno());
				}
				//별개의 스케줄 예약건일경우
				else {
					utdList.add(utDTO);
					utDTO = new UserTicketDetailDTO(ticket, sService);
					snum = ticket.getSnum();
					ddate = utDTO.getDdate();
				}
			}
			utdList.add(utDTO);
		}

		int total = utdList.size();
		PageDTO pages = new PageDTO(cri,total);
	
		if(total>0) {
			int startIdx = (cri.getPageNum()-1)*cri.getAmount();
			int endIdx = cri.getPageNum()*cri.getAmount()-1;
			int realEndIdx = total-1;
			if(startIdx>realEndIdx) {
				if((startIdx-=cri.getAmount())<0) {
					startIdx+=cri.getAmount();
				}
				endIdx = realEndIdx;
			}
			if(endIdx>realEndIdx) {
				endIdx = realEndIdx;
			}
			utdList = utdList.subList(startIdx,endIdx+1);
			log.info("startIdx:"+startIdx);
			log.info("endIdx:"+endIdx);
			log.info("realEndIdx:"+realEndIdx);
		}else {
			log.info("no data:utdList");
		}
		log.info("userTicketList:"+utdList.size());
		model.addAttribute("userTicketList",utdList);
		model.addAttribute("pages",pages);
	}
	
	@ResponseBody
	@DeleteMapping("/cancelTicket/{rno}/{snum}")
	public ResponseEntity<String> cancelTicket(@PathVariable String rno,@PathVariable int snum){
		rno = rno.trim();
		String[] rnoArr = rno.split(", ");
		for(String arg:rnoArr) {
			if(arg.contains("R")) {
				service.deleteRoundTripTicket(arg,snum);
			}else {
				service.deleteOneWayTicket(arg);
			}
		}
		return new ResponseEntity<>(rno,HttpStatus.OK);
	}
}
