package com.vet.clinic.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

@Repository
@Mapper
public interface ChartDAO {

	List<Map<String, Object>> petSearch(Map<String, Object> map);

	Map<String, Object> profile(int pet_no);

}
