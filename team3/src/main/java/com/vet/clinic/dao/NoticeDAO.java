package com.vet.clinic.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.vet.clinic.dto.NoticeDTO;

@Repository
@Mapper
public interface NoticeDAO {

	public List<NoticeDTO> noticeList(@Param("pagenum") int pagenum, @Param("contentnum") int contentnum,
			@Param("search_name") String search_name, @Param("search_value") String search_value);

	public int contentTotal(@Param("search_name") String search_name, @Param("search_value") String search_value);

	public int noticeWrite(Map<String, Object> map);

	public Map<String, Object> noticeDetail(int notice_no);

	public int noticeRead(int notice_no);

	public int noticeDelete(int notice_no);

	public int noticeUpdate(Map<String, Object> map);

}
