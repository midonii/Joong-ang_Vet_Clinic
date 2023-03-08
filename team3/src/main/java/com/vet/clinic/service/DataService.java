package com.vet.clinic.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.vet.clinic.dao.DataDAO;
import com.vet.clinic.dto.MedicalDTO;
import com.vet.clinic.dto.PetTypeDTO;

@Service
public class DataService {

	@Autowired
	private DataDAO dataDAO;



	public List<MedicalDTO> medicineList() {
		return dataDAO.medicineList();
	}

	public List<MedicalDTO> inspectionList() {
		return dataDAO.inspectionList();
	}

	public int mediAdd(Map<String, Object> map) {
		return dataDAO.mediAdd(map);
	}

	public List<MedicalDTO> vaccineList() {
		return dataDAO.vaccineList();
	}

	public int vaccineAdd(Map<String, Object> map) {
		
		return dataDAO.vaccineAdd(map);
	}

	public List<MedicalDTO> petTypeList() {
		return dataDAO.petTypeList();
	}
//	public List<MedicalDTO> petTypeList(Criteria cri) {
//		return dataDAO.petTypeList(cri);
//	}

	public int petTypeAdd(Map<String, Object> map) {
		return dataDAO.petTypeAdd(map);
	}

	public int petTypeDel(int type_no) {
		return dataDAO.petTypeDel(type_no);
	}

	public Map<String, Object> petTypeDetail(int type_no) {
		return dataDAO.petTypeDetail(type_no);
	}

	public int petTypeUpdate(Map<String, Object> map) {
		return dataDAO.petTypeUpdate(map);
	}

	public Map<String, Object> medicalDetail(int medical_no) {
		return dataDAO.medicalDetail(medical_no);
	}

	public int medicalDel(int medical_no) {
		return dataDAO.medicalDel(medical_no);
	}

	public int medicalUpdate(Map<String, Object> map) {
		return dataDAO.medicalUpdate(map);
	}

	public int vaccineDel(int vac_no) {
		return dataDAO.vaccineDel(vac_no);
	}

	public Map<String, Object> vaccineDetail(int vac_no) {
		return dataDAO.vaccineDetail(vac_no);
	}

	public int vaccineUpdate(Map<String, Object> map) {
		return dataDAO.vaccineUpdate(map);
	}


}
