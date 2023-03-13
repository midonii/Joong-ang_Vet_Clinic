package com.vet.clinic.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

import com.vet.clinic.dto.PetDTO;
import com.vet.clinic.service.PetService;

@Controller
public class PetController {
	
	@Resource(name = "petService")
	private PetService petService;
	
	@GetMapping("petinfo")
	public ModelAndView petdetail(HttpServletRequest request) {
		ModelAndView mv = new ModelAndView("client/petinfo");
		System.err.println(request.getParameter("petNo"));
		
		PetDTO petDTO = new PetDTO();
		petDTO.setPetNo(request.getParameter("petNo"));
		
		List<PetDTO> petInfo = petService.petInfo(petDTO);
		
		mv.addObject("petInfo",petInfo);
		
		return mv;
	}

}
