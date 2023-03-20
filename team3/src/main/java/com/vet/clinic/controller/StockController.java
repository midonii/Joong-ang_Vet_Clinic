package com.vet.clinic.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
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
		//System.out.println(stockList);
		
		List<String> m_company = stockService.m_company();
		//System.out.println(m_company);
		
		List<String> m_subcate = stockService.m_subcate();
		//System.out.println(m_subcate);
		
		
		mv.addObject("stockList", stockList);
		mv.addObject("m_company", m_company);
		mv.addObject("m_subcate", m_subcate);
		
		return mv;
	}
	
	@ResponseBody
	@PostMapping("/stockSelect")
	public String stockSelect(@RequestParam Map<String, Object> paramMap) {
		//System.out.println(paramMap);
		JSONObject json = new JSONObject();
		
		List<Map<String, Object>> searchList = stockService.stockSelect(paramMap);
		//System.out.println(searchList);
		
		json.put("searchList", searchList);

		return json.toString();
	}
}
