package com.vet.clinic.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.vet.clinic.dto.PageDTO;
import com.vet.clinic.dto.PayDTO;

@Repository
@Mapper
public interface SalesDAO {

	public List<Map<String, Object>> salesList2(Map<String, String> paramap);

	public int contentTotal(PageDTO pageDTO);

	public List<PayDTO> salesList(PageDTO pageDTO);
	
}
