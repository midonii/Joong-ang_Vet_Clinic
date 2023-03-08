package com.vet.clinic.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.vet.clinic.dao.StaffDAO;
import com.vet.clinic.dto.StaffDTO;

@Service
public class StaffService {

	
	@Autowired
	private StaffDAO staffDAO;
	
	public List<StaffDTO> staffList() {
		return staffDAO.staffList();
	}

	public Map<String, Object> staffDetail(int staff_no) {
		return staffDAO.staffDetail(staff_no);
	}

	public int gradeUpdate(Map<String, Object> map) {
		return staffDAO.gradeUpdate(map);
	}

	public int staffDel(int staff_no) {
		return staffDAO.staffDel(staff_no);
	}





}
