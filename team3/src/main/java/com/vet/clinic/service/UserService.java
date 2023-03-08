package com.vet.clinic.service;

import java.util.Map;

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

	public int join(StaffDTO joinDTO) {
		return staffDAO.join(joinDTO);
	}

	public int idCheck(String id) {
		return staffDAO.idCheck(id);
	}

	public int emailCheck(String email) {
		return staffDAO.emailCheck(email);
	}

	public Map<String, Object> profile(Map<String, Object> map) {
		return staffDAO.profile(map);
	}

	public int pwCheck(Map<String, Object> map) {
		return staffDAO.pwCheck(map);
	}

	public int editProfile(Map<String, Object> edit) {
		return staffDAO.editProfile(edit);
	}

	public void logintry(StaffDTO staffDTO) {
		staffDAO.logintry(staffDTO);
	}

}
