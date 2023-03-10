package com.vet.clinic.controller;

import java.sql.Array;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.vet.clinic.dto.SMSDTO;
import com.vet.clinic.service.SMSService;

@Controller
public class SMSController {
	
	@Autowired
	public SMSService smsService;

	@GetMapping("/smsIndex")
	public ModelAndView smsIndex() {
		ModelAndView mv = new ModelAndView("sms/smsIndex");
		
		List<SMSDTO> smsclientlist = smsService.smsclientlist();
		String[] smsformname = smsService.smsformname();
		//System.out.println(smsformname[0]);
		mv.addObject("clientList", smsclientlist);
		mv.addObject("smsformname", smsformname);
		
		return mv;
	}
	
	@ResponseBody
	@GetMapping("/smsform")
	public String smsform(@RequestParam(value="smsform_no") int smsform_no) {
		
		//Map<String, Object> smsform = new HashMap<String, Object>();
		Map<String, Object> smsform = smsService.smsform(smsform_no);
		
		JSONObject json = new JSONObject();
		json.put("smsform", smsform);
		
		//System.out.println(json);
		
		return json.toString();
	}
	
	@PostMapping("/smsform_set")
	public String smsform_set(@RequestParam Map<String, String> map) {
		
		System.out.println(map);
		
		int result = smsService.smsform_set(map);
		System.out.println(result);
		
		return "redirect:/smsIndex";
	}
}
