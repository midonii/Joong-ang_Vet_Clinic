package com.vet.clinic.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

@Repository
@Mapper
public interface IndexDAO {
	public List<Map<String, Object>> indexReserv();

	public List<Map<String, Object>> indexNotice();

	public List<Map<String, Object>> indexPet(Map<String, Object> map);

	public int reservCount();

	public int recepCount();

	public int diagCount();

	public List<Map<String, Object>> indexpay();

	public List<Map<String, Object>> indexreceive();

}
