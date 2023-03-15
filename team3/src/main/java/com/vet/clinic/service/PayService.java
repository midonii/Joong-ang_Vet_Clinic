package com.vet.clinic.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.vet.clinic.controller.Criteria;
import com.vet.clinic.dao.PayDAO;
import com.vet.clinic.dto.PayDTO;

@Service
public class PayService {
	@Autowired
	private PayDAO payDAO;

	

	public PayDTO payDetail(int payNo) {
		return payDAO.payDetail(payNo);
	}

	public int payBefore(int payNo) {
		return payDAO.payBefore(payNo);
	}

	public int payCancel(int payNo) {
		return payDAO.payCancel(payNo);
	}

	public int totalCount() {
		return payDAO.totalCount();
	}

	public List<Map<String, Object>> payList(Criteria cri) {
		return payDAO.payList(cri);
	}

	public List<Map<String, Object>> indexPay(Map<String, Object> map) {
		return payDAO.indexPay(map);
	}
	
	
}
