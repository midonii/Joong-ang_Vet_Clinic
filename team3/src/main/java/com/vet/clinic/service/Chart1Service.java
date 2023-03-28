package com.vet.clinic.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.vet.clinic.dao.Chart1DAO;
import com.vet.clinic.dto.SearchDTO;

@Service
public class Chart1Service {

	@Autowired
	private Chart1DAO chartDAO;


	public Map<String, Object> petdetailAjax(String receiveno) {
		return chartDAO.petdetailAjax(receiveno);
	}

	public List<Map<String, Object>> prescAjax(SearchDTO searchDTO) {
		return chartDAO.prescAjax(searchDTO);
	}

	public List<Map<String, Object>> prescSaveAjax(Map<String, Object> rightno_map) {
		return chartDAO.prescSaveAjax(rightno_map);
	}

	public int callClientAjax(String receiveno) {
		return chartDAO.callClientAjax(receiveno);
	}


	
	
}	