package com.vet.clinic.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.vet.clinic.dao.ChartDAO;

@Service
public class ChartService {

	@Autowired
	private ChartDAO chartDAO;

	public List<Map<String, Object>> petSearch(Map<String, Object> map) {
		return chartDAO.petSearch(map);
	}

	public List<Map<String, Object>> rereceiveboard() {
		return chartDAO.receiveboard();
	}

}
