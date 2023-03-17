package com.vet.clinic.dto;

import lombok.Data;

@Data
public class PastChartDTO {
	
	//chartview
	private int receive_no, pet_no, chart_no, staff_no;
	private String pet_name, chart_memo, chart_date, staff_name, staff_grade;
	
	//chartdrugview
	private int drugdata_no, drugdata_ea, medical_no, medical_price;
	private String medical_category, medical_name;
	
	//chartexamview
	private int examdata_no, examdata_ea;
	
	//chartvaccineview
	private int vacdata_no,vac_no,vac_price;
	private String vacdata_date, vac_name;
	
}