package com.vet.clinic.controller;

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
import org.springframework.web.servlet.ModelAndView;

import com.vet.clinic.dto.ReservDTO;
import com.vet.clinic.service.ReservService;


@Controller
public class ReservController {

	@Autowired
	private ReservService reservService;
//	@Autowired
//	private ReservDTO reservDTO;
	
	@GetMapping("/reserv")
	public ModelAndView reserv(HttpServletRequest request) {
		
		ReservDTO reservDTO = new ReservDTO();
		ModelAndView mv = new ModelAndView("reservation/reserv");
		
		//전체리스트
		List<ReservDTO> boardlist = reservService.boardlist(reservDTO);
		mv.addObject("boardlist", boardlist);
			
		//예약
		List<ReservDTO> reservList = reservService.reservlist(reservDTO);
		mv.addObject("reservList", reservList);
		
		return mv;
	}
	
	//검색결과
	@GetMapping("/reservsearch") //url을 "/reservsearch"로 띄워주겠다
	@ResponseBody
	public String resersearch(HttpServletRequest request) {
		ReservDTO reservDTO = new ReservDTO();
		reservDTO.setSearch_value(request.getParameter("searchValue")); //searchValue: script의 data의 key 명!,data: { "searchValue"}
		
		JSONObject json = new JSONObject();
		List<ReservDTO> searchlist = reservService.searchlist(reservDTO);
		JSONArray jsonA = new JSONArray(searchlist); //json어레이로 감싸기
		
		json.put("result", searchlist);
		//System.out.println(json);
//		if(!searchlist.isEmpty()) {
//			 json.put("owner_name", searchlist.get(0).getOwner_name());
//			 System.out.println("owner_name");
//			 json.put("owner_tel", searchlist.get(0).getOwner_tel());
//			 json.put("pet_name", searchlist.get(0).getPet_name());
//		     json.put("pet_gender", searchlist.get(0).getPet_gender());
//		     json.put("pet_birth", searchlist.get(0).getPet_birth());
//		}
//		System.out.println("searchlist:"+searchlist); //ok(객체명)
		return json.toString();
	}
	
	@ResponseBody
	@PostMapping(value = "/reservAjax", produces = "application/json;charset=UTF-8")
	public String reservAjax(HttpServletRequest request) {
		ReservDTO reservDTO = new ReservDTO();
		reservDTO.setDetail_no(request.getParameter("detail_no"));
		
		JSONObject json = new JSONObject();
		
//		if ((String)request.getParameter("owner_no") != null) {
//			if ((String)request.getParameter("searchValue") != null) {
			//System.out.println("not null");
			List<ReservDTO>searchDetail = reservService.reservAjax(reservDTO);
			//System.out.println(searchDetail);
			JSONArray jsonA = new JSONArray(searchDetail);
			json.put("result", searchDetail);
			System.out.println(json);
//		} 
//		else {
//			//System.out.println("null");
//			json.put("result", 0);
//		}
		return json.toString();
	}
	
	//예약리스트 생성
	@PostMapping("reservAdd")
	public String reservAdd(HttpServletRequest request) {
		ReservDTO reservDTO = new ReservDTO();
		String reservation_date = request.getParameter("reservation_date"); // reservation_date 변수에 매개변수 값 할당
		
		HttpSession session = request.getSession();
		reservDTO.setReservation_memo(request.getParameter("reservation_memo"));
		reservDTO.setReservation_date(reservation_date); // dto의 속성 값 설정
		reservDTO.setStaff_id((String)session.getAttribute("id"));
		reservDTO.setPetNo(request.getParameter("petNo"));//null
		int result = reservService.reservAdd(reservDTO);
		//System.out.println(result); //1
		
		JSONObject json = new JSONObject();
		json.put("result", result);
		
		return json.toString();
	}
	
	
	
	@GetMapping("/calender")
	public String calender() {

		return "/reservation/calender";
	}

}	
