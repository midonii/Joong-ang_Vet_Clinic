package com.vet.clinic.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.vet.clinic.dao.ClientDAO;
import com.vet.clinic.dto.ClientDTO;


@Service
public class ClientService {

	
	@Resource(name = "clientDAO")
	private ClientDAO clientDAO;

	public List<ClientDTO> clientList() {
		return clientDAO.clientlist();
	}

	public List<ClientDTO> petList() {
		return clientDAO.petlist();
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

	public List<ClientDTO> petTypeList() {
		return clientDAO.petTypeList();
	}

	public int petAdd(Map<String, Object> map) {
		return clientDAO.petAdd(map);
	}

	public List<Map<String, Object>> indexPet(Map<String, Object> map) {
		return clientDAO.indexPet(map);
	}

	





}
