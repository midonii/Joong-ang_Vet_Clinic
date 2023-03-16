package com.vet.clinic.service;

import java.util.List;

import javax.annotation.Resource;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.stereotype.Service;

import com.vet.clinic.dao.PetDAO;
import com.vet.clinic.dto.PetDTO;


@Service
public class PetService {
	
	@Resource(name = "petDAO")
	private PetDAO petDAO;

	public List<PetDTO> petInfo(PetDTO petDTO) {
		return petDAO.petInfo(petDTO);
	}

	public List<PetDTO> petVaccine(PetDTO petDTO) {
		return petDAO.petVaccine(petDTO);
	}

	public List<PetDTO> excelList(PetDTO petDTO) {
		return petDAO.excelList(petDTO);
	}


	
	
	





}
