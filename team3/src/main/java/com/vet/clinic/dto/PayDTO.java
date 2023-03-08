package com.vet.clinic.dto;

import lombok.Data;

@Data
public class PayDTO {
	private String pay_date, pay_yn, owner_name, pet_name; 
	private int totalprice, chart_no,pay_no;
}
