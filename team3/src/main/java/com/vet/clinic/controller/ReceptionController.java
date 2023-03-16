package com.vet.clinic.controller;


import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class ReceptionController {

	@GetMapping("/reception")
	public String reception() {
		return "reception/reception";
	}
	
	//접수현황
	@ResponseBody
	@PostMapping(value = "/receiveboard", produces = "application/json;charset=UTF-8")
	public String receiveboard() {
		JSONObject json = new JSONObject();
		
	
		return"";
	}
}
