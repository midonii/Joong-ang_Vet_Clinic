package com.vet.clinic.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.vet.clinic.dao.StaffDAO;
import com.vet.clinic.dto.StaffDTO;

@Service
public class UserService {
	
	@Autowired
	private StaffDAO staffDAO;

	public StaffDTO login(StaffDTO staffDTO) {
		return staffDAO.login(staffDTO);
	}

	public int findEmail(String email) {
		return staffDAO.findEmail(email);
	}

	public void saveTempnum(StaffDTO temp) {
		staffDAO.saveTempnum(temp);
	}

	public int checkTempnum(StaffDTO check) {
		return staffDAO.checkTempnum(check);
	}

	public int newpwSet(StaffDTO newpwSet) {
		return staffDAO.newpwSet(newpwSet);
	}

}
