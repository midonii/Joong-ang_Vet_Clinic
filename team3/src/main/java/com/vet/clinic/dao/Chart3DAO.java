package com.vet.clinic.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.vet.clinic.dto.PetDTO;

@Repository
@Mapper
public interface Chart3DAO {

	public List<PetDTO> petChart(PetDTO petDTO);

	public int chartAdd(Map<String, Object> map);

	public int stateUpdate(Map<String, Object> map);

	public int chartUpdate(Map<String, Object> map);

	public int payAdd(Map<String, Object> payMap);

	public String chartNo(Map<String, Object> map);



}
