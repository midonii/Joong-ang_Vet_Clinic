package com.vet.clinic.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.vet.clinic.dao.PayDAO;
import com.vet.clinic.dto.PageDTO;
import com.vet.clinic.dto.PayDTO;

@Service
public class PayService {
	@Autowired
	private PayDAO payDAO;

	public PayDTO payDetail(int payNo) {
		return payDAO.payDetail(payNo);
	}

	public int payBefore(int payNo) {
		return payDAO.payBefore(payNo);
	}

	public int payCancel(int payNo) {
		return payDAO.payCancel(payNo);
	}

	// 페이징
	public ModelAndView paging(ModelAndView mv, String pagenum, String contentnum, PageDTO pageDTO) {
		int cpagenum = Integer.parseInt(pagenum);
		int ccontentnum = Integer.parseInt(contentnum);

		pageDTO.setTotalcount(payDAO.contentTotal(pageDTO)); // mapper 지정한다
		pageDTO.setPagenum(cpagenum - 1); // 현재 페이지를 페이지 객체에 지정한다 -1 을 해야 쿼리에서 사용할수 있다
		pageDTO.setContentnum(ccontentnum); // 한 페이지에 몇개씩 게시글을 보여줄지 지정한다.
		pageDTO.setCurrentblock(cpagenum); // 현재 페이지 블록이 몇번인지 현재 페이지 번호를 통해서 지정한다.
		pageDTO.setLastblock(pageDTO.getTotalcount()); // 마지막 블록 번호를 전체 게시글 수를 통해서 정한다.
		pageDTO.prevnext(cpagenum);// 현재 페이지 번호로 화살표를 나타낼지 정한다.
		pageDTO.setStartPage(pageDTO.getCurrentblock()); // 시작 페이지를 페이지 블록번호로 정한다.
		pageDTO.setEndPage(pageDTO.getLastblock(), pageDTO.getCurrentblock());
		// 마지막 페이지를 마지막 페이지 블록과 현재 페이지 블록 번호로 정한다.
		int pagenum2 = pageDTO.getPagenum() * 10; // 페이징시 데이터를 10개씩 자르기 위함
		pageDTO.setPagenum(pagenum2);

		List<PayDTO> payList = payDAO.payList(pageDTO);
		mv.addObject("payList", payList);
		mv.addObject("page", pageDTO);

		return mv;
	}


	public List<Map<String, Object>> indexPay(Map<String, Object> map) {
		return payDAO.indexPay(map);
	}
	
	
}
