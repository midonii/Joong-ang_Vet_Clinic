package com.vet.clinic.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.vet.clinic.dto.SearchDTO;

@Repository
@Mapper
public interface Chart1DAO {


	public Map<String, Object> petdetailAjax(String receiveno);

	public List<Map<String, Object>> prescAjax(SearchDTO searchDTO);

	public List<Map<String, Object>> prescSaveAjax(Map<String, Object> rightno_map);




}
