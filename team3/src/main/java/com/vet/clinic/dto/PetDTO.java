package com.vet.clinic.dto;

import lombok.Data;

@Data
public class PetDTO {

	private int owner_no, pet_no, pet_weight, pet_count, type_no;
	private String owner_name, owner_tel, owner_addr, owner_email, owner_sms, owner_memo, pet_name, pet_birth, pet_death, pet_gender, pet_regdate,pet_memo,type_name ;
	
	private String petNo;
}
