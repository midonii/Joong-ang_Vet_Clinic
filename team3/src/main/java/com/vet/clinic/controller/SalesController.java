package com.vet.clinic.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.vet.clinic.dto.PageDTO;
import com.vet.clinic.service.SalesService;

@Controller
public class SalesController {
	@Autowired
	private SalesService salesService;
	
	@GetMapping("/sales")
	public ModelAndView sales(ModelAndView mv, @RequestParam(value="pagenum",defaultValue = "1") String pagenum ,
			@RequestParam(value = "contentnum", defaultValue = "10") String contentnum, @RequestParam Map<String,String> paramap) {
	    mv = new ModelAndView("/pay/sales");
	    
	    PageDTO pageDTO = new PageDTO();
	    pageDTO.setToDate(paramap.get("toDate"));
	    pageDTO.setFromDate(paramap.get("fromDate"));
	    
		salesService.salesList(mv,pagenum,contentnum,pageDTO);
		List<Map<String, Object>> list2 = salesService.salesList2(paramap); //구글차트용
		
		int payTotalPrice2 = 0; // 합계 구하기 
		for (int i = 0; i < list2.size(); i++) {
		payTotalPrice2 +=
		Integer.parseInt((String.valueOf(list2.get(i).get("totalPrice")))); }
		  
		mv.addObject("payTotalPrice2", payTotalPrice2);
		mv.addObject("salesList2", list2);
		return mv;
	}
	

	
	
}
