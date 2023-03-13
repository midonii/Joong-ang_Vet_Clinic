package com.vet.clinic.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

@Repository
@Mapper
public interface SalesDAO {

	public List<Map<String, Object>> salesList(Map<String, String> paramap);
	
}
