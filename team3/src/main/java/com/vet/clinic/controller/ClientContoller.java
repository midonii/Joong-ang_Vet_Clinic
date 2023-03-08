package com.vet.clinic.controller;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.vet.clinic.dto.ClientDTO;
import com.vet.clinic.service.ClientService;

@Controller
public class ClientContoller {
	
	@Resource(name = "clientService")
	private ClientService clientService;
	
	//회원관리 페이지 보기
	@GetMapping("profile")
	public ModelAndView profile() {
		
		ModelAndView mv = new ModelAndView("client/profile");

		
		List<ClientDTO> clientList = clientService.clientList();
		List<ClientDTO> petList = clientService.petList();
		
		mv.addObject("clientList",clientList);
		mv.addObject("petList",petList);
		
		return mv;
	}
	
	//보호자 더블클릭 시 해당 보호자의 반려견만 출력
	@ResponseBody
	@PostMapping(value = "profileMap", produces = "application/json;charset=UTF-8")
	public String profileMap(HttpServletRequest request) {
	
		System.out.println(request.getParameter("clientNno"));
		
		ClientDTO client = new ClientDTO();
		client.setClientNno(request.getParameter("clientNno"));
		JSONObject result = new JSONObject();

		if ((String)request.getParameter("clientNno") != null) {

			List<ClientDTO> profile = clientService.profileMap(client);
																						
			//array json
			JSONArray jsonA = new JSONArray(profile);
			
			result.put("result",profile);
			System.out.println(result.toString());
		} else {
			result.put("result", 0);
		}
		return result.toString();
	}
	
	//보호자 상세보기
	@ResponseBody
	@PostMapping(value="clientDetailAjax", produces = "application/json;charset=UTF-8")
	public String noticeDetailAjax(HttpServletRequest request) {
		//System.err.println(request.getParameter("detailNo"));

		ClientDTO client = new ClientDTO();
		client.setDetailNo(request.getParameter("detailNo"));		
		JSONObject json = new JSONObject();

		if ((String)request.getParameter("detailNo") != null) {
			
			List<ClientDTO> detail = clientService.clientDetailAjax(client); 
			
			//array json
			JSONArray jsonA = new JSONArray(detail);
																						
			json.put("result", detail);
			System.out.println(json.toString());
		} else {
			json.put("result", 0);
		}
			return json.toString();
	}
	
	//보호자 삭제(삭제 시 반려견 정보도 함께 삭제됨)
	@GetMapping("clientDelete")
	public String clientDelete(HttpServletRequest request) {
		System.out.println(request.getParameter("clientNo"));
		
		ClientDTO client = new ClientDTO();
		client.setClientNo(request.getParameter("clientNo"));
		
		int result = clientService.cilentPetDel(client);
		result = clientService.clientDel(client);
		System.out.println("처리결과는 : " + result);
		
		return "redirect:profile";
	}
	
	//반려견 정보 삭제
	@GetMapping("petDelete")
	public String petDelete(HttpServletRequest request) {
		System.out.println(request.getParameter("petNo"));
		
		ClientDTO client = new ClientDTO();
		client.setPetNo(request.getParameter("petNo"));
		
		int result = clientService.petDel(client);
		System.out.println("처리결과는 : " + result);
		
		return "redirect:profile";
	}
	
	//보호자 추가
	@PostMapping("clientAdd")
	public String clientAdd(HttpServletRequest request) {
		System.out.println(request.getParameter("floatingClientName"));
		System.out.println(request.getParameter("floatingClientEmail"));
		System.out.println(request.getParameter("floatingClientTel"));
		System.out.println(request.getParameter("floatingClientAddr"));
		System.out.println(request.getParameter("smsAgree"));
		System.out.println(request.getParameter("floatingClientComments"));
		
		ClientDTO client = new ClientDTO();
		client.setFloatingClientName(request.getParameter("floatingClientName"));
		client.setFloatingClientEmail(request.getParameter("floatingClientEmail"));
		client.setFloatingClientTel(request.getParameter("floatingClientTel"));
		client.setFloatingClientAddr(request.getParameter("floatingClientAddr"));
		client.setSmsAgree(request.getParameter("smsAgree"));
		client.setFloatingClientComments(request.getParameter("floatingClientComments"));
		
		int result = clientService.clientAdd(client);
		System.out.println("처리결과는 : " + result);
		
		
		return "redirect:profile";
	}
	
	
	@ResponseBody
	@PostMapping(value="clientUpdate", produces = "application/json;charset=UTF-8")
	public String clientUpdate(HttpServletRequest request) {
//		System.out.println(request.getParameter("updateOwnerName"));
//		System.out.println(request.getParameter("updateOwnerEmail"));
//		System.out.println(request.getParameter("updateOwnerTel"));
//		System.out.println(request.getParameter("updateOwnerAddr"));
//		System.out.println(request.getParameter("updateOwnerSms"));
//		System.out.println(request.getParameter("updateOwnerMemo"));
		
		ClientDTO client = new ClientDTO();
		client.setUpdateOwnerName(request.getParameter("updateOwnerName"));
		client.setUpdateOwnerEmail(request.getParameter("updateOwnerEmail"));
		client.setUpdateOwnerTel(request.getParameter("updateOwnerTel"));
		client.setUpdateOwnerAddr(request.getParameter("updateOwnerAddr"));
		client.setUpdateOwnerSms(request.getParameter("updateOwnerSms"));
		client.setUpdateOwnerMemo(request.getParameter("updateOwnerMemo"));
		client.setClientNo(request.getParameter("clientNo"));
		
		int result = clientService.clientUpdate(client);
		
		System.out.println(result);
		
		JSONObject json = new JSONObject();
		json.put("result", result);
		
		return json.toString();
	}
	
	
	

}
