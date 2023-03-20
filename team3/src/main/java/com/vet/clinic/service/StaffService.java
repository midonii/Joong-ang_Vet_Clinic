package com.vet.clinic.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.vet.clinic.dao.StaffDAO;
import com.vet.clinic.dto.PageDTO;
import com.vet.clinic.dto.SearchDTO;
import com.vet.clinic.dto.StaffDTO;

@Service
public class StaffService {

	
	@Autowired
	private StaffDAO staffDAO;
	

	public Map<String, Object> staffDetail(int staff_no) {
		return staffDAO.staffDetail(staff_no);
	}

	public int gradeUpdate(Map<String, Object> map) {
		return staffDAO.gradeUpdate(map);
	}

	public int staffDel(int staff_no) {
		return staffDAO.staffDel(staff_no);
	}

public ModelAndView paging(ModelAndView mv, String pagenum, String contentnum, SearchDTO searchDTO) {
		
		int cpagenum = Integer.parseInt(pagenum);
		int ccontentnum = Integer.parseInt(contentnum);

		PageDTO pageDTO = new PageDTO();
		pageDTO.setTotalcount(staffDAO.contentTotal(searchDTO.getSearch_name(), searchDTO.getSearch_value())); 
		pageDTO.setPagenum(cpagenum - 1); // 현재 페이지를 페이지 객체에 지정한다 -1 을 해야 쿼리에서 사용할수 있다
		pageDTO.setContentnum(ccontentnum); // 한 페이지에 몇개씩 게시글을 보여줄지 지정한다.
		pageDTO.setCurrentblock(cpagenum); // 현재 페이지 블록이 몇번인지 현재 페이지 번호를 통해서 지정한다.
		pageDTO.setLastblock(pageDTO.getTotalcount()); // 마지막 블록 번호를 전체 게시글 수를 통해서 정한다.

		pageDTO.prevnext(cpagenum);// 현재 페이지 번호로 화살표를 나타낼지 정한다.
		pageDTO.setStartPage(pageDTO.getCurrentblock()); // 시작 페이지를 페이지 블록번호로 정한다.
		pageDTO.setEndPage(pageDTO.getLastblock(), pageDTO.getCurrentblock());
		// 마지막 페이지를 마지막 페이지 블록과 현재 페이지 블록 번호로 정한다.

		List<StaffDTO> staffList = staffDAO.staffList(pageDTO.getPagenum() * 10, pageDTO.getContentnum(),
				searchDTO.getSearch_name(), searchDTO.getSearch_value());
		mv.addObject("staffList", staffList);
		mv.addObject("page", pageDTO);
		mv.addObject("search", searchDTO);

		return mv;
	}



}
