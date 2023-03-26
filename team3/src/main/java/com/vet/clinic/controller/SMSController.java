package com.vet.clinic.controller;

import java.util.Arrays;
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

import com.vet.clinic.dto.SmsDTO;
import com.vet.clinic.dto.SmsResponseDTO;
import com.vet.clinic.dto.SmsSearchDTO;
import com.vet.clinic.service.SMSService;

@Controller
public class SMSController {
	
	@Autowired
	public SMSService smsService;

	@GetMapping("/smsIndex")
	public ModelAndView smsIndex() {
		ModelAndView mv = new ModelAndView("sms/smsIndex");
		
		List<SmsDTO> smsclientlist = smsService.smsclientlist();
		String[] smsFormName = smsService.smsFormName();
		//System.out.println(smsformname[0]);
		List<Map<String, Object>> smsDetail = smsService.smsDetail();
		//System.out.println(smsDetail.get(0));
		
		mv.addObject("clientList", smsclientlist);	// 고객리스트
		mv.addObject("smsFormName", smsFormName);	// 문자양식
		mv.addObject("smsDetail", smsDetail);		// 문자전송내역
		
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
	public String sendSms(@RequestParam(value="receiver") String receiver, SmsDTO smsDTO) throws Exception {
		
		// 받는사람 배열에 담고 각각 한명씩 문자보내기
		String[] toList = receiver.split(" ");
		//System.out.println(Arrays.toString(toList));
		
		Map<String, Object> responseList = new HashMap<String, Object>();
		
		for(int i = 0; i < toList.length; i++) {
			smsDTO.setTo(toList[i]);
			//System.out.println("받는사람 : " + smsDTO.getTo() + " / 내용 : " + smsDTO.getContent());
			
			// 문자 전송하여 결과 reponse에 담기
			SmsResponseDTO response = smsService.sendSms(smsDTO);
			
			// 전송내역 DB저장목적 - responseList에 답기
			responseList.put("to", toList[i]);
			responseList.put("requestTime", response.getRequestTime());
			responseList.put("status", response.getStatusName());
			responseList.put("title", smsDTO.getTitle());
			responseList.put("content", smsDTO.getContent());
			//System.out.println(responseList);
			
			// 문자전송내역 DB에 저장
			smsService.smsDataSave(responseList);
		}
		
		return "redirect:/smsIndex";
	}
	
	@ResponseBody
	@PostMapping(value = "/sms_search_client", produces = "application/json;charset=UTF-8")
	public String searchClient(@RequestParam(value="search_client") String client,
								@RequestParam(value="pet_names") String pet_names ) {
		//System.out.println(client + "/" + pet_names);

		// 받는사람에 있는 pet_name 배열에 넣기
		String[] pet_name = pet_names.split(" ");
		//System.out.println(Arrays.toString(pet_name) );
		
		JSONObject json = new JSONObject();
		
		Map<String, Object> search_param = new HashMap<String, Object>();
		search_param.put("client", client);
		search_param.put("pet_name", pet_name);
		
		List<SmsSearchDTO> search = smsService.searchClient(search_param);
		//System.out.println(search.size());
		
		JSONArray searchArr = new JSONArray(search);
		//System.out.println(searchArr);
		json.put("search_client", searchArr);
		//System.out.println(json.toString());
		
		return json.toString();
	}
	
	
}
