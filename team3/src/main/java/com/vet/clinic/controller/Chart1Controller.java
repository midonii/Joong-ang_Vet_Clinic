package com.vet.clinic.controller;

import java.util.List;
import java.util.Map;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.vet.clinic.service.Chart1Service;

@Controller
public class Chart1Controller {

	@Autowired
	private Chart1Service chartService;
	
	@ResponseBody
	@GetMapping(value="/petdetailAjax", produces = "application/json;charset=UTF-8")
	public String petdetailAjax(@RequestParam("receiveno") String receiveno){
		JSONObject json = new JSONObject();
		Map<String, Object> map = chartService.petdetailAjax(receiveno);
		
		json.put("result", map);
		return json.toString();
	}
	
	
	  @ResponseBody
	  @GetMapping(value = "/prescAjax", produces= "application/json;charset=UTF-8")
	  public String prescAjax() { 
		 JSONObject json = new JSONObject();
		 List<Map<String, Object>> mapmedi = chartService.prescAjax(); //medicalList 리스트화
		 List<Map<String, Object>> mapvac = chartService.prescAjaxvac(); //vaccine 리스트화
		 
		 json.put("prescList", mapmedi);
		 json.put("prescVacList", mapvac);
	  return json.toString(); }
	 
	
	
}
