package com.vet.clinic.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.vet.clinic.dao.DataDAO;
import com.vet.clinic.dto.MedicalDTO;
import com.vet.clinic.dto.PageDTO;
import com.vet.clinic.dto.PetTypeDTO;
import com.vet.clinic.dto.SearchDTO;

@Service
public class DataService {

	@Autowired
	private DataDAO dataDAO;

	public int mediAdd(Map<String, Object> map) {
		return dataDAO.mediAdd(map);
	}

	public int vaccineAdd(Map<String, Object> map) {

		return dataDAO.vaccineAdd(map);
	}

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

	public ModelAndView paging(ModelAndView mv, String pagenum, String contentnum, SearchDTO searchDTO) {

		PageDTO pageDTO = new PageDTO();

		int cpagenum = Integer.parseInt(pagenum);
		int ccontentnum = Integer.parseInt(contentnum);

		pageDTO.setTotalcount(
				dataDAO.TotalCount(searchDTO.getSearch_name(),searchDTO.getSearch_value(), searchDTO.getTable(), searchDTO.getCategory())); // 전체
																													// 게시글
																													// 개수
		pageDTO.setPagenum(cpagenum - 1); // 현재 페이지를 페이지 객체에 지정한다 -1 을 해야 쿼리에서 사용할수 있다
		pageDTO.setContentnum(ccontentnum); // 한 페이지에 몇개씩 게시글을 보여줄지 지정한다.
		pageDTO.setCurrentblock(cpagenum); // 현재 페이지 블록이 몇번인지 현재 페이지 번호를 통해서 지정한다.
		pageDTO.setLastblock(pageDTO.getTotalcount()); // 마지막 블록 번호를 전체 게시글 수를 통해서 정한다.

		pageDTO.prevnext(cpagenum);// 현재 페이지 번호로 화살표를 나타낼지 정한다.
		pageDTO.setStartPage(pageDTO.getCurrentblock()); // 시작 페이지를 페이지 블록번호로 정한다.
		pageDTO.setEndPage(pageDTO.getLastblock(), pageDTO.getCurrentblock());
		// 마지막 페이지를 마지막 페이지 블록과 현재 페이지 블록 번호로 정한다.

		List<MedicalDTO> medicalList = dataDAO.medicalList(pageDTO.getPagenum() * 10, pageDTO.getContentnum(),
				searchDTO.getSearch_name(), searchDTO.getSearch_value(), searchDTO.getTable(), searchDTO.getCategory());
		List<MedicalDTO> vaccineList = dataDAO.vaccineList(pageDTO.getPagenum() * 10, pageDTO.getContentnum(),
				searchDTO.getSearch_value(), searchDTO.getTable(), searchDTO.getCategory());
		List<PetTypeDTO> petTypeList = dataDAO.petTypeList(pageDTO.getPagenum() * 10, pageDTO.getContentnum(),
				searchDTO.getSearch_value(), searchDTO.getTable(), searchDTO.getCategory());

		mv.addObject("medicalList", medicalList);
		mv.addObject("vaccineList", vaccineList);
		mv.addObject("petTypeList", petTypeList);
		mv.addObject("page", pageDTO);
		mv.addObject("search", searchDTO);

		return mv;
	}

	public List<String> category(SearchDTO searchDTO) {
		return dataDAO.category(searchDTO);
	}

}
