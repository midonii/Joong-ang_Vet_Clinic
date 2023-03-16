package com.vet.clinic.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.vet.clinic.dto.SmsDTO;
import com.vet.clinic.dto.SmsResponseDTO;

@Repository
@Mapper
public interface SMSDAO {

	public List<SmsDTO> smsclientlist();

	public Map<String, Object> smsform(int smsform_no);

	public int smsform_setdel(Map<String, String> map);

	public String[] smsFormName();

	public void smsDataSave(Map<String, Object> responseList);

	public List<Map<String, Object>> smsDetail();



}
