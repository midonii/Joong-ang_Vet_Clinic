package com.vet.clinic.dto;

import lombok.Data;

@Data
public class StaffDTO {

	private int sno,staff_no, staff_tempnum;
	private String staff_id, staff_pw, staff_name, staff_tel, staff_email, staff_birth, staff_addr, staff_grade;

	// logincontroller
	private int count;
	
	
}
