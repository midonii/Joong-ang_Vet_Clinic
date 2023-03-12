package com.vet.clinic.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Data
public class SMSDTO {
	
	private String reservation_date, pet_name, owner_name, owner_tel;
	
}
