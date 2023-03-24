package com.vet.clinic.controller;

import java.util.Arrays;
import java.util.HashMap;
import java.util.Iterator;
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
import com.vet.clinic.service.Chart1Service;

@Controller
public class Chart1Controller {

	@Autowired
	private Chart1Service chartService;
	
	@ResponseBody
	@GetMapping(value="/petdetailAjax", produces = "application/json;charset=UTF-8")
	public String petdetailAjax(@RequestParam("receiveno") String receiveno){
		JSONObject json = new JSONObject();
		Map<String, Object> map = chartService.petdetailAjax(receiveno);
		
		json.put("result", map);
		return json.toString();
	}
	
	  @ResponseBody
	  @GetMapping(value ="/prescAjax", produces= "application/json;charset=UTF-8")
	  public String prescAjax(HttpServletRequest request) { 
		  
		  SearchDTO searchDTO = new SearchDTO();
		  searchDTO.setSearch_name(request.getParameter("search_name"));
		  searchDTO.setSearch_value(request.getParameter("search_value"));
		 
		  JSONObject json = new JSONObject();

		  List<Map<String, Object>> prescList = chartService.prescAjax(searchDTO); //medicalList 리스트화
			 
		  json.put("prescList", prescList);
		 
	  return json.toString(); 
		 
	  
	  }
	 
	//모달내 저장버튼 -> 진료화면에 선택된 데이터출력
	  @ResponseBody
	  @PostMapping(value="/prescSaveAjax",  produces= "application/json;charset=UTF-8")
	  public String prescSaveAjax(@RequestParam(value="rightno[]") String[] rightno){
		  	
		  Map<String, Object> rightno_map = new HashMap<String, Object>();
		  rightno_map.put("rightno", rightno);
		 
		  List<Map<String, Object>> saveList = chartService.prescSaveAjax(rightno_map);
		  
		 // System.err.println(saveList);
		  JSONObject json = new JSONObject();
		  
		  json.put("saveList", saveList);
		  return json.toString();
	  }
	
}
