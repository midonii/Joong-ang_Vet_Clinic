package com.vet.clinic.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.vet.clinic.dto.StockDTO;

@Repository
@Mapper
public interface StockDAO {

	List<StockDTO> stockList();

	List<String> m_company();

	List<String> m_subcate();


}
