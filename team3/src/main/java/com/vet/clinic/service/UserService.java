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

	public StaffDTO login(Map<String, Object> map) {
		return staffDAO.login(map);
	}

	public int findEmail(String email) {
		return staffDAO.findEmail(email);
	}

	public void saveTempnum(StaffDTO temp) {
		staffDAO.saveTempnum(temp);
	}


	public int idCheck(String id) {
		return staffDAO.idCheck(id);
	}

	public int emailCheck(String email) {
		return staffDAO.emailCheck(email);
	}
	
	public int telCheck(String tel) {
		return staffDAO.telCheck(tel);
	}

	public Map<String, Object> profile(String sessionID) {
		return staffDAO.profile(sessionID);
	}

	public int pwCheck(Map<String, Object> map) {
		return staffDAO.pwCheck(map);
	}

	public int editProfile(Map<String, String> map) {
		return staffDAO.editProfile(map);
	}

	public void logintry(StaffDTO staffDTO) {
		staffDAO.logintry(staffDTO);
	}

	public int join(Map<String, String> map) {
		return staffDAO.join(map);
	}

	public int checkTempnum(Map<String, String> map) {
		return staffDAO.checkTempnum(map);
	}
	public int newpwSet(Map<String, String> map) {
		return  staffDAO.newpwSet(map);
	}




}
