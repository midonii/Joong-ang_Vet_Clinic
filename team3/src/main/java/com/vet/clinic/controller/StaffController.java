package com.vet.clinic.controller;

import java.util.List;
import java.util.Map;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.vet.clinic.dto.StaffDTO;
import com.vet.clinic.service.StaffService;

@Controller
public class StaffController {

	@Autowired
	private StaffService staffService;

	@GetMapping("/staffList")
	public ModelAndView staffList() {
		ModelAndView mv = new ModelAndView("/admin/staffList");

		List<StaffDTO> staffList = staffService.staffList();

		mv.addObject("staffList", staffList);
		return mv;
	}

	@ResponseBody
	@PostMapping(value = "/staffDetail", produces = "application/json;charset=UTF-8")
	public String staffDetail(@RequestParam(name = "staff_no") int staff_no) {
		JSONObject json = new JSONObject();
		Map<String, Object> detail = staffService.staffDetail(staff_no);
		json.put("result", detail);
		return json.toString();
	}

	@ResponseBody
	@PostMapping("/gradeUpdate")
	public String gradeUpdate(@RequestParam Map<String, Object> map) {
		JSONObject json = new JSONObject();
		int result2 = staffService.gradeUpdate(map);
		json.put("result2", result2);
		Map<String, Object> detail = staffService.staffDetail(Integer.parseInt((String) map.get("staff_no")));
		json.put("result", detail);
		return json.toString();
	}

	@GetMapping("/staffDel")
	public String staffDel(@RequestParam(name = "staff_no") int staff_no) {
		int result = staffService.staffDel(staff_no);
		return "redirect:/staffList";
	}

}
