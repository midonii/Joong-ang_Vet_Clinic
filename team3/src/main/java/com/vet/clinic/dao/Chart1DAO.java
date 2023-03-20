package com.vet.clinic.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

@Repository
@Mapper
public interface Chart1DAO {


	Map<String, Object> petdetailAjax(String receiveno);

	List<Map<String, Object>> prescAjax();

	List<Map<String, Object>> prescAjaxvac();



}
