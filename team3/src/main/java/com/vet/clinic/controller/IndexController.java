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
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.vet.clinic.service.IndexService;

@Controller
public class IndexController {


	@Autowired
	private IndexService indexService;

	@GetMapping("/index")
	public String index(HttpServletRequest request, HttpSession session) {
		if (session.getAttribute("id") == null) {
			return "user/login";
		}
		return "index";
	}

	@ResponseBody
	@PostMapping(value = "/noticeAjax", produces = "application/json;charset=UTF-8")
	public String indexAjax() {
		JSONObject json = new JSONObject();
		List<Map<String, Object>> notice = indexService.noticeList();
		JSONArray noticeJ = new JSONArray(notice);
		json.put("notice", noticeJ);
		return json.toString();
	}

	@ResponseBody
	@PostMapping(value = "/reservindexAjax", produces = "application/json;charset=UTF-8")
	public String reservAjax() {
		JSONObject json = new JSONObject();
		List<Map<String, Object>> reserv = indexService.indexReserv();
		JSONArray reservJ = new JSONArray(reserv);
		json.put("reserv", reservJ);
		return json.toString();
	}

	@ResponseBody
	@PostMapping(value = "/receivepay", produces = "application/json;charset=UTF-8")
	public String receivepay() {
		JSONObject json = new JSONObject();
		List<Map<String, Object>> receivepay = indexService.receivepay();
		JSONArray receivepayJ = new JSONArray(receivepay);
		json.put("receivepay", receivepayJ);
		return json.toString();
	}

	@ResponseBody
	@PostMapping(value = "/petAjax", produces = "application/json;charset=UTF-8")
	public String petAjax(HttpServletRequest request) {
		JSONObject json = new JSONObject();
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("search_value", request.getParameter("search_value"));
		List<Map<String, Object>> pet = indexService.indexPet(map);
		JSONArray petJ = new JSONArray(pet);
		json.put("pet", petJ);
		return json.toString();
	}
}
