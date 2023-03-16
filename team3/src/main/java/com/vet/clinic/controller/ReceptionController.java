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

import com.vet.clinic.service.ChartService;

@Controller
public class ReceptionController {

	@Autowired
	private ChartService chartService;

	@GetMapping("/reception")
	public String reception() {
		return "reception/reception";
	}

	@ResponseBody
	@PostMapping(value = "/petSearchAjax", produces = "application/json;charset=UTF-8")
	public String petSearchAjax(@RequestParam("pet_search") String pet_search) {
		JSONObject json = new JSONObject();
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("pet_search", pet_search);
		List<Map<String, Object>> pet = chartService.petSearch(map);
		JSONArray petJ = new JSONArray(pet);
		json.put("pet", petJ);
		return json.toString();
	}

	
	//접수현황
	@ResponseBody
	@PostMapping(value = "/receiveboard", produces = "application/json;charset=UTF-8")
	public String receiveboard() {
		JSONObject json = new JSONObject();
		
	
		return"";
	}
}
