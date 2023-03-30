package com.vet.clinic.controller;

import java.util.ArrayList;
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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.vet.clinic.dto.ReservDTO;
import com.vet.clinic.service.ReservService;

@Controller
public class ReservController {

	@Autowired
	private ReservService reservService;

	// 전체리스트, 예약리스트
	@GetMapping("/reserv")
	public ModelAndView reserv(HttpServletRequest request) {

		ReservDTO reservDTO = new ReservDTO();
		ModelAndView mv = new ModelAndView("reservation/reserv");

		// 전체리스트
		List<ReservDTO> boardlist = reservService.boardlist(reservDTO);
		mv.addObject("boardlist", boardlist);

		// 예약 리스트
		List<ReservDTO> reservlist = reservService.reservlist(reservDTO);
		mv.addObject("reservlist", reservlist);

		// 접수 리스트
		List<ReservDTO> receplist = reservService.receplist(reservDTO);
		mv.addObject("receplist", receplist);

		return mv;
	}

	// 검색결과(검색리스트)
	@ResponseBody
	@GetMapping("/reservsearch") 
	public String resersearch(HttpServletRequest request) {
		ReservDTO reservDTO = new ReservDTO();
		reservDTO.setSearch_value(request.getParameter("searchValue")); 

		HttpSession session = request.getSession();
		reservDTO.setStaff_id((String) session.getAttribute("id"));

		JSONObject json = new JSONObject();
		List<ReservDTO> searchlist = reservService.searchlist(reservDTO);
		JSONArray jsonA = new JSONArray(searchlist); 

		json.put("result", searchlist);
		return json.toString();
	}

	// 예약하기
	@ResponseBody
	@PostMapping(value = "/reservAjax", produces = "application/json;charset=UTF-8")
	public String reservAjax(HttpServletRequest request) {
		ReservDTO reservDTO = new ReservDTO();
		JSONObject json = new JSONObject();
		JSONArray jsonA = new JSONArray();
		reservDTO.setDetail_no(request.getParameter("detail_no"));
		if ((String) request.getParameter("detail_no") != null) {
			List<ReservDTO> searchDetail = reservService.reservAjax(reservDTO); // reservationview에서 가져옴
			jsonA = new JSONArray(searchDetail);
			json.put("result", searchDetail);
		}

		//시간막기
		reservDTO.setReservation_date_day(request.getParameter("reservation_date_day"));
		List<ReservDTO> timeDetail = reservService.reservTimeCheck(reservDTO);
		jsonA = new JSONArray(timeDetail);
		json.put("result1", timeDetail);
		
		return json.toString();
	}
	

	// 예약한 시간 막기
	@ResponseBody
	@PostMapping(value = "/reservTimeCheck", produces = "application/json;charset=UTF-8")
	public String reservTimeCheck(HttpServletRequest request) {
		ReservDTO reservDTO = new ReservDTO();

		reservDTO.setReservation_date_day(request.getParameter("reservation_date_day"));
		JSONObject json = new JSONObject();

		List<ReservDTO> timeDetail = reservService.reservTimeCheck(reservDTO);
		JSONArray jsonA = new JSONArray(timeDetail);
		json.put("result", timeDetail);
		return json.toString();
	}

	// 예약완료 (예약테이블에 저장)
	@ResponseBody
	@PostMapping("reservAdd")
	public String reservAdd(HttpServletRequest request) {
		ReservDTO reservDTO = new ReservDTO();
		String reservation_date = request.getParameter("reservation_date");

		HttpSession session = request.getSession();
		if (request.getParameter("reservation_memo") != null) {
			reservDTO.setReservation_memo(request.getParameter("reservation_memo"));
		}
		reservDTO.setReservation_date(reservation_date); 
		reservDTO.setStaff_id((String) session.getAttribute("id"));
		reservDTO.setPetNo(request.getParameter("petNo"));

		JSONObject json = new JSONObject();
		int result = reservService.reservAdd(reservDTO);
		json.put("result", result);

		return json.toString();
	}

	// 예약수정하기(모달 띄우기)
	@ResponseBody
	@PostMapping(value = "reservUpdate", produces = "application/json;charset=UTF-8")
	public String reservUpdate(HttpServletRequest request) {
		ReservDTO reservDTO = new ReservDTO();
		reservDTO.setReservation_no(request.getParameter("reservation_no"));
		JSONObject json = new JSONObject();

		List<ReservDTO> reservDetail = reservService.reservUpdate(reservDTO); // reservationview에서 가져옴
		JSONArray jsonA = new JSONArray(reservDetail);
		json.put("result", reservDetail);
		// System.out.println(jsonA.getJSONObject(0).getString("reserv_time")); //ok

		// 시간막기
		reservDTO.setReservation_date_day(request.getParameter("reservation_date_day"));
		List<ReservDTO> timeDetail = reservService.reservTimeCheck(reservDTO);
		jsonA = new JSONArray(timeDetail);
		json.put("result1", timeDetail);

		return json.toString();
	}

	// 예약수정 완료
	@ResponseBody
	@PostMapping(value = "reservUpdateSaved", produces = "application/json;charset=UTF-8")
	public String reservUpdateSaved(HttpServletRequest request) {

		ReservDTO reservDTO = new ReservDTO();
		reservDTO.setUpdate_reservation_date(request.getParameter("update_reservation_date"));
		reservDTO.setUpdate_reservation_memo(request.getParameter("update_reservation_memo"));
		reservDTO.setUpdate_reservation_no(request.getParameter("update_reservation_no"));
		int result = reservService.reservUpdateSaved(reservDTO);

		JSONObject json = new JSONObject();
		json.put("result", result);
		return json.toString();
	}

	// 예약삭제
	@GetMapping("reservDelete")
	public String reservDelete(HttpServletRequest request) {

		ReservDTO reservDTO = new ReservDTO();
		reservDTO.setDelete_reservation_no(request.getParameter("delete_reservation_no"));
		int result = reservService.delete_reservation_no(reservDTO);

		return "redirect:reserv";
	}

	// 예약에서 접수버튼 (접수테이블에 저장)
	@ResponseBody
	@PostMapping("receiveAdd")
	public String receiveAdd(HttpServletRequest request) {
		ReservDTO reservDTO = new ReservDTO();
		String reservNo = request.getParameter("reservNo"); // reservation_date 변수에 매개변수 값 할당
		JSONObject json = new JSONObject();

		HttpSession session = request.getSession();
		reservDTO.setStaff_id((String) session.getAttribute("id"));
		reservDTO.setReservNo(reservNo); // dto의 속성 값 설정
		reservDTO.setReceive_petNo(request.getParameter("receive_petNo"));
		reservDTO.setReceive_ownerNo(request.getParameter("receive_ownerNo"));
		
		//접수막기
		String search_petNo = request.getParameter("receive_petNo");
		reservDTO.setSearch_petNo(search_petNo);
		boolean petNoExists = reservService.checkPetNoExists(reservDTO);
		 if (petNoExists){
				json.put("result", "exist");
				return json.toString();
		  } else {
		int result = reservService.receiveAdd(reservDTO);
		result = reservService.receiveAdd_reservYn(reservDTO);
		json.put("result", result);
		return json.toString();
		}
	}

	// 검색에서 접수버튼 (접수테이블에 저장)
	@ResponseBody
	@PostMapping("search_receiveAdd")
	public String search_receiveAdd(HttpServletRequest request) {
		ReservDTO reservDTO = new ReservDTO();
		JSONObject json = new JSONObject();

		HttpSession session = request.getSession();
		reservDTO.setStaff_id((String) session.getAttribute("id"));
		reservDTO.setSearch_petNo(request.getParameter("search_petNo"));
		reservDTO.setSearch_ownerNo(request.getParameter("search_ownerNo"));
		
		 // search_petNo가 이미 존재하는지 검사
		boolean petNoExists = reservService.checkPetNoExists(reservDTO);
		  if (petNoExists){
				json.put("result", "exist");
				return json.toString();
		  }
		  else {
			int result = reservService.search_receiveAdd(reservDTO);
			json.put("result", result);
			return json.toString();
		  }
	}

	// 접수삭제
	@GetMapping("receiveDelete")
	public String receiveDelete(HttpServletRequest request) {
		ReservDTO reservDTO = new ReservDTO();
		reservDTO.setDelete_receive_no(request.getParameter("delete_receive_no"));
		int result = reservService.receiveDelete(reservDTO);
		return "redirect:reserv";
	}
	//캘린더
	// 전체리스트, 예약리스트
	@GetMapping("/calender_sm2")
	public ModelAndView calender_sm2(HttpServletRequest request) {

		ReservDTO reservDTO = new ReservDTO();
		ModelAndView mv = new ModelAndView("reservation/calender_sm2");

		// 전체리스트
		List<ReservDTO> boardlist = reservService.boardlist(reservDTO);
		mv.addObject("boardlist", boardlist);

		// 예약 리스트
		List<ReservDTO> reservlist = reservService.reservlist(reservDTO);
		mv.addObject("reservlist", reservlist);

		return mv;
	}
	
	// 캘린더 날짜별(예약리스트)
	@ResponseBody
	@GetMapping("/calender_reserv_ajax") 
	public String calender_reserv_ajax(HttpServletRequest request) {
		ReservDTO reservDTO = new ReservDTO();
		reservDTO.setFulldate(request.getParameter("fulldate")); // searchValue: script의 data의 key 명!,data: { "searchValue"}
		JSONObject json = new JSONObject();
		
		HttpSession session = request.getSession();
		reservDTO.setStaff_id((String) session.getAttribute("id"));

		List<ReservDTO> reservlist2 = reservService.reservlist2(reservDTO);
		JSONArray jsonA = new JSONArray(reservlist2); // json어레이로 감싸기
		
		List<ReservDTO> result = reservService.reservlist2(reservDTO);
		
		if(result.size() > 0) {
			json.put("result", reservlist2);
			return json.toString();
		} else {
			json.put("result", "noReserv");
			return json.toString();
		}
	}
	
	
	
	
	
	// 캘린더에서 예약삭제
	@GetMapping("calender_reservDelete")
	public String calender_reservDelete(HttpServletRequest request) {
		ReservDTO reservDTO = new ReservDTO();
		reservDTO.setDelete_reservation_no(request.getParameter("delete_reservation_no"));
		int result = reservService.delete_reservation_no(reservDTO); //필수

		return "redirect:calender_sm2";
	}

}
