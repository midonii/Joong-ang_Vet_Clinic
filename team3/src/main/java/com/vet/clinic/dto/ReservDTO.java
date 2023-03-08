package com.vet.clinic.dto;

import lombok.Setter;

import lombok.Getter;

@Getter
@Setter
public class ReservDTO {

	private String pet_name, pet_birth, pet_death, pet_gender, pet_memo, pet_regdate, 
				   owner_name, owner_addr, owner_email, owner_sms, owner_memo;
	private int pet_no, pet_weight, pet_count, owner_no, type_no, owner_tel;
	
	private String search_value;
}
