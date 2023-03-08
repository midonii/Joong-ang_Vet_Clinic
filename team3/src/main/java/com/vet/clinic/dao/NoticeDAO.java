package com.vet.clinic.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.vet.clinic.dto.NoticeDTO;
import com.vet.clinic.dto.StaffDTO;

@Repository
@Mapper
public interface NoticeDAO {

	public List<NoticeDTO> noticeList();

	public int noticeWrite(Map<String, Object> map);

	public Map<String, Object> noticeDetail(int notice_no);




}
