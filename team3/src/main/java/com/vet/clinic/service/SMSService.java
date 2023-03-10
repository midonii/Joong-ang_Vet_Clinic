package com.vet.clinic.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.vet.clinic.dao.SMSDAO;
import com.vet.clinic.dto.SMSDTO;

@Service
public class SMSService {
	
	@Autowired
	public SMSDAO smsDAO;

	public List<SMSDTO> smsclientlist() {
		return smsDAO.smsclientlist();
	}

	public Map<String, Object> smsform(int smsform_no) {
		return smsDAO.smsform(smsform_no);
	}

	public int smsform_set(Map<String, String> map) {
		return smsDAO.smsform_set(map);
	}

	public String[] smsformname() {
		return smsDAO.smsformname();
	}

}
