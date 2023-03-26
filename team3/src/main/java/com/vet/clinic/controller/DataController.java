package com.vet.clinic.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.vet.clinic.dto.SearchDTO;
import com.vet.clinic.service.DataService;

@Controller
public class DataController {

	@Autowired
	private DataService dataService;

	@GetMapping("/medicine")
	public ModelAndView medicineList(ModelAndView mv,
			@RequestParam(value = "pagenum", defaultValue = "1") String pagenum,
			@RequestParam(value = "contentnum", defaultValue = "10") String contentnum,
			@RequestParam(value = "table", defaultValue = "medicalList") String table,
			@RequestParam(value = "category", defaultValue = "약품") String category, HttpServletRequest request) {
		mv = new ModelAndView("/admin/medicineList");
		SearchDTO searchDTO = new SearchDTO();
		searchDTO.setSearch_value(request.getParameter("search_value"));
		searchDTO.setSearch_name(request.getParameter("search_name"));
		searchDTO.setTable(table);
		searchDTO.setCategory(category);
		dataService.paging(mv, pagenum, contentnum, searchDTO);
		List<String> subcate = dataService.category(searchDTO);
		mv.addObject("subcate", subcate);
		return mv;
	}

	@GetMapping("/inspection")
	public ModelAndView inspectionList(ModelAndView mv,
			@RequestParam(value = "pagenum", defaultValue = "1") String pagenum,
			@RequestParam(value = "contentnum", defaultValue = "10") String contentnum,
			@RequestParam(value = "table", defaultValue = "medicalList") String table,
			@RequestParam(value = "category", defaultValue = "진료") String category, HttpServletRequest request) {
		mv = new ModelAndView("/admin/inspectionList");
		SearchDTO searchDTO = new SearchDTO();
		searchDTO.setSearch_value(request.getParameter("search_value"));
		searchDTO.setSearch_name(request.getParameter("search_name"));
		searchDTO.setTable(table);
		searchDTO.setCategory(category);
		dataService.paging(mv, pagenum, contentnum, searchDTO);
		List<String> subcate = dataService.category(searchDTO);
		mv.addObject("subcate", subcate);
		return mv;
	}

	@GetMapping("/vaccine")
	public ModelAndView vaccineList(ModelAndView mv,
			@RequestParam(value = "pagenum", defaultValue = "1") String pagenum,
			@RequestParam(value = "contentnum", defaultValue = "10") String contentnum,
			@RequestParam(value = "table", defaultValue = "medicalList") String table,
			@RequestParam(value = "category", defaultValue = "접종") String category, HttpServletRequest request) {
		mv = new ModelAndView("/admin/vaccineList");

		SearchDTO searchDTO = new SearchDTO();
		searchDTO.setSearch_value(request.getParameter("search_value"));
		searchDTO.setSearch_name(request.getParameter("search_name"));
		searchDTO.setTable(table);
		searchDTO.setCategory(category);
		dataService.paging(mv, pagenum, contentnum, searchDTO);
		return mv;
	}

	@GetMapping("/petType")
	public ModelAndView petTypeList(ModelAndView mv,
			@RequestParam(value = "pagenum", defaultValue = "1") String pagenum,
			@RequestParam(value = "contentnum", defaultValue = "10") String contentnum,
			@RequestParam(value = "table", defaultValue = "petType") String table, HttpServletRequest request) {
		mv = new ModelAndView("/admin/petTypeList");

		SearchDTO searchDTO = new SearchDTO();
		searchDTO.setSearch_value(request.getParameter("search_value"));
		searchDTO.setTable(table);
		dataService.paging(mv, pagenum, contentnum, searchDTO);
		return mv;
	}

	@PostMapping("/medicineAdd")
	public String medicalAdd(@RequestParam Map<String, Object> map) {
		int result = dataService.mediAdd(map);

		return "redirect:/medicine";
	}

	@ResponseBody
	@PostMapping(value = "/medicalDel", produces = "application/json;charset=UTF-8")
	public String medicalDel(@RequestParam(name = "medical_no") int medical_no) {
		JSONObject json = new JSONObject();
		int result = dataService.medicalDel(medical_no);
		json.put("result", result);
		return json.toString();
	}

	@ResponseBody
	@PostMapping(value = "/medicalDetail", produces = "application/json;charset=UTF-8")
	public String medicalDetail(@RequestParam(name = "medical_no") int medical_no) {
		JSONObject json = new JSONObject();
		Map<String, Object> detail = dataService.medicalDetail(medical_no);
		json.put("result", detail);
		return json.toString();
	}

	@ResponseBody
	@PostMapping("/medicalUpdate")
	public String medicalUpdate(@RequestParam Map<String, Object> map) {
		int result = dataService.medicalUpdate(map);
		JSONObject json = new JSONObject();
		json.put("result", result);
		return json.toString();
	}

	@PostMapping("/inspectionAdd")
	public String inspectionAdd(@RequestParam Map<String, Object> map) {
		int result = dataService.mediAdd(map);
		return "redirect:/inspection";
	}


	@PostMapping("/vaccineAdd")
	public String vaccineAdd(@RequestParam Map<String, Object> map) {

		int result = dataService.mediAdd(map);

		return "redirect:/vaccine";
	}

	@PostMapping("/petTypeAdd")
	public String petTypeAdd(@RequestParam Map<String, Object> map) {

		int result = dataService.petTypeAdd(map);

		return "redirect:/petType";
	}

	@ResponseBody
	@PostMapping(value = "/petTypeDel", produces = "application/json;charset=UTF-8")
	public String petTypeDel(@RequestParam(name = "type_no") int type_no) {
		JSONObject json = new JSONObject();
		int result = dataService.petTypeDel(type_no);
		json.put("result", result);
		return json.toString();
	}

	@ResponseBody
	@PostMapping(value = "/petTypeDetail", produces = "application/json;charset=UTF-8")
	public String petTypeDetail(@RequestParam(name = "type_no") int type_no) {
		JSONObject json = new JSONObject();
		Map<String, Object> detail = dataService.petTypeDetail(type_no);
		json.put("result", detail);

		return json.toString();
	}

	@ResponseBody
	@PostMapping("/petTypeUpdate")
	public String petTypeUpdate(@RequestParam Map<String, Object> map) {
		int result = dataService.petTypeUpdate(map);
		JSONObject json = new JSONObject();
		json.put("result", result);// json에 값을 담아서 보냄
		return json.toString();
	}
}
