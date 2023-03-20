package com.vet.clinic.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.vet.clinic.dao.StockDAO;
import com.vet.clinic.dto.StockDTO;

@Service
public class StockService {
	
	@Autowired
	public StockDAO stockDAO;

	public List<StockDTO> stockList() {
		return stockDAO.stockList();
	}

	public List<String> m_company() {
		return stockDAO.m_company();
	}

	public List<String> m_subcate() {
		return stockDAO.m_subcate();
	}

	public List<Map<String, Object>> stockSelect(Map<String, Object> paramMap) {
		return stockDAO.stockSelect(paramMap);
	}
	
	
	
}
