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
import com.vet.clinic.dto.StockPageDTO;
import com.vet.clinic.service.StockService;

@Controller
public class StockController {
	
	@Autowired
	private StockService stockService;
	
	@GetMapping("/stockList")
	public ModelAndView stockList(
			@RequestParam(value="pagenum", defaultValue = "1") int pagenum,
			@RequestParam(value="contentnum", defaultValue = "14") int contentnum) {
		
		ModelAndView mv = new ModelAndView("admin/stockList");
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("pagenum", pagenum-1);
		map.put("contentnum", contentnum);
		map.put("firstnumInPage", (pagenum - 1) * contentnum );
		
	// 전체리스트
		List<StockDTO> stockList = stockService.stockList(map);
		// System.out.println(stockList);
		mv.addObject("stockList", stockList);
		
	// 카테고리radio리스트
		List<String> m_subcate = stockService.m_subcate();
		//System.out.println(m_subcate);
		mv.addObject("m_subcate", m_subcate);
		
	// 구매처명select리스트
		List<String> m_company = stockService.m_company();
		//System.out.println(m_company);
		mv.addObject("m_company", m_company);
		
	// 페이징
		stockService.paging(mv, pagenum, contentnum);
		
		return mv;
	}
	
	@ResponseBody
	@PostMapping("/paging")
	public String paging(@RequestParam Map<String, Object> map) {
		
		JSONObject json = new JSONObject();
		StockPageDTO pageDTO = new StockPageDTO();
		
		int pagenum = Integer.parseInt((String) map.get("pagenum"));
		int contentnum = Integer.parseInt((String) map.get("contentnum"));
		
		pageDTO.setPagenum(pagenum);
		pageDTO.setContentnum(contentnum);
		pageDTO.setPageindex(pagenum);
		pageDTO.setFirstnumInPage(contentnum);
		
		map.put("firstnumInPage", pageDTO.getFirstnumInPage() );
		map.put("contentnum", contentnum);
		System.out.println("controller-map : " + map.get("firstnumInPage"));
		System.out.println(map);
		
		List<StockDTO> stockList = stockService.stockList(map);
		System.out.println(stockList);
		
		
		return json.toString();
	}
	
	@ResponseBody
	@PostMapping("/stockSelect")
	public String stockSelect(@RequestParam Map<String, Object> paramMap) {
		//System.out.println(paramMap);
		JSONObject json = new JSONObject();
		
	// 검색 리스트
		if(paramMap.get("fromDate") == "" || paramMap.get("toDate") == "") {
			List<Map<String, Object>> searchList = stockService.stockSelect(paramMap);
			//System.out.println(searchList);
			json.put("searchList", searchList);
			return json.toString();
		} else {
			List<Map<String, Object>> searchList = stockService.stockDateSelect(paramMap);
			//System.out.println(searchList);
			json.put("searchList", searchList);
			return json.toString();
		}
		
		
	}
	
	@ResponseBody
	@PostMapping("/edit")
	public String edit(@RequestParam Map<String, Object> paramMap) {
		//System.out.println(paramMap);
		
		JSONObject json = new JSONObject();
		
		int saveResult = stockService.edit(paramMap);
		
		json.put("result", saveResult);
		
		return json.toString();
	}

	
}
