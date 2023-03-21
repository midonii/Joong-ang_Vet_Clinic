package com.vet.clinic.dto;

import java.math.BigDecimal;
import java.math.BigInteger;

import lombok.Data;

@Data
public class PetDTO {
	private int owner_no, pet_no, pet_count, type_no;

	private String owner_name, owner_tel, owner_addr, owner_email, owner_sms, owner_memo, pet_name, pet_birth, pet_death, pet_gender, pet_regdate,pet_memo,type_name, pet_Ym ;

	private float pet_weight;

	private String petNo, chartNo, chart_no;

	private int vac_no, vac_price, vacdata_no;

	private String vac_name, vacdata_date;

	private int staff_no, medical_no, receive_no, u_no;

	private String chart_memo, chart_date , filename;

	private String heartworm, corona, rabies, swine_flu, dhppl, kennel_cough, antibody_test, ectoparasite, helminthic;
}
