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
public class SmsResponseDTO {

	String requestId;
	LocalDateTime requestTime;
	String statusCode;
	String statusName;
	
}
