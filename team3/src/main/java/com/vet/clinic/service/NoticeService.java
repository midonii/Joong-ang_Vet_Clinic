package com.vet.clinic.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.servlet.ModelAndView;

import com.vet.clinic.dao.NoticeDAO;
import com.vet.clinic.dto.NoticeDTO;
import com.vet.clinic.dto.PageDTO;
import com.vet.clinic.dto.SearchDTO;

@Service
public class NoticeService {

	@Autowired
	private NoticeDAO noticeDAO;

	public int noticeWrite(Map<String, Object> map) {
		return noticeDAO.noticeWrite(map);
	}

	public Map<String, Object> noticeDetail(int notice_no) {
		return noticeDAO.noticeDetail(notice_no);
	}

	public int noticeRead(int notice_no) {
		return noticeDAO.noticeRead(notice_no);
	}

	public int noticeDelete(int notice_no) {
		return noticeDAO.noticeDelete(notice_no);
	}

	public int noticeUpdate(Map<String, Object> map) {
		return noticeDAO.noticeUpdate(map);
	}

	public ModelAndView paging(ModelAndView mv, String pagenum, String contentnum, SearchDTO searchDTO) {
		
		int cpagenum = Integer.parseInt(pagenum);
		int ccontentnum = Integer.parseInt(contentnum);

		PageDTO pageDTO = new PageDTO();
		pageDTO.setTotalcount(noticeDAO.contentTotal(searchDTO.getSearch_name(), searchDTO.getSearch_value())); // mapper
		// 지정한다
		pageDTO.setPagenum(cpagenum - 1); // 현재 페이지를 페이지 객체에 지정한다 -1 을 해야 쿼리에서 사용할수 있다
		pageDTO.setContentnum(ccontentnum); // 한 페이지에 몇개씩 게시글을 보여줄지 지정한다.
		pageDTO.setCurrentblock(cpagenum); // 현재 페이지 블록이 몇번인지 현재 페이지 번호를 통해서 지정한다.
		pageDTO.setLastblock(pageDTO.getTotalcount()); // 마지막 블록 번호를 전체 게시글 수를 통해서 정한다.

		pageDTO.prevnext(cpagenum);// 현재 페이지 번호로 화살표를 나타낼지 정한다.
		pageDTO.setStartPage(pageDTO.getCurrentblock()); // 시작 페이지를 페이지 블록번호로 정한다.
		pageDTO.setEndPage(pageDTO.getLastblock(), pageDTO.getCurrentblock());
		// 마지막 페이지를 마지막 페이지 블록과 현재 페이지 블록 번호로 정한다.

		List<NoticeDTO> noticeList = noticeDAO.noticeList(pageDTO.getPagenum() * 10, pageDTO.getContentnum(),
				searchDTO.getSearch_name(), searchDTO.getSearch_value());

		mv.addObject("noticeList", noticeList);
		mv.addObject("page", pageDTO);
		mv.addObject("search", searchDTO);

		return mv;
	}

}
