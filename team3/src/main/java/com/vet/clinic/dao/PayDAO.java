package com.vet.clinic.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.vet.clinic.controller.Criteria;
import com.vet.clinic.dto.PayDTO;

@Repository
@Mapper
public interface PayDAO {

	public PayDTO payDetail(int payNo);

	public int payBefore(int payNo);

	public int payCancel(int payNo);

	public int totalCount();

    public List<Map<String, Object>> payList(Criteria cri);

	public List<Map<String, Object>> indexPay(Map<String, Object> map);
	
}
