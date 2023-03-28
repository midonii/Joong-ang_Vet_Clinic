package com.vet.clinic.dto;

import lombok.Data;

@Data
public class PayDTO {
	private String format_date, pay_date, pay_yn, owner_name, owner_tel, pet_name,chart_memo, chart_no; 
	private String medical_category, medical_subcate, medical_name, staff_name;
	private int rownum,totalPrice, pay_no,medicaldata_ea, medical_price;
	
}
