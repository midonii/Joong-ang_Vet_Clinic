package com.vet.clinic.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.vet.clinic.dao.ReceptionDAO;

@Service
public class ReceptionService {

	@Autowired
	private ReceptionDAO receptionDAO;

	public List<Map<String, Object>> petSearch(Map<String, Object> map) {
		return receptionDAO.petSearch(map);
	}

}
