package com.vet.clinic.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.vet.clinic.dto.StaffDTO;

@Repository
@Mapper
public interface StaffDAO {

	public List<StaffDTO> staffList();

	public StaffDTO login(StaffDTO staffDTO);

	public int findEmail(String email);

	public void saveTempnum(StaffDTO temp);

	public int checkTempnum(StaffDTO check);

	public int newpwSet(StaffDTO newpwSet);

	public Map<String, Object> staffDetail(int staff_no);

	public int gradeUpdate(Map<String, Object> map);

	public int staffDel(int staff_no);


}
