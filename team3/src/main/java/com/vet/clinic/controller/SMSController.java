package com.vet.clinic.controller;

import java.text.DecimalFormat;
import java.util.List;
import java.util.Map;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.sun.source.tree.DoWhileLoopTree;
import com.vet.clinic.dto.MessageDTO;
import com.vet.clinic.dto.SMSDTO;
import com.vet.clinic.dto.SmsResponseDTO;
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
	
	@PostMapping("/smsform_setdel")
	public String smsform_setdel(@RequestParam Map<String, String> map) {
		
		//System.out.println(map);
		
		smsService.smsform_setdel(map);
		
		return "redirect:/smsIndex";
	}
	
	@GetMapping("/send")
	public String getSmsPage() {
		return "redirect:/smsIndex";
	}
	
	@PostMapping("/sendSms")
	public String sendSms(MessageDTO messageDTO, Model model) throws Exception {
		String to = messageDTO.getTo();
		String content = messageDTO.getContent();
		System.out.println("받는사람 : " + to + " / 내용 : " + content);
		/*
		if( to.length() > 11 ) {
			DecimalFormat comma = new DecimalFormat("###########,###########");
			to = comma.format(to);
			System.out.println(to);
		}
		*/
		JSONObject json = new JSONObject();
		SmsResponseDTO response = smsService.sendSms(messageDTO);
		System.out.println(response);
		/*
		
		model.addAttribute("response", response);
		return "redirect:/smsIndex";
		*/
		return json.toString();
	}
}
