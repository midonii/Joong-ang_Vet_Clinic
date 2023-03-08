package com.vet.clinic.dto;

import lombok.Data;

@Data
public class PayDTO {
	private String pay_date, pay_yn, owner_name, owner_tel, pet_name,chart_memo; 
	private int totalprice, chart_no, pay_no;
}
