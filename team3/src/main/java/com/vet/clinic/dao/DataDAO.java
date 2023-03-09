package com.vet.clinic.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.vet.clinic.dto.MedicalDTO;
import com.vet.clinic.dto.PetTypeDTO;

@Repository
@Mapper
public interface DataDAO {


	List<MedicalDTO> medicineList();

	List<MedicalDTO> inspectionList();

	int mediAdd(Map<String, Object> map);

	List<MedicalDTO> vaccineList();

	int vaccineAdd(Map<String, Object> map);

	List<PetTypeDTO> petTypeList(@Param("pagenum") int pagenum, @Param("contentnum") int contentnum);

	int petTypeAdd(Map<String, Object> map);

	int petTypeDel(int type_no);

	Map<String, Object> petTypeDetail(int type_no);

	int petTypeUpdate(Map<String, Object> map);

	Map<String, Object> medicalDetail(int medical_no);

	int medicalDel(int medical_no);

	int medicalUpdate(Map<String, Object> map);

	int vaccineDel(int vac_no);

	Map<String, Object> vaccineDetail(int vac_no);

	int vaccineUpdate(Map<String, Object> map);

	int TotalPetType();

	
}
