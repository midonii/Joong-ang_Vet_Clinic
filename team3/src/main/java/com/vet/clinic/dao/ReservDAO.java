package com.vet.clinic.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.vet.clinic.dto.ReservDTO;

@Repository
@Mapper
public interface ReservDAO {

	public List<ReservDTO> boardlist(ReservDTO reservDTO);

	public List<ReservDTO> searchlist(ReservDTO reservDTO);

	public List<ReservDTO> reservAjax(ReservDTO reservDTO);

}
