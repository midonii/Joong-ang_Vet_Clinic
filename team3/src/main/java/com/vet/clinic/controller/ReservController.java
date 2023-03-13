package com.vet.clinic.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.vet.clinic.dto.ReservDTO;
import com.vet.clinic.service.ReservService;


@Controller
public class ReservController {

	@Autowired
	private ReservService reservService;
	
	@ResponseBody
	@GetMapping("/reserv")
	public ModelAndView reserv(HttpServletRequest request) {
		
		ModelAndView mv = new ModelAndView("reservation/reserv");
		 ReservDTO reservDTO = new ReservDTO();
		 reservDTO.setSearch_value(request.getParameter("search_value"));
		 List<ReservDTO> searchlist = reservService.searchlist(reservDTO);
		 mv.addObject("searchlist", searchlist);//리스트 + 검색리스트
		 
		List<ReservDTO> boardlist = reservService.boardlist(reservDTO);
		mv.addObject("boardlist", boardlist);//리스트 + 검색리스트
		return mv;
	}
	
	@ResponseBody
	@PostMapping(value = "/reservAjax", produces = "application/json;charset=UTF-8")
	public String reservAjax(HttpServletRequest request) {
		ReservDTO reservDTO = new ReservDTO();
		reservDTO.setSearch_no(request.getParameter("search_no"));
		JSONObject json = new JSONObject();
		if ((String)request.getParameter("search_no") != null) {
//			if ((String)request.getParameter("searchValue") != null) {
			//System.out.println("not null");
			List<ReservDTO>searchDetail = reservService.reservAjax(reservDTO);
			//System.out.println(searchDetail);
			//array json
			JSONArray jsonA = new JSONArray(searchDetail);
			json.put("result", searchDetail);
			//System.out.println(json.toString());
		} else {
			//System.out.println("null");
			json.put("result", 0);
		}
		return json.toString();
	}
	
//	//예약정보 저장
//	@ResponseBody
//	@PostMapping(value = "/reservInfo", produces = "application/json;charset=UTF-8")
//	public String reservInfo(HttpServletRequest request) {
//		ReservDTO reservDTO = new ReservDTO();
////		reservDTO.setReservation_no
//		reservDTO.setOwner_addr(null)
//	    let modal_owner_name = $('#modal_owner_name').val();
//	    let modal_owner_tel = $('#modal_owner_tel').val();
//	    let modal_pet_name = $('#modal_pet_name').val();
//	    let modal_pet_gender = $('#modal_pet_gender').val();
//	    let modal_pet_birth = $('#modal_pet_birth').val();
//	    let modal_reservation_date = reservation_date_time.val(); //?
//	    let modal_reservation_memo = $('#reservation_memo').val();
//		
//		
//		
//		reservDTO.setSearch_no(request.getParameter("search_no"));
//		JSONObject json = new JSONObject();
//		if ((String)request.getParameter("search_no") != null) {
////			if ((String)request.getParameter("searchValue") != null) {
//			//System.out.println("not null");
//			List<ReservDTO>searchDetail = reservService.reservAjax(reservDTO);
//			//System.out.println(searchDetail);
//			//array json
//			JSONArray jsonA = new JSONArray(searchDetail);
//			json.put("result", searchDetail);
//			//System.out.println(json.toString());
//		} else {
//			//System.out.println("null");
//			json.put("result", 0);
//		}
//		return json.toString();
//	}
	
	
	
	@GetMapping("/calender")
	public String calender() {

		return "/reservation/calender";
	}

}	
