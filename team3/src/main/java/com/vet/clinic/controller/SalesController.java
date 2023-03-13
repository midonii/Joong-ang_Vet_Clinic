package com.vet.clinic.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.vet.clinic.dto.SalesDTO;
import com.vet.clinic.service.SalesService;

@Controller
public class SalesController {
	@Autowired
	private SalesService salesService;
	
	@GetMapping("/sales")
	public ModelAndView sales(@RequestParam Map<String,String> paramap) {
		ModelAndView mv = new ModelAndView("/pay/sales");
		List<Map<String, Object>> list = salesService.salesList(paramap);
		
		mv.addObject("salesList", list);
		mv.addObject("para", paramap);
		return mv;
	}
	

	
	
}
