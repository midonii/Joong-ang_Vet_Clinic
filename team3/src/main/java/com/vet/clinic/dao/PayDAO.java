package com.vet.clinic.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.vet.clinic.dto.PageDTO;
import com.vet.clinic.dto.PayDTO;

@Repository
@Mapper
public interface PayDAO {

	public PayDTO payDetail(int payNo);

	public int payBefore(int payNo);

	public int payCancel(int payNo);
	
	public int contentTotal(PageDTO pageDTO);

	public int totalCount();


	public List<Map<String, Object>> indexPay(Map<String, Object> map);

	public List<PayDTO> payList(PageDTO pageDTO);
	
}
