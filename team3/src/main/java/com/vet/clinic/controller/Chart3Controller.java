package com.vet.clinic.controller;

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
			json.put("result", result);
			json.put("stateUpdate", stateUpdate);
		} else {
			json.put("result", 0);
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
		List<PetDTO> petExam = petService.petExam(petDTO);
		List<PetDTO> petDrug = petService.petDrug(petDTO);
		List<PetDTO> petVac = petService.petVac(petDTO);
		JSONArray petChartJ = new JSONArray(petChart);
		JSONArray petExamJ = new JSONArray(petExam);
		JSONArray petDrugJ = new JSONArray(petDrug);
		JSONArray petVacJ = new JSONArray(petVac);
		json.put("chart", petChartJ);
		json.put("petExam", petExamJ);
		json.put("petDrug", petDrugJ);
		json.put("petVac", petVacJ);
		return json.toString();
	}

	@ResponseBody
	@PostMapping(value = "/preAjax", produces = "application/json;charset=UTF-8")
	public String preAjax(HttpServletRequest request) {
		JSONObject json = new JSONObject();
		PetDTO petDTO = new PetDTO();
		petDTO.setPetNo(request.getParameter("pet_no"));
		petDTO.setChartNo(request.getParameter("chart_no"));
		List<PetDTO> petExam = petService.petExam(petDTO);
		List<PetDTO> petDrug = petService.petDrug(petDTO);
		List<PetDTO> petVac = petService.petVac(petDTO);
		JSONArray petExamJ = new JSONArray(petExam);
		JSONArray petDrugJ = new JSONArray(petDrug);
		JSONArray petVacJ = new JSONArray(petVac);
		json.put("petExam", petExamJ);
		json.put("petDrug", petDrugJ);
		json.put("petVac", petVacJ);
		return json.toString();
	}
}
