package com.vet.clinic.dto;

import lombok.Data;

@Data
public class StaffDTO {

	private int staff_no, staff_tempnum, staff_logintry;
	private String staff_id, staff_pw, staff_name, staff_tel, staff_email, staff_birth, staff_addr, staff_grade;

	// logincontroller
	private int count;
	
	public StaffDTO() {
		
	}
	
	// join
	public StaffDTO(String id, String pw, String name, String birth, String tel, String email, String addr, String grade) {
		this.staff_name = name; this.staff_id = id; this.staff_pw = pw; 
		this.staff_birth = birth; this.staff_tel = tel; this.staff_email = email; 
		this.staff_addr = addr; this.staff_grade = grade;
	}
	
}
