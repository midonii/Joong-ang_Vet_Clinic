package com.vet.clinic.controller;

import javax.servlet.http.HttpServletRequest;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.vet.clinic.dto.PageDTO;
import com.vet.clinic.dto.PayDTO;
import com.vet.clinic.service.PayService;

@Controller
public class PayController {
	@Autowired
	private PayService payService;
	
	
	
	@GetMapping("/pay")
	public ModelAndView pay(ModelAndView mv, @RequestParam(value="pagenum",defaultValue = "1") String pagenum ,
			@RequestParam(value = "contentnum", defaultValue = "10") String contentnum,HttpServletRequest request) {
		
		mv = new ModelAndView("/pay/pay");
		PageDTO pageDTO = new PageDTO();
		pageDTO.setToDate(request.getParameter("toDate"));
		pageDTO.setFromDate(request.getParameter("fromDate"));
		pageDTO.setTodayDate(request.getParameter("todayDate"));
		pageDTO.setSearch_name(request.getParameter("search_name"));
		pageDTO.setSearch_value(request.getParameter("search_value"));
		pageDTO.setPay_yn(request.getParameter("pay_yn"));
		
		payService.paging(mv,pagenum,contentnum,pageDTO);
		
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
		
		JSONObject json = new JSONObject();
		json.put("result", result);
		return json.toString();
	}
	@PostMapping(value="/payCancel" , produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String payCancel(@RequestParam("payno") int payNo) {
		int result = payService.payCancel(payNo);
		
		JSONObject json = new JSONObject();
		json.put("result", result);
		return json.toString();
	}


	
	
	
	
	
	
	
	
	
}
