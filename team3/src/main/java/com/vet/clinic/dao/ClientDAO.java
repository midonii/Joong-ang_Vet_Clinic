package com.vet.clinic.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.vet.clinic.dto.ClientDTO;

@Repository
@Mapper
public interface ClientDAO {

	public List<ClientDTO> petlist();

	public List<ClientDTO> clientlist();

	public List<ClientDTO> profileMap(ClientDTO client);

	public List<ClientDTO> clientDetailAjax(ClientDTO client);

	public int clientDel(ClientDTO client);

	public int petDel(ClientDTO client);

	public int cilentPetDel(ClientDTO client);

	public int clientAdd(ClientDTO client);



}
