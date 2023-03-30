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


	public int reservAdd(ReservDTO reservDTO);

	public List<ReservDTO> reservlist(ReservDTO reservDTO);

	public List<ReservDTO> reservUpdate(ReservDTO reservDTO);

	public int reservUpdateSaved(ReservDTO reservDTO);

	public int delete_reservation_no(ReservDTO reservDTO);

	public List<ReservDTO> receplist(ReservDTO reservDTO);

	public int receiveAdd(ReservDTO reservDTO);

	public int search_receiveAdd(ReservDTO reservDTO);

	public int receiveAdd_reservYn(ReservDTO reservDTO);

	public int receiveDelete(ReservDTO reservDTO);

	public List<ReservDTO> reservTimeCheck(ReservDTO reservDTO);

	public List<ReservDTO> calender(ReservDTO reservDTO);

	public List<ReservDTO> reservlist_calender(ReservDTO reservDTO);

	public boolean checkPetNoExists(ReservDTO reservDTO);

	public List<ReservDTO> reservlist2(ReservDTO reservDTO);

//	public List<ReservDTO> reservationview2(ReservDTO reservDTO);

}
