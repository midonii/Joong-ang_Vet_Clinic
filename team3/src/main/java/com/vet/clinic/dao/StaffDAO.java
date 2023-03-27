package com.vet.clinic.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.vet.clinic.dto.StaffDTO;

@Repository
@Mapper
public interface StaffDAO {

	public List<StaffDTO> staffList(@Param("pagenum") int pagenum, @Param("contentnum") int contentnum,
			@Param("search_name") String search_name, @Param("search_value") String search_value);

	public int contentTotal(@Param("search_name") String search_name, @Param("search_value") String search_value);

	public StaffDTO login(Map<String, Object> map);

	public int findEmail(String email);

	public void saveTempnum(StaffDTO temp);

	public int idCheck(String id);

	public int emailCheck(String email);

	public Map<String, Object> profile(Map<String, Object> map);

	public int pwCheck(Map<String, Object> map);

	public int editProfile(Map<String, String> map);

	public void logintry(StaffDTO staffDTO);

	public Map<String, Object> staffDetail(int staff_no);

	public int gradeUpdate(Map<String, Object> map);

	public int staffDel(int staff_no);
	
	public int join(Map<String, String> map);

	public int checkTempnum(Map<String, String> map);

	public int newpwSet(Map<String, String> map);

	public int telCheck(String tel);
}
