package com.vet.clinic.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.ModelAndView;

import com.vet.clinic.dto.PayDTO;
import com.vet.clinic.service.PayService;

@Controller
public class PayController {
	@Autowired
	private PayService payService;
	
	
	@GetMapping("/pay")
	public ModelAndView pay() {
		ModelAndView mv = new ModelAndView("/pay/pay");
		List<PayDTO> list = payService.payList();
		mv.addObject("payList", list);
		
		return mv;
	}
	
	@GetMapping("/printPDF")
	public ModelAndView printPDF() {
		ModelAndView mv = new ModelAndView("/PdfDownView");
		List<PayDTO> list = payService.payList();
		mv.addObject("payList", list);
		
		
		return mv;
	}
}
