package com.vet.clinic.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.vet.clinic.dao.Chart3DAO;
import com.vet.clinic.dto.PetDTO;

@Service
public class Chart3Service {

	@Autowired
	private Chart3DAO chart3DAO;

	public List<PetDTO> petChart(PetDTO petDTO) {
		return chart3DAO.petChart(petDTO);
	}

	public int chartAdd(Map<String, Object> map) {
		return chart3DAO.chartAdd(map);
	}

	public int stateUpdate(Map<String, Object> map) {
		return chart3DAO.stateUpdate(map);
	}

	public int chartUpdate(Map<String, Object> map) {
		return chart3DAO.chartUpdate(map);
	}

	public int payAdd(Map<String, Object> payMap) {
		return chart3DAO.payAdd(payMap);
	}

	public String chartNo(Map<String, Object> map) {
		return chart3DAO.chartNo(map);
	}

}
