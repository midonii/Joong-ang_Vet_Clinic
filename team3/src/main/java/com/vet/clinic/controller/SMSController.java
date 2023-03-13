package com.vet.clinic.controller;

import java.text.DecimalFormat;
import java.util.Arrays;
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
	public String sendSms(@RequestParam(value="receiver") String receiver, MessageDTO messageDTO, Model model) throws Exception {
		
		String[] toList = receiver.split(" ");
		//System.out.println(Arrays.toString(toList));
		
		for(int i = 0; i < toList.length; i++) {
			messageDTO.setTo(toList[i]);
			//System.out.println("받는사람 : " + messageDTO.getTo() + " / 내용 : " + messageDTO.getContent());
			SmsResponseDTO response = smsService.sendSms(messageDTO);
			//System.out.println(response);
		}
		
		JSONObject json = new JSONObject();
		
		/*
		model.addAttribute("response", response);
		return "redirect:/smsIndex";
		*/
		return json.toString();
	}
}
