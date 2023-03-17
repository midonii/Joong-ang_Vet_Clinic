package com.vet.clinic.dto;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Builder
@Data
public class SmsDTO {
	
	String pet_name, owner_name, owner_tel; 

	String to;
	String title, content;
	
	String smsData_receiver, smsData_status, smsData_title;
	LocalDateTime smsData_date;
	
	
	
}
