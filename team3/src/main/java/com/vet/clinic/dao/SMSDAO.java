package com.vet.clinic.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.vet.clinic.dto.SMSDTO;

@Repository
@Mapper
public interface SMSDAO {

	public List<SMSDTO> smsclientlist();

	public Map<String, Object> smsform(int smsform_no);

	public int smsform_set(Map<String, String> map);

	public String[] smsformname();



}
