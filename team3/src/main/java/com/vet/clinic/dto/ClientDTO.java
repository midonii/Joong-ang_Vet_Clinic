package com.vet.clinic.dto;

import lombok.Data;

@Data
public class ClientDTO {

	private int owner_no, pet_no, pet_weight, pet_count, type_no, pet_del, owner_del;
	private String owner_name, owner_tel, owner_addr, owner_email, owner_sms, owner_memo, pet_name, pet_birth, pet_death, pet_gender, pet_regdate,pet_memo,type_name ;

	
	private String tdArr, petNo, clientNo, detailNo, n_file ,clientNno, petDeath, floatingClientName, floatingClientEmail, floatingClientTel, floatingClientAddr, smsAgree, floatingClientComments;
	private int nno;
	
	private String clientUpdateNo, updateOwnerName, updateOwnerEmail, updateOwnerTel, updateOwnerAddr, updateOwnerSms, updateOwnerMemo;
}
