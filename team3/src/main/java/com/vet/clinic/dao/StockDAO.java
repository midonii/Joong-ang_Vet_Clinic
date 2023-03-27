package com.vet.clinic.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.vet.clinic.dto.StockDTO;

@Repository
@Mapper
public interface StockDAO {

	List<StockDTO> stockList(Map<String, Object> map);
	
	List<String> m_company();

	List<String> m_subcate();

	List<Map<String, Object>> stockSelect(Map<String, Object> paramMap);

	int edit(Map<String, Object> paramMap);

	int totalcount();

}
