package com.vet.clinic.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.vet.clinic.dto.PayDTO;

@Repository
@Mapper
public interface PayDAO {

	List<PayDTO> payList();
	
}
