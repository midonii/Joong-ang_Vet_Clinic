package com.vet.clinic.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.vet.clinic.dao.IndexDAO;

@Service
public class IndexService {

	@Autowired
	private IndexDAO indexDAO;

	public List<Map<String, Object>> indexReserv() {
		return indexDAO.indexReserv();
	}

	public List<Map<String, Object>> indexPet(Map<String, Object> map) {
		return indexDAO.indexPet(map);

	}

	public List<Map<String, Object>> noticeList() {
		return indexDAO.indexNotice();
	}

	public int reservCount() {
		return indexDAO.reservCount();
	}

	public int recepCount() {
		return indexDAO.recepCount();
	}

	public int diagCount() {
		return indexDAO.diagCount();
	}

	public List<Map<String, Object>> indexpay() {
		return indexDAO.indexpay();
	}

	public List<Map<String, Object>> indexreceive() {
		return indexDAO.indexreceive();
	}
}
