package com.vet.clinic.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

import com.vet.clinic.dto.StockDTO;
import com.vet.clinic.service.StockService;

@Controller
public class StockController {
	
	@Autowired
	private StockService stockService;

	
	@GetMapping("/stockList")
	public ModelAndView stockList() {
		ModelAndView mv = new ModelAndView("admin/stockList");
		
		List<StockDTO> stockList = stockService.stockList();
		System.out.println(stockList);
		
		List<String> m_company = stockService.m_company();
		System.out.println(m_company);
		
		List<String> m_subcate = stockService.m_subcate();
		System.out.println(m_subcate);
		
		
		mv.addObject("stockList", stockList);
		mv.addObject("m_company", m_company);
		
		return mv;
	}
}
