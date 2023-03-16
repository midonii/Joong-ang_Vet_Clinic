package com.vet.clinic.dto;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Builder
@Data
public class SmsRequestDTO {
	
	String type, contentType, countryCode, from, content;
	List<SmsDTO> messages;
	

}
