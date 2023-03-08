package com.vet.clinic.dto;

import lombok.Data;

@Data
public class NoticeDTO {

	private int nno, notice_no, notice_read, staff_no;
	private String notice_title, staff_id, staff_name, notice_content, notice_date, listdate;

}
