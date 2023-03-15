package com.vet.clinic.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.vet.clinic.dao.ReservDAO;
import com.vet.clinic.dto.ReservDTO;

@Service
public class ReservService {

	@Autowired
	private ReservDAO reservDAO;
	
	
	public List<ReservDTO> boardlist(ReservDTO reservDTO){
		return reservDAO.boardlist(reservDTO);
	}


	public List<ReservDTO> searchlist(ReservDTO reservDTO) {
		return reservDAO.searchlist(reservDTO);
	}


	public List<ReservDTO> reservAjax(ReservDTO reservDTO) {
		return reservDAO.reservAjax(reservDTO);
	}


	public List<Map<String, Object>> indexReserv(Map<String, Object> map) {
		return reservDAO.indexReserv(map);
	}


	public List<Map<String, Object>> receivepay(Map<String, Object> map) {
		return reservDAO.receivepay(map);
	}
}
