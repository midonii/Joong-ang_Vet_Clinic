package com.vet.clinic.dto;

import lombok.Data;

@Data
public class SalesDTO {
	private String pay_date,toDate,fromDate;
	private int totalprice;
}
