package com.vet.clinic.dto;

import lombok.Setter;

import lombok.Getter;

@Getter
@Setter
public class ReservDTO {

	private String pet_name, pet_birth, pet_death, pet_gender, pet_memo, pet_regdate, owner_name, owner_addr,
			owner_email, owner_sms, owner_memo, owner_tel;
	private String type_name;
				  
	private int pet_weight, pet_count, owner_no, type_no, pet_no ;

	private String search_value, detail_no, petNo;

	private String reservation_time, reservation_memo, reservation_date, reservation_yn, reservation_date_day, staff_id;
	private int staff_no;

	private String searchValue;
	private String reserv_date, reserv_time;
	private int rno, ino;
	
	private String update_reservation_date_day, update_reservation_date_time, update_reservation_memo,
	update_reservation_date, update_pet_no, reservation_no, update_reservation_no;
	
	private String delete_reservation_no;
	
	private String receive_time, receive_state,receive_no, reservNo, receive_petNo, receive_ownerNo;
	private String search_ownerNo, search_petNo;
	private String delete_receive_no;
	
	//캘린더
//	private int calendarNo;
//	private String calendarTitle;
//	private String calendarMemo;
//	private String calendarStart;
//	private String calendarEnd;
}
