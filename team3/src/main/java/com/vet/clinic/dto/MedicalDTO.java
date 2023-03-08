package com.vet.clinic.dto;

import lombok.Data;

@Data
public class MedicalDTO {

	private int mno,vno,medical_no, vac_no, medical_price;
	private String medical_category, medical_name, vac_name, vac_cycleY, vac_cycleM, vac_cycleW, vac_price;
}
