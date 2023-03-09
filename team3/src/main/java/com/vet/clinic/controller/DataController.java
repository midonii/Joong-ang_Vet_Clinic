package com.vet.clinic.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.vet.clinic.dto.MedicalDTO;
import com.vet.clinic.dto.StaffDTO;
import com.vet.clinic.service.DataService;
import com.vet.clinic.service.StaffService;

@Controller
public class DataController {

	@Autowired
	private DataService dataService;

	@GetMapping("/medicine")
	public ModelAndView medicineList() {
		ModelAndView mv = new ModelAndView("/admin/medicineList");
		List<MedicalDTO> medicineList = dataService.medicineList();
		mv.addObject("medicineList", medicineList);
		return mv;
	}

	@PostMapping("/medicineAdd")
	public String medicalAdd(@RequestParam Map<String, Object> map) {
		int result = dataService.mediAdd(map);

		return "redirect:/medicine";
	}

	@GetMapping("/medicineDel")
	public String medicineDel(@RequestParam(name = "medical_no") int medical_no) {
		int result = dataService.medicalDel(medical_no);
		return "redirect:/medicine";
	}

	@ResponseBody
	@PostMapping(value = "/medicineDetail", produces = "application/json;charset=UTF-8")
	public String medicineDetail(@RequestParam(name = "medical_no") int medical_no) {
		JSONObject json = new JSONObject();
		Map<String, Object> detail = dataService.medicalDetail(medical_no);
		json.put("result", detail);
		return json.toString();
	}

	@ResponseBody
	@PostMapping("/medicineUpdate")
	public String medicineUpdate(@RequestParam Map<String, Object> map) {
		int result = dataService.medicalUpdate(map);
		JSONObject json = new JSONObject();
		json.put("result", result);
		return json.toString();
	}

	@GetMapping("/inspection")
	public ModelAndView inspectionList() {
		ModelAndView mv = new ModelAndView("/admin/inspectionList");
		List<MedicalDTO> inspectionList = dataService.inspectionList();
		mv.addObject("inspectionList", inspectionList);
		return mv;
	}

	@PostMapping("/inspectionAdd")
	public String inspectionAdd(@RequestParam Map<String, Object> map) {
		int result = dataService.mediAdd(map);
		return "redirect:/inspection";
	}

	@GetMapping("/inspectionDel")
	public String inspectionDel(@RequestParam(name = "medical_no") int medical_no) {
		int result = dataService.medicalDel(medical_no);
		return "redirect:/inspection";
	}

	@ResponseBody
	@PostMapping(value = "/inspectionDetail", produces = "application/json;charset=UTF-8")
	public String inspectionDetail(@RequestParam(name = "medical_no") int medical_no) {
		JSONObject json = new JSONObject();
		Map<String, Object> detail = dataService.medicalDetail(medical_no);
		json.put("result", detail);
		return json.toString();
	}

	@ResponseBody
	@PostMapping("/inspectionUpdate")
	public String inspectionUpdate(@RequestParam Map<String, Object> map) {
		int result = dataService.medicalUpdate(map);
		JSONObject json = new JSONObject();
		json.put("result", result);
		return json.toString();
	}

	@GetMapping("/vaccine")
	public ModelAndView vaccineList() {
		ModelAndView mv = new ModelAndView("/admin/vaccineList");
		List<MedicalDTO> vaccineList = dataService.vaccineList();
		mv.addObject("vaccineList", vaccineList);
		return mv;
	}

	@GetMapping("/vaccineDel")
	public String vaccineDel(@RequestParam(name = "vac_no") int vac_no) {
		int result = dataService.vaccineDel(vac_no);
		return "redirect:/vaccine";
	}

	@ResponseBody
	@PostMapping(value = "/vaccineDetail", produces = "application/json;charset=UTF-8")
	public String vaccineDetail(@RequestParam(name = "vac_no") int vac_no) {
		JSONObject json = new JSONObject();
		Map<String, Object> detail = dataService.vaccineDetail(vac_no);
		json.put("result", detail);

		return json.toString();
	}

	@ResponseBody
	@PostMapping("/vaccineUpdate")
	public String vaccineUpdate(@RequestParam Map<String, Object> map) {
		System.out.println(map);
		int result = dataService.vaccineUpdate(map);
		System.out.println(result);
		JSONObject json = new JSONObject();
		json.put("result", result);
		return json.toString();
	}

	@PostMapping("/vaccineAdd")
	public String vaccineAdd(@RequestParam Map<String, Object> map) {

		int result = dataService.vaccineAdd(map);

		return "redirect:/vaccine";
	}

	@GetMapping("/petType")
	public ModelAndView petTypeList(ModelAndView mv, @RequestParam(value = "pagenum", defaultValue = "1") String pagenum,
			@RequestParam(value = "contentnum", defaultValue = "10") String contentnum) {
		mv = new ModelAndView("/admin/petTypeList");
//		List<MedicalDTO> petTypeList = dataService.petTypeList();
//		mv.addObject("petTypeList", petTypeList);
		dataService.paging(mv, pagenum, contentnum);
		return mv;
	}

	@PostMapping("/petTypeAdd")
	public String petTypeAdd(@RequestParam Map<String, Object> map) {

		int result = dataService.petTypeAdd(map);
		System.err.println(result);

		return "redirect:/petType";
	}

	@GetMapping("/petTypeDel")
	public String petTypeDel(@RequestParam(name = "type_no") int type_no) {
		int result = dataService.petTypeDel(type_no);
		return "redirect:/petType";
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
