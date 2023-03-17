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
	
	//전체리스트, 예약리스트
	@GetMapping("/reserv")
	public ModelAndView reserv(HttpServletRequest request) {
		
		ReservDTO reservDTO = new ReservDTO();
		ModelAndView mv = new ModelAndView("reservation/reserv");
		
		//전체리스트
		List<ReservDTO> boardlist = reservService.boardlist(reservDTO);
		mv.addObject("boardlist", boardlist);
			
		//예약 리스트
		List<ReservDTO> reservlist = reservService.reservlist(reservDTO);
		mv.addObject("reservlist", reservlist);
		//System.err.println(reservlist);
		
		//접수 리스트
		List<ReservDTO> receplist = reservService.receplist(reservDTO);
		mv.addObject("receplist", receplist);
		//System.err.println(reservlist);
		
		
		return mv;
	}
	
	//검색결과(검색리스트)
	@ResponseBody
	@GetMapping("/reservsearch") //url을 "/reservsearch"로 띄워주겠다
	public String resersearch(HttpServletRequest request) {
		ReservDTO reservDTO = new ReservDTO();
		reservDTO.setSearch_value(request.getParameter("searchValue")); //searchValue: script의 data의 key 명!,data: { "searchValue"}
		
		JSONObject json = new JSONObject();
		List<ReservDTO> searchlist = reservService.searchlist(reservDTO);
		JSONArray jsonA = new JSONArray(searchlist); //json어레이로 감싸기
		
		json.put("result", searchlist);
		return json.toString();
	}
	
	//예약하기
	@ResponseBody
	@PostMapping(value = "/reservAjax", produces = "application/json;charset=UTF-8")
	public String reservAjax(HttpServletRequest request) {
		ReservDTO reservDTO = new ReservDTO();
		reservDTO.setDetail_no(request.getParameter("detail_no"));
		//System.err.println(request.getParameter("detail_no")); //ok
		JSONObject json = new JSONObject();
		
		if ((String)request.getParameter("detail_no") != null) {
//			if ((String)request.getParameter("searchValue") != null) {
			List<ReservDTO>searchDetail = reservService.reservAjax(reservDTO); //reservationview에서 가져옴
			JSONArray jsonA = new JSONArray(searchDetail);
			json.put("result", searchDetail);
//			System.out.println(jsonA.getJSONObject(0).getString("pet_name")); //ok
		} 
		else {
			json.put("result", 0);
		}
		return json.toString();
	}

	//예약완료 (예약테이블에 저장)
	@ResponseBody
	@PostMapping("reservAdd")
	public String reservAdd(HttpServletRequest request) {
		ReservDTO reservDTO = new ReservDTO();
		String reservation_date = request.getParameter("reservation_date"); // reservation_date 변수에 매개변수 값 할당
		
		HttpSession session = request.getSession();
		if(request.getParameter("reservation_memo") !=  null) {
			reservDTO.setReservation_memo(request.getParameter("reservation_memo"));
		} System.out.println(request.getParameter("reservation_memo"));
		reservDTO.setReservation_date(reservation_date); // dto의 속성 값 설정
		//db에 저장할 깂
		reservDTO.setStaff_id((String)session.getAttribute("id"));
		reservDTO.setPetNo(request.getParameter("petNo"));
//		reservDTO.setReservation_no(request.getParameter("reservation_no"));
		
		
		JSONObject json = new JSONObject();
		int result = reservService.reservAdd(reservDTO);
		json.put("result", result);
		//System.out.println(json);
		//System.out.println("result:"+result); //1
		
		return json.toString();
	}
	
	//예약수정하기(모달 띄우기)
	@ResponseBody
	@PostMapping(value="reservUpdate", produces = "application/json;charset=UTF-8")
	public String reservUpdate(HttpServletRequest request) {
		ReservDTO reservDTO = new ReservDTO();
		reservDTO.setReservation_no(request.getParameter("reservation_no"));
		//System.err.println(request.getParameter("detail_no")); //ok
		JSONObject json = new JSONObject();
		
//			if ((String)request.getParameter("searchValue") != null) {
			List<ReservDTO>reservDetail = reservService.reservUpdate(reservDTO); //reservationview에서 가져옴
			JSONArray jsonA = new JSONArray(reservDetail);
			json.put("result", reservDetail);
			//System.err.println("jsonA:"+jsonA); //ok //reservation_no없음(pet 테이블엔 ~컬럼이 없으니까)
			//System.out.println(jsonA.getJSONObject(0).getString("reserv_time")); //ok
			
		return json.toString();
	}
	
	//예약수정 완료
	@ResponseBody
	@PostMapping(value="reservUpdateSaved", produces = "application/json;charset=UTF-8")
	public String reservUpdateSaved(HttpServletRequest request) {
		//System.out.println("controller"); //ok
//			System.out.println(request.getParameter("update_reservation_date_time"));
//			System.out.println(request.getParameter("update_reservation_memo"));
		
		ReservDTO reservDTO = new ReservDTO();
		//System.out.println(request.getParameter("reservation_no"));
//		reservDTO.setUpdate_reservation_date_day(request.getParameter("update_reservation_date_day"));
//		reservDTO.setUpdate_reservation_date_time(request.getParameter("update_reservation_date_time"));
		reservDTO.setUpdate_reservation_date(request.getParameter("update_reservation_date"));
		reservDTO.setUpdate_reservation_memo(request.getParameter("update_reservation_memo"));
		reservDTO.setUpdate_reservation_no(request.getParameter("update_reservation_no"));
		int result = reservService.reservUpdateSaved(reservDTO);
		//System.out.println(request.getParameter("update_reservation_no")); 
		
		JSONObject json = new JSONObject();
		json.put("result", result);
		System.err.println(json);
		return json.toString();
	}
	
	//예약삭제
	@GetMapping("reservDelete")
	public String reservDelete(HttpServletRequest request) {
		System.out.println(request.getParameter("delete_reservation_no"));
		
		ReservDTO reservDTO = new ReservDTO();
		reservDTO.setDelete_reservation_no(request.getParameter("delete_reservation_no"));
		int result = reservService.delete_reservation_no(reservDTO);
		System.out.println("처리결과는 : " + result);
		
		return "redirect:reserv";
	}
	
	//접수버튼 (접수테이블에 저장)
	@ResponseBody
	@PostMapping("receiveAdd")
	public String receiveAdd(HttpServletRequest request) {
		ReservDTO reservDTO = new ReservDTO();
		String reservNo = request.getParameter("reservNo"); // reservation_date 변수에 매개변수 값 할당
		
		reservDTO.setReservNo(reservNo); // dto의 속성 값 설정
		
		JSONObject json = new JSONObject();
		int result = reservService.receiveAdd(reservDTO);
		json.put("result", result);
		//System.out.println(json);
		//System.out.println("result:"+result); //1
		
		return json.toString();
	}
	
	
	@GetMapping("/calender")
	public String calender() {

		return "/reservation/calender";
	}

}	
