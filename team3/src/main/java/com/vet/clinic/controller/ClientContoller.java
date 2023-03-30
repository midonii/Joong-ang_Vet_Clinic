package com.vet.clinic.controller;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.vet.clinic.dto.ClientDTO;
import com.vet.clinic.dto.SearchDTO;
import com.vet.clinic.service.ClientService;
import com.vet.clinic.util.FileUp;

@Controller
public class ClientContoller {
	
	@Resource(name = "clientService")
	private ClientService clientService;
	
	@Autowired
	private ServletContext context;
	
	@Autowired
	private FileUp fileup;
	
	//회원관리 페이지 보기 + 검색
	@GetMapping("client")
	public ModelAndView client(HttpServletRequest request) {
		
		ModelAndView mv = new ModelAndView("client/client");
		
		//System.out.println(request.getParameter("search_name")); //select
		//System.out.println(request.getParameter("search_value")); //input
		
		SearchDTO search = new SearchDTO();
		search.setSearch_name(request.getParameter("search_name"));
		search.setSearch_value(request.getParameter("search_value"));		
		
		
		List<ClientDTO> clientList = clientService.clientList(search);
		List<ClientDTO> petList = clientService.petList(search);
		List<ClientDTO> petTypeList = clientService.petTypeList(search);
		
		mv.addObject("clientList",clientList);
		mv.addObject("petList",petList);
		mv.addObject("petTypeList",petTypeList);
		mv.addObject("search",search);
		
		return mv;
	}
	
	//보호자 더블클릭 시 해당 보호자의 반려견만 출력
	@ResponseBody
	@PostMapping(value = "profileMap", produces = "application/json;charset=UTF-8")
	public String profileMap(HttpServletRequest request) {
	
		//System.out.println(request.getParameter("clientNno"));
		
		ClientDTO client = new ClientDTO();
		client.setClientNno(request.getParameter("clientNno"));
		JSONObject result = new JSONObject();

		if ((String)request.getParameter("clientNno") != null) {

			List<ClientDTO> profile = clientService.profileMap(client);
																						
			//array json
			JSONArray jsonA = new JSONArray(profile);
			
			result.put("result",profile);
			//System.out.println(result.toString());
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
		//System.err.println(client.getDetailNo());
		if ((String)request.getParameter("detailNo") != null) {
			
			List<ClientDTO> detail = clientService.clientDetailAjax(client);
			List<ClientDTO> detail2 = clientService.clientPetDetailAjax(client);
			
			//array json
			JSONArray jsonA = new JSONArray(detail);
			JSONArray jsonB = new JSONArray(detail2);
																						
			json.put("result", detail);
			json.put("result2", detail2);
			//System.out.println(json.toString());
		} else {
			json.put("result", 0);
			json.put("result2", 0);
		}
			return json.toString();
	}
	
	//보호자 삭제(삭제 시 반려견 정보도 함께 삭제됨)
	@GetMapping("clientDelete")
	public String clientDelete(HttpServletRequest request) {
		//System.out.println(request.getParameter("clientNo"));
		
		ClientDTO client = new ClientDTO();
		client.setClientNo(request.getParameter("clientNo"));
		
		int result = clientService.cilentPetDel(client);
		result = clientService.clientDel(client);
		//System.out.println("보호자 삭제 결과는 : " + result);
		
		return "redirect:client";
	}
	
	//반려견 정보 삭제
	@GetMapping("petDelete")
	public String petDelete(HttpServletRequest request) {
		//System.out.println(request.getParameter("petNo"));
		
		ClientDTO client = new ClientDTO();
		client.setPetNo(request.getParameter("petNo"));
		client.setPetDeath(request.getParameter("petDeath"));
		
		int result = clientService.petDel(client);

		//System.out.println("반려견 삭제 결과는 : " + result);
		
		return "redirect:client";
	}
	
	//보호자 추가
	@PostMapping("clientAdd")
	public String clientAdd(HttpServletRequest request) {
		
		ClientDTO client = new ClientDTO();
		client.setFloatingClientName(request.getParameter("floatingClientName"));
		client.setFloatingClientEmail(request.getParameter("floatingClientEmail"));
		client.setFloatingClientTel(request.getParameter("floatingClientTel"));
		client.setFloatingClientAddr(request.getParameter("floatingClientAddr"));
		client.setSmsAgree(request.getParameter("smsAgree"));
		client.setFloatingClientComments(request.getParameter("floatingClientComments"));
		
		int result = clientService.clientAdd(client);
		
		//System.out.println("보호자 추가 결과는 : " + result);
		
		JSONObject json = new JSONObject();
		json.put("result", result);
		
		return json.toString();
	
	}
	
	//보호자 수정
	@ResponseBody
	@PostMapping(value="clientUpdate", produces = "application/json;charset=UTF-8")
	public String clientUpdate(HttpServletRequest request) {
		
		ClientDTO client = new ClientDTO();
		client.setUpdateOwnerName(request.getParameter("updateOwnerName"));
		client.setUpdateOwnerEmail(request.getParameter("updateOwnerEmail"));
		client.setUpdateOwnerTel(request.getParameter("updateOwnerTel"));
		client.setUpdateOwnerAddr(request.getParameter("updateOwnerAddr"));
		client.setUpdateOwnerSms(request.getParameter("updateOwnerSms"));
		client.setUpdateOwnerMemo(request.getParameter("updateOwnerMemo"));
		client.setClientNo(request.getParameter("clientNo"));
		
		int result = clientService.clientUpdate(client);
		
		//System.out.println("보호자 수정 결과는 : " + result);
		
		JSONObject json = new JSONObject();
		json.put("result", result);
		
		return json.toString();
	}
	
	//반려견 추가
	@PostMapping("petAdd")
	public String petAdd(@RequestParam Map<String, Object> map, 
						@RequestParam(value = "petImg",required = false)MultipartFile petImg) throws IOException {

		//System.out.println(map);
		//System.err.println(map.get("owner_nameAdd"));
		
		
		//생년월일 조합하기
		String petBirthYear = (String) map.get("petBirthYear");
		String petBirthMonth = (String) map.get("petBirthMonth");
		String petBirthDay = (String) map.get("petBirthDay");
		String petBirth = petBirthYear+"-"+petBirthMonth+"-"+petBirthDay;
		map.put("petBirth", petBirth);
		
		
		//System.err.println(petImg.getOriginalFilename()); // 파일 이름
		//System.out.println(petImg.getSize()); // 위 파일의 크기
		//System.out.println(petImg.getContentType()); // 올린게 뭔지 확인
		
		int petAdd = clientService.petAdd(map);
		
		//반려견 이미지 올리기
		if(!petImg.isEmpty()) {
			String realPath = context.getRealPath("resources/static/");
			String fileName = fileup.fileSave(realPath+"upFile", petImg);
			//System.err.println(fileName); 저장된 이름
			//System.err.println(realPath); 서버 저장된 경로
			map.put("fileName",fileName);
			clientService.fileSave(map);
			
		}
		
		//System.out.println(map);
		
		return "redirect:client";
	}
	
	//반려견 정보 수정 (정보 보내기)
	@ResponseBody
	@PostMapping(value = "petUpdateAjax" , produces = "application/json;charset=UTF-8")
	public String petUpdateAjax(@RequestParam Map<String, Object> map) {
		
		//System.out.println(map);
		JSONObject json = new JSONObject();

		
		  if (map.containsKey("petNo")) {
		  
		  Map<String, Object> petUpdateShow = clientService.petUpdateAjax(map);
		  
		  
		  
		  json.put("result", petUpdateShow);
		  //System.out.println(json.toString());
		 
		  } else {
			  
		  json.put("result", 0);
		  
		  }
		
		
		return json.toString();
	}
	
	@ResponseBody
	@PostMapping(value="petUpdate", produces = "application/json;charset=UTF-8")
	public String petUpdate(@RequestParam Map<String, Object> map){
		
		//System.out.println(map);
		
		//생년월일 조합하기
		String petBirthYear = (String) map.get("petUpdateBirthYear");
		String petBirthMonth = (String) map.get("petUpdateBirthMonth");
		String petBirthDay = (String) map.get("petUpdateBirthDay");
		String petBirth = petBirthYear+"-"+petBirthMonth+"-"+petBirthDay;
		map.put("petBirth", petBirth);
		
		//System.out.println(map);
		int petUpdate = clientService.petUpdate(map);
		
		Map<String, Object> petUpdateinfo = clientService.petUpdateinfo(map);
		
		//System.out.println(petUpdate);
		
		JSONObject json = new JSONObject();
		json.put("result", petUpdate);
		json.put("petUpdateinfo", petUpdateinfo);
		
		return json.toString();

	}
	
	//반려견 이미지 수정
	@ResponseBody
	@PostMapping(value = "petUpdateImg", consumes = { "multipart/form-data" })
	public String petUpdateImg(@RequestParam("petUpdateImg")MultipartFile petUpImg, HttpServletRequest request) throws IOException {
//		System.err.println(petUpImg.getOriginalFilename());
//		System.out.println(request.getParameter("petNo"));
//		System.out.println(request.getParameter("petUsuImg"));
		
		JSONObject json = new JSONObject();
		
		
		//반려견 이미지 올리기
		if(!petUpImg.isEmpty()) {
			
			String realPath = context.getRealPath("resources/static/");
			String fileName = fileup.fileSave(realPath+"upFile", petUpImg);
			//System.err.println(realPath); 서버 저장된 경로
			
			ClientDTO client = new ClientDTO();
			client.setFilename(fileName);
			client.setPetNo(request.getParameter("petNo"));
			//System.out.println(fileName);
			
			
			String fileUsuName = request.getParameter("petUsuImg");
			//System.out.println(fileUsuName);
			

			// ---- 기존 이미지가 없을 경우 insert , 있을 경우 update
			if(fileUsuName.equals("undefined")) {

				int fileNewInsert = clientService.fileNewInsert(client);
				json.put("result", fileNewInsert);
				//System.out.println("파일이 신규 등록 되었습니다.");
				
			} else {
				
				int fileUpdate = clientService.fileUpdate(client);
				json.put("result", fileUpdate);
				//System.out.println("파일이 업데이트 되었습니다.");
				
			}
			
			File file1 = new File(realPath+"upFile/"+fileUsuName);
			//System.err.println(file1);
			
			
			//기존의 이미지 삭제 -- (서버)
			if(file1.exists()) {
				file1.delete();
				//System.out.println("파일을 삭제하였습니다.");
			} else {
				//System.out.println("삭제할 파일이 존재하지 않습니다.");
			}
			
			
			
		}
		return json.toString();
		
	}
	
	//반려견 이미지 삭제
	@ResponseBody
	@PostMapping("petDelImg")
	public String petDelImg(HttpServletRequest request) {
		
			
			ClientDTO client = new ClientDTO();
			client.setPetNo(request.getParameter("petNo"));
			//System.out.println(fileName);
			
			// --- 기존의 파일명
			String fileUsuName = request.getParameter("petDelName");
			//System.out.println(fileUsuName);
			
			String realPath = context.getRealPath("resources/static/");
			File file1 = new File(realPath+"upFile/"+fileUsuName);
			//System.err.println(file1);
			
			
			//기존의 이미지 삭제 -- (서버)
			if(file1.exists()) {
				file1.delete();
				//System.out.println("파일을 삭제하였습니다.");
			} else {
				//System.out.println("파일이 존재하지 않습니다.");
			}
			
			//기존의 이미지 삭제 -- DB
			int fileImgDel = clientService.fileImgDel(client);
			//System.err.println("삭제 결과 : "+fileImgDel);
			JSONObject json = new JSONObject();
			
			json.put("fileImgDel", fileImgDel);
			
			
			
			return json.toString();
			
		
	}
	
	@ResponseBody
	@PostMapping("/ownerCheck")
	public String ownerCheck(@RequestParam("usuallyEmail") String usuallyEmail) {
		//System.out.println(usuallyEmail);
		JSONObject json = new JSONObject();
		
		ClientDTO client = new ClientDTO();
		client.setUsuallyEmail(usuallyEmail);
		
		List<ClientDTO> ownerCheck = clientService.ownerCheck(client);
		
		JSONArray jsonA = new JSONArray(ownerCheck);
		
		json.put("ownerCheck", ownerCheck);

		
		return json.toString();
	}
	
	

	
	
	
}
