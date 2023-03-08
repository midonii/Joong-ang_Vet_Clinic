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

import com.vet.clinic.dto.NoticeDTO;
import com.vet.clinic.service.NoticeService;

import lombok.Getter;

@Controller
public class NoticeController {

	@Autowired
	private NoticeService noticeService;

	@GetMapping("/notice")
	public ModelAndView notice() {
		ModelAndView mv = new ModelAndView("/notice/notice");
		List<NoticeDTO> noticeList = noticeService.noticeList();
		mv.addObject("noticeList", noticeList);
		return mv;
	}
	
	@ResponseBody
	@PostMapping("/noticeWrite")
	public String noticeWrite(@RequestParam Map<String, Object> map,HttpSession session) {
		JSONObject json = new JSONObject();
		map.put("staff_id", session.getAttribute("id"));
		int result = noticeService.noticeWrite(map);
		json.put("result", result);
		return json.toString();
	}
	
	@ResponseBody
	@PostMapping(value = "/noticeDetail", produces = "application/json;charset=UTF-8")
	public String noticeDetail(@RequestParam(name = "notice_no") int notice_no) {
		JSONObject json = new JSONObject();
		Map<String, Object> detail = noticeService.noticeDetail(notice_no);
		json.put("result", detail);
		return json.toString();
	}
}
