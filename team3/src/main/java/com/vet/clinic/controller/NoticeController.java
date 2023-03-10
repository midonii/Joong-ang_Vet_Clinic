package com.vet.clinic.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.vet.clinic.dto.SearchDTO;
import com.vet.clinic.service.NoticeService;

import lombok.Getter;

@Controller
public class NoticeController {

	@Autowired
	private NoticeService noticeService;

	@GetMapping("/notice")
	public ModelAndView notice(ModelAndView mv, @RequestParam(value = "pagenum", defaultValue = "1") String pagenum,
			@RequestParam(value = "contentnum", defaultValue = "10") String contentnum, HttpServletRequest request) {
		mv = new ModelAndView("/notice/notice");
		SearchDTO searchDTO = new SearchDTO();
		searchDTO.setSearch_name(request.getParameter("search_name"));
		searchDTO.setSearch_value(request.getParameter("search_value"));
		noticeService.paging(mv, pagenum, contentnum,searchDTO);
		return mv;
	}

	@ResponseBody
	@PostMapping("/noticeWrite")
	public String noticeWrite(@RequestParam Map<String, Object> map, HttpSession session) {
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
		int read = noticeService.noticeRead(notice_no);
		Map<String, Object> detail = noticeService.noticeDetail(notice_no);
		json.put("read", read);
		json.put("result", detail);
		return json.toString();
	}

	@ResponseBody
	@PostMapping(value = "/noticeDetailU", produces = "application/json;charset=UTF-8")
	public String noticeDetailU(@RequestParam(name = "notice_no") int notice_no) {
		JSONObject json = new JSONObject();
		Map<String, Object> detail = noticeService.noticeDetail(notice_no);
		json.put("result", detail);
		return json.toString();
	}

	@ResponseBody
	@PostMapping(value = "/noticeUpdate", produces = "application/json;charset=UTF-8")
	public String noticeUpdate(@RequestParam Map<String, Object> map) {
		JSONObject json = new JSONObject();
		int result2 = noticeService.noticeUpdate(map);
		Map<String, Object> detail = noticeService.noticeDetail(Integer.parseInt((String) map.get("notice_no")));
		json.put("result2", result2);
		json.put("result", detail);
		return json.toString();
	}

	@ResponseBody
	@PostMapping(value = "/noticeDelete", produces = "application/json;charset=UTF-8")
	public String noticeDelete(@RequestParam(name = "notice_no") int notice_no) {
		JSONObject json = new JSONObject();
		int result = noticeService.noticeDelete(notice_no);
		json.put("result", result);
		return json.toString();
	}
}
