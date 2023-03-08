package com.vet.clinic.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.vet.clinic.dao.NoticeDAO;
import com.vet.clinic.dao.StaffDAO;
import com.vet.clinic.dto.NoticeDTO;
import com.vet.clinic.dto.StaffDTO;

@Service
public class NoticeService {

	
	@Autowired
	private NoticeDAO noticeDAO;

	public List<NoticeDTO> noticeList() {
		return noticeDAO.noticeList();
	}

	public int noticeWrite(Map<String, Object> map) {
		return noticeDAO.noticeWrite(map);
	}

	public Map<String, Object> noticeDetail(int notice_no) {
		return noticeDAO.noticeDetail(notice_no);
	}
	





}
