package com.vet.clinic.dto;

import lombok.Data;

@Data
public class PastChartDTO {
	
	//chartview
	private int receive_no, pet_no, staff_no;
	private String pet_name, chart_memo, chart_date, staff_name, staff_grade, chart_no, medical_subcate;
	
	//medicaldataview
	private int medicaldata_no, medicaldata_ea, medical_no, medical_price;
	private String medical_category, medical_name;
	
	
}