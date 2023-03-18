package com.vet.clinic.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.vet.clinic.dto.PetDTO;
import com.vet.clinic.service.PetService;

@Controller
public class Chart3Controller {

	@Autowired
	private PetService petService;
	
	@ResponseBody
	@PostMapping(value = "/petVacAjax", produces = "application/json;charset=UTF-8")
	public String petVacAjax(HttpServletRequest request) {
		JSONObject json = new JSONObject();
		PetDTO petDTO = new PetDTO();
		petDTO.setPetNo(request.getParameter("pet_no"));
		List<PetDTO> petVaccine = petService.petVaccine(petDTO);
		JSONArray petJ = new JSONArray(petVaccine);
		json.put("pet", petJ);
		
//		System.out.println(json.toString());
		
		return json.toString();
	}
}
