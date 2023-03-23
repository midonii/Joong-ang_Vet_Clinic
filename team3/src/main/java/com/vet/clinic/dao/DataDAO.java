package com.vet.clinic.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.vet.clinic.dto.MedicalDTO;
import com.vet.clinic.dto.PetTypeDTO;
import com.vet.clinic.dto.SearchDTO;

@Repository
@Mapper
public interface DataDAO {

	List<MedicalDTO> medicalList(@Param("pagenum") int pagenum, @Param("contentnum") int contentnum,
			@Param("search_name") String search_name, @Param("search_value") String search_value,
			@Param("table") String table, @Param("category") String category);

	int TotalCount(@Param("search_name") String search_name, @Param("search_value") String search_value,
			@Param("table") String table, @Param("category") String category);

	int mediAdd(Map<String, Object> map);

	List<PetTypeDTO> petTypeList(@Param("pagenum") int pagenum, @Param("contentnum") int contentnum,
			@Param("search_value") String search_value, @Param("table") String table,
			@Param("category") String category);

	int vaccineAdd(Map<String, Object> map);

	int petTypeAdd(Map<String, Object> map);

	int petTypeDel(int type_no);

	Map<String, Object> petTypeDetail(int type_no);

	int petTypeUpdate(Map<String, Object> map);

	Map<String, Object> medicalDetail(int medical_no);

	int medicalDel(int medical_no);

	int medicalUpdate(Map<String, Object> map);

	int TotalInspection(String search_value);

	List<String> category(SearchDTO searchDTO);

}
