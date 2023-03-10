package com.vet.clinic.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.vet.clinic.dto.PayDTO;
import com.vet.clinic.service.PayService;

@Controller
public class PayController {
	@Autowired
	private PayService payService;
	
	
	
	@GetMapping("/pay")
	public ModelAndView pay(Criteria cri, HttpServletRequest request) {
		ModelAndView mv = new ModelAndView("/pay/pay");
		/* List<PayDTO> list = payService.payList(); */
//------페이징 
		//1.전체 글수
		int totalCount = payService.totalCount();
		System.out.println("수납 전체 데이터 갯수 : "+ totalCount);
		
		Paging paging = new Paging();
		paging.setCri(cri);
		paging.setTotalCount(totalCount);
		
		
		
//------기간조회 /pay?fromDate=2023-03-08&toDate=2023-03-09
		String fromDate = request.getParameter("fromDate");
		String toDate = request.getParameter("toDate");
		cri.setFromDate(fromDate);
		cri.setToDate(toDate);
		
//----- 검색 /pay?search_name=petname&search_content=양우		
		String search_name = request.getParameter("search_name");
		String search_content = request.getParameter("search_content");
		cri.setSearch_name(search_name);
		cri.setSearch_content(search_content);
//----- 당일 검색 /pay?todayDate=2023-03-09
		String todayDate = request.getParameter("todayDate");
		cri.setTodayDate(todayDate);
		
		//페이징+기간조회까지 담아서 보내기
		List<Map<String, Object>> list = payService.payList(cri);
		
		mv.addObject("cri", cri);
		mv.addObject("payList", list);
		mv.addObject("paging", paging);

		return mv;
	}

	@GetMapping("/payDetail")
	public ModelAndView payDetail(@RequestParam("payNo") int payNo) {
		ModelAndView mv = new ModelAndView("/pay/payDetail");
		PayDTO dto = new PayDTO();
		dto.setPay_no(payNo);
		dto = payService.payDetail(payNo);
		mv.addObject("detail", dto);
		return mv;
	}
	
	@PostMapping(value="/payBefore" , produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String payBefore(@RequestParam("payno") int payNo) {
		int result = payService.payBefore(payNo);
		
		System.err.println(result);
		JSONObject json = new JSONObject();
		json.put("result", result);
		return json.toString();
	}
	@PostMapping(value="/payCancel" , produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String payCancel(@RequestParam("payno") int payNo) {
		int result = payService.payCancel(payNo);
		
		System.err.println(result);
		JSONObject json = new JSONObject();
		json.put("result", result);
		return json.toString();
	}

	
	
	

	
	
	
	
	
	
	
	
	
}
