package com.vet.clinic.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.vet.clinic.dao.SalesDAO;

@Service
public class SalesService {
	@Autowired
	private SalesDAO salesDAO;
	


	public List<Map<String, Object>> salesList(Map<String, String> paramap) {
		// TODO Auto-generated method stub
		return salesDAO.salesList(paramap);
	}
	
}
