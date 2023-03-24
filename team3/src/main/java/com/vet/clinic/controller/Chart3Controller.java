package com.vet.clinic.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.vet.clinic.dto.PetDTO;
import com.vet.clinic.service.Chart3Service;
import com.vet.clinic.service.PetService;

@Controller
public class Chart3Controller {

	@Autowired
	private PetService petService;
	@Autowired
	private Chart3Service chart3Service;

	@ResponseBody
	@PostMapping("/chartAdd")
	public String chartAdd(@RequestParam Map<String, Object> map, HttpSession session) {
		JSONObject json = new JSONObject();
		if (session.getAttribute("staff_grade").equals("doctor")) {
			map.put("staff_id", session.getAttribute("id"));
			int result = chart3Service.chartAdd(map);
			int stateUpdate = chart3Service.stateUpdate(map);

			Map<String, Object> payMap = new HashMap<String, Object>();
			String chartNo = chart3Service.chartNo(map);
			payMap.put("chart_no", chartNo);
			payMap.put("receive_no", map.get("receive_no"));
			int payAdd = chart3Service.payAdd(payMap);
			json.put("result", result);
			json.put("stateUpdate", stateUpdate);
			json.put("payAdd", payAdd);
		} else {
			json.put("result", 0);
			json.put("stateUpdate", 0);
			json.put("payAdd", 0);
		}
		return json.toString();
	}
	@ResponseBody
	@PostMapping("/chartUpdate")
	public String chartUpdate(@RequestParam Map<String, Object> map, HttpSession session) {
		JSONObject json = new JSONObject();
		if (session.getAttribute("staff_grade").equals("doctor")) {
			map.put("staff_id", session.getAttribute("id"));
			int result = chart3Service.chartUpdate(map);
			json.put("result", result);
		} else {
			json.put("result", 0);
		}
		return json.toString();
	}

	@ResponseBody
	@PostMapping(value = "/petVacAjax", produces = "application/json;charset=UTF-8")
	public String petVacAjax(HttpServletRequest request) {
		JSONObject json = new JSONObject();
		PetDTO petDTO = new PetDTO();
		petDTO.setPetNo(request.getParameter("pet_no"));
		List<PetDTO> petVaccine = petService.petVaccine(petDTO);
		JSONArray petJ = new JSONArray(petVaccine);
		json.put("pet", petJ);
		return json.toString();
	}

	@ResponseBody
	@PostMapping(value = "/chartAjax", produces = "application/json;charset=UTF-8")
	public String chartAjax(HttpServletRequest request) {
		JSONObject json = new JSONObject();
		PetDTO petDTO = new PetDTO();
		petDTO.setPetNo(request.getParameter("pet_no"));
		List<PetDTO> petChart = petService.petChart(petDTO);
		JSONArray petChartJ = new JSONArray(petChart);
		json.put("chart", petChartJ);
		return json.toString();
	}

	@ResponseBody
	@PostMapping(value = "/CDetailAjax", produces = "application/json;charset=UTF-8")
	public String CDetailAjax(HttpServletRequest request) {
		JSONObject json = new JSONObject();
		PetDTO petDTO = new PetDTO();
		petDTO.setChartNo(request.getParameter("chart_no"));
		petDTO.setPetNo(request.getParameter("pet_no"));
		List<PetDTO> petChart = chart3Service.petChart(petDTO);
		JSONArray petChartJ = new JSONArray(petChart);
		List<PetDTO> petMedicalData = petService.petMedicalData(petDTO);
		JSONArray jsonA = new JSONArray(petMedicalData);
		json.put("petMedicalData", petMedicalData);
		json.put("chart", petChartJ);
		return json.toString();
	}

	@ResponseBody
	@PostMapping(value = "/preAjax", produces = "application/json;charset=UTF-8")
	public String preAjax(HttpServletRequest request) {
		JSONObject json = new JSONObject();
		PetDTO petDTO = new PetDTO();
		petDTO.setPetNo(request.getParameter("pet_no"));
		petDTO.setChartNo(request.getParameter("chart_no"));
		List<PetDTO> petMedicalData = petService.petMedicalData(petDTO);
		JSONArray jsonA = new JSONArray(petMedicalData);
		json.put("petMedicalData", petMedicalData);
		return json.toString();
	}
}
