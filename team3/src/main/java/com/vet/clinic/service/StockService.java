package com.vet.clinic.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.vet.clinic.dao.StockDAO;
import com.vet.clinic.dto.MedicalDTO;
import com.vet.clinic.dto.PageDTO;
import com.vet.clinic.dto.PetTypeDTO;
import com.vet.clinic.dto.SearchDTO;
import com.vet.clinic.dto.StockDTO;
import com.vet.clinic.dto.StockPageDTO;

@Service
public class StockService {
	
	@Autowired
	public StockDAO stockDAO;

	public List<StockDTO> stockList(Map<String, Object> map) {
		return stockDAO.stockList(map);
	}

	public List<String> m_company() {
		return stockDAO.m_company();
	}

	public List<String> m_subcate() {
		return stockDAO.m_subcate();
	}

	public List<Map<String, Object>> stockSelect(Map<String, Object> paramMap) {
		return stockDAO.stockSelect(paramMap);
	}
	

	public List<Map<String, Object>> stockDateSelect(Map<String, Object> paramMap) {
		return stockDAO.stockDateSelect(paramMap);
	}

	public int edit(Map<String, Object> paramMap) {
		return stockDAO.edit(paramMap);
	}

	public int totalcount() {
		return stockDAO.totalcount();
	}

	public ModelAndView paging(ModelAndView mv, int pagenum, int contentnum) {
		
		StockPageDTO pageDTO = new StockPageDTO();
		
		int totalcount = stockDAO.totalcount();
		
		pageDTO.setTotalcount(totalcount);
		pageDTO.setPagenum(pagenum);
		pageDTO.setLastPage(totalcount, contentnum);
		pageDTO.setCurrentBlockIdx(pagenum);
		pageDTO.setStartPageInBlock(pagenum, contentnum);
		pageDTO.setFirstnumInPage(contentnum);
//		System.out.println("시작페이지:" + pageDTO.getStartPageInBlock() + " / 마지막페이지:" + pageDTO.getLastPage());
		
		mv.addObject("page", pageDTO);
		
		return mv;
	}

	
	
}
