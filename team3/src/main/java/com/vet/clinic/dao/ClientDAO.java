package com.vet.clinic.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.vet.clinic.dto.ClientDTO;
import com.vet.clinic.dto.SearchDTO;

@Repository
@Mapper
public interface ClientDAO {

	public List<ClientDTO> petlist(SearchDTO search);

	public List<ClientDTO> clientlist(SearchDTO search);

	public List<ClientDTO> profileMap(ClientDTO client);

	public List<ClientDTO> clientDetailAjax(ClientDTO client);

	public int clientDel(ClientDTO client);

	public int petDel(ClientDTO client);

	public int cilentPetDel(ClientDTO client);

	public int clientAdd(ClientDTO client);

	public int clientUpdate(ClientDTO client);

	public List<ClientDTO> petTypeList(SearchDTO search);

	public int petAdd(Map<String, Object> map);

	public Map<String, Object> petUpdateAjax(Map<String, Object> map);

	public int petUpdate(Map<String, Object> map);

	public List<ClientDTO> clientPetDetailAjax(ClientDTO client);

	public void fileSave(Map<String, Object> map);

	public int fileUpdate(ClientDTO client);

	public Map<String, Object> petUpdateinfo(Map<String, Object> map);


}
