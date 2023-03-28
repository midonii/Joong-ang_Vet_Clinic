package com.vet.clinic.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.vet.clinic.dao.ClientDAO;
import com.vet.clinic.dto.ClientDTO;
import com.vet.clinic.dto.SearchDTO;

@Service
public class ClientService {

	@Resource(name = "clientDAO")
	private ClientDAO clientDAO;

	public List<ClientDTO> clientList(SearchDTO search) {
		return clientDAO.clientlist(search);
	}

	public List<ClientDTO> petList(SearchDTO search) {
		return clientDAO.petlist(search);
	}

	public List<ClientDTO> profileMap(ClientDTO client) {
		return clientDAO.profileMap(client);
	}

	public List<ClientDTO> clientDetailAjax(ClientDTO client) {
		return clientDAO.clientDetailAjax(client);
	}

	public int clientDel(ClientDTO client) {
		return clientDAO.clientDel(client);
	}

	public int petDel(ClientDTO client) {
		return clientDAO.petDel(client);
	}

	public int cilentPetDel(ClientDTO client) {
		return clientDAO.cilentPetDel(client);
	}

	public int clientAdd(ClientDTO client) {
		return clientDAO.clientAdd(client);
	}

	public int clientUpdate(ClientDTO client) {
		return clientDAO.clientUpdate(client);
	}

	public List<ClientDTO> petTypeList(SearchDTO search) {
		return clientDAO.petTypeList(search);
	}

	public int petAdd(Map<String, Object> map) {
		return clientDAO.petAdd(map);
	}

	public Map<String, Object> petUpdateAjax(Map<String, Object> map) {
		return clientDAO.petUpdateAjax(map);
	}

	public int petUpdate(Map<String, Object> map) {
		return clientDAO.petUpdate(map);
	}

	public List<ClientDTO> clientPetDetailAjax(ClientDTO client) {
		return clientDAO.clientPetDetailAjax(client);
	}

	public void fileSave(Map<String, Object> map) {
		clientDAO.fileSave(map);
	}

	public int fileUpdate(ClientDTO client) {
		return clientDAO.fileUpdate(client);
	}

	public Map<String, Object> petUpdateinfo(Map<String, Object> map) {
		return clientDAO.petUpdateinfo(map);
	}

	public int fileNewInsert(ClientDTO client) {
		return clientDAO.fileNewInsert(client);
	}

	public int fileImgDel(ClientDTO client) {
		return clientDAO.fileImgDel(client);
	}

	public List<ClientDTO> ownerCheck(ClientDTO client) {
		return clientDAO.ownerCheck(client);
	}


}
