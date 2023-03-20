package com.vet.clinic.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.vet.clinic.dao.Chart1DAO;

@Service
public class Chart1Service {

	@Autowired
	private Chart1DAO chartDAO;


	public Map<String, Object> petdetailAjax(String receiveno) {
		return chartDAO.petdetailAjax(receiveno);
	}


	public List<Map<String, Object>> prescAjax() {
		return chartDAO.prescAjax();
	}


	public List<Map<String, Object>> prescAjaxvac() {
		return chartDAO.prescAjaxvac();
	}


	
	
}	