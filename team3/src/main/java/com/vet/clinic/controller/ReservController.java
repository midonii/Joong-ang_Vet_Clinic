package com.vet.clinic.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.vet.clinic.dto.ReservDTO;
import com.vet.clinic.service.ReservService;


@Controller
public class ReservController {

	@Autowired
	private ReservService reservService;
	
	@GetMapping("/reserv")
	@ResponseBody
	public ModelAndView reserv(HttpServletRequest request) {
		
		ModelAndView mv = new ModelAndView("reservation/reserv");
		
		 ReservDTO reservDTO = new ReservDTO();
		 reservDTO.setSearch_value(request.getParameter("search_value"));
		 List<ReservDTO> searchlist = reservService.searchlist(reservDTO);
		 mv.addObject("searchlist", searchlist);//리스트 + 검색리스트
		 
		List<ReservDTO> boardlist = reservService.boardlist(reservDTO);
		mv.addObject("boardlist", boardlist);//리스트 + 검색리스트
		return mv;
	}
	
	@GetMapping("/calender")
	public String calender() {

		return "/reservation/calender";
	}
	


}	
