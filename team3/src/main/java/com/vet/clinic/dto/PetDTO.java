package com.vet.clinic.dto;

import lombok.Data;

@Data
public class PetDTO {
	private int owner_no, pet_no, pet_count, type_no;

	private String owner_name, owner_tel, owner_addr, owner_email, owner_sms, owner_memo, pet_name, pet_birth, pet_death, pet_gender, pet_regdate,pet_memo,type_name ;

	private float pet_weight;

	private String petNo, chartNo;

	private int vac_no, vac_price, vacdata_no;

	private String vac_name, vacdata_date;

	private int chart_no, staff_no, medical_no, receive_no;

	private String chart_memo, chart_date;

	private String heartworm, corona, rabies, swine_flu, dhppl, kennel_cough, antibody_test, ectoparasite, helminthic;
}
