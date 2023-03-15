package com.vet.clinic.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.vet.clinic.dto.ReservDTO;

@Repository
@Mapper
public interface ReservDAO {

	public List<ReservDTO> boardlist(ReservDTO reservDTO);

	public List<ReservDTO> searchlist(ReservDTO reservDTO);

	public List<ReservDTO> reservAjax(ReservDTO reservDTO);


	public int reservAdd(ReservDTO reservDTO);

	public List<ReservDTO> reservlist(ReservDTO reservDTO);

	public List<Map<String, Object>> indexReserv(Map<String, Object> map);

	public List<Map<String, Object>> receivepay(Map<String, Object> map);


}
