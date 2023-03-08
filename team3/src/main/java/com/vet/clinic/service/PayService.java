package com.vet.clinic.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.vet.clinic.dao.PayDAO;
import com.vet.clinic.dto.PayDTO;

@Service
public class PayService {
	@Autowired PayDAO payDAO;

	public List<PayDTO> payList() {
		return payDAO.payList() ;
	}

	public PayDTO payDetail(int payNo) {
		return payDAO.payDetail(payNo);
	}

	public int payBefore(int payNo) {
		return payDAO.payBefore(payNo);
	}

	public int payCancel(int payNo) {
		return payDAO.payCancel(payNo);
	}
	
	
}
